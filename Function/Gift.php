<?php

class Gift extends Controller
{

    public function api_calculate_charging_fees(Request $request){
        $validation_rules = [
            'type'=>'required|in:PG_creditcard,PG_phone',
            'amount'=>'required|numeric|min:0'
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

        $type = $request->type;
        $amount = (int)$request->amount;

        $km_charging_rate = KmChargingRate::where("type", $type)->first();
        $rate = $km_charging_rate==null ? 0:$km_charging_rate->rate;
        $fee = 0;
        if($rate>0){
            $fee = $amount * ($rate/100);
        }
        return response()->json([
            'status' => true,
            'error' => "",
            'data' => [
                "amount" => $amount,
                "rate" => $rate,
                "fee" => $fee
            ]
        ], 200);

    }

    public function api_kong_mileage(Request $request){

        $user = User::getUserUsingAccessToken($request->access_token);
        $data = [];
        $data["kong"] = $user->kong ? $user->kong : 0;
        $data["bonus_kong"] = $user->bonus_kong ? $user->bonus_kong : 0;
        $data["total"] = $data["kong"] + $data["bonus_kong"];
        return response()->json([
            'status' => true,
            'error' => '',
            'data' => $data
        ], 200);
    }
    public function api_kong_mileage_detail(Request $request){
        $offset = $request->offset ? $request->offset : 0;
        $limit = $request->limit ? $request->limit : 10;
        $category_type = $request->category_type ? $request->category_type : "";
        $access_token = AccessToken::where("token", $request->access_token)->first();
        if($access_token!=null){
            $user_id = $access_token->user_id;
            $kmTransactions = KmTransaction::where("user_id",$user_id)->orderBy("id", "desc");
            if($category_type != ""){
                $kmTransactionCode = KmTransactionCode::where('code',$category_type)->first();
                $kmTransactions = !empty($kmTransactionCode) ? $kmTransactions->where('km_transaction_code_id',$kmTransactionCode->id) : $kmTransactions;
            }

            $kmTransactions = $kmTransactions->limit($limit)->offset($offset)->get();

            $data = [];
            foreach($kmTransactions as $kmTransaction){
                $kmTransactionCode = $kmTransaction->KmTransactionCode ? $kmTransaction->KmTransactionCode : '';
                $short_name_kr = $kmTransactionCode ? $kmTransactionCode->short_name_kr : '';
                $full_name_kr = $kmTransactionCode ? $kmTransactionCode->full_name_kr : '';
                $categoryCode = $kmTransactionCode ? $kmTransactionCode->code : '';
                $date = $kmTransaction->date != '' ? date("Y m d", strtotime($kmTransaction->date)):'';
                $accumulated_km = $kmTransaction->accumulated_km ? $kmTransaction->accumulated_km : "0";
                $used_km = $kmTransaction->used_km ? $kmTransaction->used_km : "0";
                if($kmTransaction->km_transaction_code_id==4){
                    $paid_amount = "0";
                }else{
                    $paid_amount = $kmTransaction->paid_amount ? $kmTransaction->paid_amount : "0";
                }
                $converted_amount = $kmTransaction->charged_km ? $kmTransaction->charged_km : "0";
                $description = $kmTransaction->description ? $kmTransaction->description : '';
                $type = $kmTransaction->type ? $kmTransaction->type : '';
                $giftSenderNickname = $kmTransaction->gift_sender_nickname ? $kmTransaction->gift_sender_nickname : '';
                $giftSenderEmail = $kmTransaction->gift_sender_email ? $kmTransaction->gift_sender_email : '';
                $giftReceiverNickname = $kmTransaction->gift_receiver_nickname ? $kmTransaction->gift_receiver_nickname : '';
                $giftReceiverEmail = $kmTransaction->gift_receiver_email ? $kmTransaction->gift_receiver_email : '';
                $km_transaction_type = $kmTransaction->KmTransactionCode!=null ? strtolower($kmTransaction->KmTransactionCode->short_name_en) : '';

                $timestamps = $kmTransaction->date != '' ? date("Y m d H:i:s", strtotime($kmTransaction->date)):'';
                array_push($data, array(
                    "id"=> $kmTransaction->id,
                    "short_name_kr"=> $short_name_kr,
                    "full_name_kr"=> $full_name_kr,
                    "date"=>$date,
                    "accumulated_km"=>$accumulated_km,
                    "used_km"=>$used_km,
                    "timestamps"=>$timestamps,
                    "converted_amount"=>$converted_amount,
                    "gift_sender_nickname"=>$giftSenderNickname,
                    "gift_receiver_nickname"=>$giftReceiverNickname,
                    "category_code"=>$categoryCode,
                    "gift_sender_email"=>$giftSenderEmail,
                    "gift_receiver_email"=>$giftReceiverEmail,
                    "paid_amount"=>$paid_amount,
                    "description"=>$description,
                    "type"=>$type,
                    "km_transaction_type"=>$km_transaction_type
                ));

            }
            return response()->json([
                'status' => true,
                'error' => '',
                'data' => $data
            ], 200);
        }else{
            return response()->json([
                'status' => false,
                'error' => '',
                'message' => "Invalid request."
            ], 422);
        }
    }

    public function api_kong_mileage_category(Request $request){
        $kmTransactionCodes = KmTransactionCode::get();
        
        $data = [];
        foreach($kmTransactionCodes as $kmTransactionCode){
            $code = $kmTransactionCode->code ? $kmTransactionCode->code : '';
            $short_name_kr = $kmTransactionCode->short_name_kr ? $kmTransactionCode->short_name_kr : '';
            $short_name_en = $kmTransactionCode->short_name_en ? $kmTransactionCode->short_name_en : '';
            $full_name_kr = $kmTransactionCode->full_name_kr ? $kmTransactionCode->full_name_kr : '';
            $full_name_en = $kmTransactionCode->full_name_en ? $kmTransactionCode->full_name_en : '';
            array_push($data, array(
                "id"=> $kmTransactionCode->id,
                "code"=>$code ,
                "short_name_kr"=>$short_name_kr ,
                "short_name_en"=>$short_name_en ,
                "full_name_kr"=>$full_name_kr ,
                "full_name_en"=>$full_name_en 
            ));

        }
        return response()->json([
            'status' => true,
            'error' => '',
            'data' => $data
        ], 200);
    }

    public function api_km_gift(Request $request){
        $validation_rules = [
            'receiver_id'=>'required',
            'amount'=>'required|numeric|min:100'
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

        $sender = User::getUserUsingAccessToken($request->access_token);
        $sender_kong = $request->amount;
        $available_balance = $sender->kong;
        if($sender_kong>$available_balance){
            return response()->json([
                'error' => "Invalid request.",
                'description' => "Insufficient kong balance."
            ], 422);
        }

        //check number of gift transactions in current month.
        $monthly_km_gift_transactions = KmTransaction::where("km_transaction_code_id", '3')->where('user_id',$sender->id)->where("date", ">=", date("Y-m-01"))->where("date", "<=", date("Y-m-t"))->get();
        $monthly_km_gift_count = ($monthly_km_gift_transactions==null) ? 0:$monthly_km_gift_transactions->count();
        if($monthly_km_gift_count==3){
            return response()->json([
                'error' => "Monthly limit ended",
                'description' => "User cannot send gift more than three times in a month."
            ], 422);
        }

        $sender->kong = $sender->kong - $sender_kong;
        $sender->save();
        
        $previousMonth = Carbon::now()->subMonth(1);
        $todayDate = Carbon::now();

        $kmTransactionCount = KmTransaction::where('user_id',$sender->id)->where('used_km', '!=','')->whereBetween('date',[$previousMonth,$todayDate])->count();
        
        $receiver = User::find($request->receiver_id);
        $receiver->kong = $receiver->kong + $request->amount;
        $receiver->save();

        $kmTransaction = new KmTransaction();
        $kmTransaction->type = "마일리지 선물";
        $kmTransaction->user_id = $sender->id;
        $kmTransaction->used_km = $request->amount;
        $kmTransaction->gift_sender_email = $sender->email ? $sender->email : '';
        $kmTransaction->gift_receiver_email = $receiver->email ? $receiver->email : '';
        $kmTransaction->tmoa_res_result = 'S';
        $kmTransaction->km_transaction_code_id  = 3;
        $kmTransaction->gift_sender_nickname  = $sender->nick_name ? $sender->nick_name : '';
        $kmTransaction->gift_receiver_nickname  = $receiver->nick_name ? $receiver->nick_name : '';
        $kmTransaction->date  = date('Y-m-d H:i:s');
        $kmTransaction->description = $receiver->email." 님께 마일리지 선물";
        $kmTransaction->converted_amount  = 0;
        $kmTransaction->save();

        $kmTransaction = new KmTransaction();
        $kmTransaction->type = "마일리지 선물받기";
        $kmTransaction->user_id = $request->receiver_id;
        $kmTransaction->accumulated_km = $request->amount;
        $kmTransaction->gift_sender_email = $sender->email ? $sender->email : '';
        $kmTransaction->gift_receiver_email = $receiver->email ? $receiver->email : '';
        $kmTransaction->tmoa_res_result = 'S';
        $kmTransaction->km_transaction_code_id  = 3;
        $kmTransaction->gift_sender_nickname  = $sender->nick_name ? $sender->nick_name : '';
        $kmTransaction->gift_receiver_nickname  = $receiver->nick_name ? $receiver->nick_name : '';
        $kmTransaction->date  = date('Y-m-d H:i:s');
        $kmTransaction->paid_amount  = 0;
        $kmTransaction->description = $sender->email." 으로부터 마일리지 선물";
        $kmTransaction->save();

        $kong = $sender->kong ? $sender->kong : 0;
        $bonus_kong = $sender->bonus_kong ? $sender->bonus_kong : 0;
        $total = $kong + $bonus_kong;

        $monthly_km_gift_count++;
        if($monthly_km_gift_count==3){
            app(\App\Http\Controllers\SettingController::class)->commonSetting($sender->id,'gift');
        }
        
        return response()->json([
            'status' => true,
            'error' => '',
            'data' => $total
        ], 200);

    }
    
    
}
