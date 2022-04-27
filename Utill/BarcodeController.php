<?php

namespace App\Http\Controllers;

class BarcodeController extends Controller
{

    public function barcodelist(Request $request){
        $user = User::getUserUsingAccessToken($request->access_token);

        $validation_rules = [
            'orderid'=>'required',
            'stock_number'=>'required'
        ];

        $validator = Validator::make($request->all(), $validation_rules);
        if ($validator->fails()) {
            $errors = $validator->errors();
            $arr_errors = $errors->all();
            return response()->json([
                'error' => "Validation failed",
                'description' => $arr_errors
            ], 422);
        }

        $order = Order::find($request->orderid);
        if($order==null){
            return response()->json([
                'error' => 'Invalid request'
            ], 422);
        }

        $order_detail = $order->OrderDetail;
        $stock_id = [];
        foreach($order_detail as $key=>$record){
            array_push($stock_id, $record->stock_id);
        }

        $stock_number = $request->stock_number;
        $stock = Stock::where("stock_number", $stock_number)->whereIn("id", $stock_id)->first();
        if($stock==null){
            return response()->json([
                'error' => 'Invalid request'
            ], 422);
        }

		if($user->id!=$order->user_id){
            return response()->json([
                'error' => "Invalid request"
            ], 422);
        }

		$content = Content::find($order->content_id);
        $file_path = 'public/barcode_image/'.$stock->stock_number.'.png';
        if(file_exists(storage_path('app/'.$file_path))==false){
            $barsColor = [0, 0, 0];
            $generator = new BarcodeGeneratorPNG();
            file_put_contents(storage_path('app/'.$file_path), $generator->getBarcode($stock->stock_number, $generator::TYPE_CODE_128, 2, 95, $barsColor));
        }
        $url = url($file_path);

        $is_used = Content::getEpinStatus($stock, $content->contents_provider_id);

        $data = array(
            "url"=>$url,
            "order_id"=>$order->id,
            "order_title"=>$order->title,
            "content_title"=>$content->title,
            "content_price"=>$content->sale_price,
            "quantity"=>$order->quantity,
            "sales_price"=>$order->sales_price,
            "content_thumbnail_image"=>url($content->stored_thumb_image),
            "expiry_date"=>date("Y-m-d H:i:s",strtotime($stock->exp_to)),
            "stock_number"=>$stock_number,
            "created_at"=>date("Y-m-d H:i:s",strtotime($order->created_at)),
            "is_used"=>$is_used,
            "is_use_button" => ($content->show_use_button=='Y' && $is_used!='Y') ? true:false
        );

        return response()->json([
            'status' => true,
            'error' => '',
            'data' => $data
        ], 200);

	}

	public function api_mark_as_used(Request $request){
        $user = User::getUserUsingAccessToken($request->access_token);

        $validation_rules = [
            'order_id'=>'required',
            'stock_number'=>'required'
        ];

        $validator = Validator::make($request->all(), $validation_rules);
        if ($validator->fails()) {
            $errors = $validator->errors();
            $arr_errors = $errors->all();
            return response()->json([
                'error' => "Validation failed",
                'description' => $arr_errors
            ], 422);
        }

        $stock_number = $request->stock_number;
        $stock = Stock::where("stock_number", $stock_number)->where("use", "!=", "Y")->first();
        if($stock==null){
            return response()->json([
                'error' => 'Invalid request'
            ], 422);
        }

        $order_id = $request->order_id;
        $order = Order::find($order_id);
        if($order==null){
            return response()->json([
                'error' => 'Invalid request'
            ], 422);
        }

        if($order->user_id!=$user->id){
            return response()->json([
                'error' => 'Invalid request'
            ], 422);
        }

        $stock->use = 'Y';
        $stock->use_date = date("Y-m-d H:i:s");
        $stock->save();

        return response()->json([
            'status'=> false,
            'error' => '',
            'message' => "Request completed successfully."
        ], 200);

    }

}
