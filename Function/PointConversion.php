<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use \App\Models\KmTransaction;
use \App\Models\Merchant;
use Illuminate\Support\Facades\Validator;
use DataTables;
use App\User;
use App;
use App\Models\KmConversionRate;

class PointConversion extends Controller
{
    public function start(Request $request){
        $user_id = $request->USERID;
        $lang = $request->LANG=='' ? 'ko':$request->LANG;
        App::setLocale($lang);
        $user = User::find($user_id);
        if($user==null){
            abort(404);
        }
        return view("mn_conversion_start", compact('user_id'));
    }

    public function userurl(Request $request){
        $result = $request->RESULT;
        $order_id = $request->ORDERID;
        $user_id = $request->USERID;

        $user = User::find($user_id);
        if($user==null){
            abort(404);
        }
        $km_transaction = KmTransaction::where("user_id", $user->id)->orderBy("id", "desc")->first();
        $km_amount = $amount = $km_transaction->accumulated_km;
        $total = $user->kong + $user->bonus_kong;

        return view("mn_userurl", compact('result', 'order_id', 'user_id', 'amount', 'km_amount', 'total'));
    }

    //Mn Conversion API.
    public function returnurl(Request $request){
        $contents = '';
        if(file_exists("mn_api_response.txt")){
            $contents = file_get_contents("mn_api_response.txt");
        }
        $new_contents = $contents."\n".json_encode($_REQUEST);
        file_put_contents("mn_api_response.txt",$new_contents);

        $sid = $request->SID;
        $user_id = $request->USERID;
        $order_id = $request->ORDERID;
        $transaction_id = $request->TRANSACTIONID;
        $amount = $request->AMOUNT;
        $convert_amount = $request->CONVERT_AMOUNT;
        $ratio = $request->RATIO;
        $unit = $request->UNIT;

        //Feature #3008: Change the KM conversion rate
        $km_conversion_rate = KmConversionRate::where("type", "=", 'mn')->first();
        if($km_conversion_rate!=null){
            $converted_km = ceil($amount * ($km_conversion_rate->rate/100) );
        }else{
            $converted_km = $amount;
        }

        try{
            $kmTransaction = new KmTransaction();
            $kmTransaction->type = 'Point Conversion';
            $kmTransaction->description = 'OKCashback';
            $kmTransaction->date = date("Y-m-d H:i:s");
            $kmTransaction->accumulated_km = $converted_km;
            $kmTransaction->user_id = $user_id;
            $kmTransaction->km_transaction_code_id = 1;
            $kmTransaction->paid_amount = $amount;
            $kmTransaction->tmoa_res_order_id = $order_id;
            $kmTransaction->tmoa_res_transaction_id = $transaction_id;
            $kmTransaction->tmoa_req_amount = $amount;
            $kmTransaction->converted_amount = $converted_km;
            $kmTransaction->service_provider_id = 1;
            $kmTransaction->save();

            $user = User::find($user_id);
            $userKong = $user->kong != "" ? $user->kong : 0;
            $user->kong = $userKong + $converted_km;
            $user->save();

            app(\App\Http\Controllers\SettingController::class)->commonSetting($user->id, 'conversion');

        }catch(Exception $ex){
            return response()->json([
                'status' => false,
            ]);
        }

        return response()->json([
            'status' => true,
        ]);

    }

    public function webview(Request $request){
        $amount = $request->AMOUNT;
        $provider_id = ($request->PROVIDERID=='') ? 1:$request->PROVIDERID;
        $user_id = $request->USERID;
        $lang = $request->LANG=='' ? 'ko':$request->LANG;
        App::setLocale($lang);
        $user = User::find($user_id);
        if($user==null){
            abort(404);
        }
        $merchant = Merchant::find($provider_id);
        if($merchant==null){
            abort(404);
        }
        //TYPE=1 for desktop version.
        $url = ($request->TYPE=='1') ? '/point/ClipPointPayAction.do':'/point/MbClipPointPayAction.do';
        return view("mn_conversion_settlebank", compact('user_id', 'merchant', 'lang', 'user', 'amount', 'url'));
    }

    public function pay_rcv(Request $request, $lang, $USERID, $PROVIDERID){
        sleep(3);
        App::setLocale($lang);

        $P_STATUS;
        $P_TR_NO;
        $P_AUTH_DT;
        $P_AUTH_NO;
        $P_TYPE;
        $P_MID;
        $P_OID;
        $P_AMT;
        $P_HASH;
        $P_DATA;

        $P_STATUS    = $request->PStateCd;   // 거래상태 : 0021(성공), 0031(실패), 0051(입금대기중)
        $P_TR_NO     = $request->PTrno;      // 거래번호
        $P_AUTH_DT   = $request->PAuthDt;    // 승인시간
        $P_AUTH_NO   = $request->PAuthNo;    // 승인번호
        $P_TYPE      = $request->PType;      // 거래종류 (CARD, BANK, MOBILE, VBANK)
        $P_MID       = $request->PMid;       // 회원사아이디
        $P_OID       = $request->POid;       // 주문번호
        $P_AMT       = $request->PAmt;       // 거래금액
        $P_HASH      = $request->PHash;      // HASH 코드값
        $P_DATA      = $P_STATUS.$P_TR_NO.$P_AUTH_DT.$P_TYPE.$P_MID.$P_OID.$P_AMT;

        $user = User::find($USERID);
        if($user==null){
            abort(404);
        }

        if($P_STATUS=="0031"){
            return view('payment.canceled');
        }else{
            $km_transaction = KmTransaction::where("user_id", $user->id)->where("km_transaction_code_id", 1)->orderBy("date", "desc")->first();
            $km_amount = $km_transaction->accumulated_km;
            $total = $user->kong + $user->bonus_kong;
            $order_id = $P_OID;
            $user_id = $user->id;
            $amount = $P_AMT;
            return view("mn_userurl", compact('order_id', 'user_id', 'amount', 'km_amount', 'total'));
        }

    }

    public function pay_cancel(){
        return view('payment.canceled');
    }

    public function canceled(Request $request, $lang, $USERID, $PROVIDERID){
        App::setLocale($lang);
        return view('payment.canceled');
    }

    public function rnoti(Request $request, $lang, $USERID, $PROVIDERID){
        App::setLocale($lang);
        $provider_id = $PROVIDERID;
        $user_id = $USERID;
        $merchant = Merchant::find($provider_id);
        if($merchant==null){
            abort(404);
        }
        $user = User::find($user_id);
        if($user==null){
            abort(404);
        }

        //value from noti server
        $P_STATUS;	  // 거래상태 : 0021(성공), 0031(실패), 0051(입금대기중)
        $P_TR_NO;    	// 거래번호
        $P_AUTH_DT;   // 승인시간
        $P_AUTH_NO;   // 승인번호
        $P_TYPE;      // 거래종류 (CARD, BANK)
        $P_MID;    	  // 회원사아이디
        $P_OID;   	  // 주문번호
        $P_FN_CD1;   	// 금융사코드1 (은행코드, 카드코드)
        $P_FN_CD2;   	// 금융사코드2 (은행코드, 카드코드)
        $P_FN_NM;   	// 금융사명 (은행명, 카드사명)
        $P_UNAME;     // 주문자명
        $P_AMT;      	// 거래금액
        $P_NOTI;      // 주문정보
        $P_RMESG1;    // 메시지1
        $P_RMESG2;    // 메시지2
        $P_HASH;      // NOTI HASH 코드값

        $resp = false;

        $P_STATUS = get_param("PStateCd");
        $P_TR_NO = get_param("PTrno");
        $P_AUTH_DT = get_param("PAuthDt");
        $P_AUTH_NO = get_param("PAuthNo");
        $P_TYPE = get_param("PType");
        $P_MID = get_param("PMid");
        $P_OID = get_param("POid");
        $P_FN_CD1 = get_param("PFnCd1");
        $P_FN_CD2 = get_param("PFnCd2");
        $P_FN_NM = get_param("PFnNm");
        $P_UNAME = get_param("PUname");
        $P_AMT = get_param("PAmt");
        $P_NOTI = get_param("PNoti");
        $P_RMESG1 = get_param("PRmesg1");
        $P_RMESG2 = get_param("PRmesg2");
        $P_HASH = get_param("PHash");

        $PG_AUTH_KEY = $merchant->auth_key;
        //$test = $P_STATUS.$P_TR_NO.$P_AUTH_DT.$P_TYPE.$P_MID.$P_OID.$P_AMT.$PG_AUTH_KEY;
        //die("test=".$test);
        $md5_hash = md5($P_STATUS.$P_TR_NO.$P_AUTH_DT.$P_TYPE.$P_MID.$P_OID.$P_AMT.$PG_AUTH_KEY);

        $value = array(
            "P_DATETIME"=> date("Y-m-d H:i:s"),
            "P_STATUS"  => $P_STATUS,
            "P_TR_NO"   => $P_TR_NO,
            "P_AUTH_DT" => $P_AUTH_DT,
            "P_TYPE"    => $P_TYPE,
            "P_MID"     => $P_MID,
            "P_OID"     => $P_OID,
            "P_FN_CD1"  => $P_FN_CD1,
            "P_FN_CD2"  => $P_FN_CD2,
            "P_FN_NM"   => $P_FN_NM,
            "P_UNAME"   => $P_UNAME,
            "P_AMT"     => $P_AMT,
            "P_NOTI"    => $P_NOTI,
            "P_RMESG1"  => $P_RMESG1,
            "P_RMESG2"  => $P_RMESG2,
            "P_AUTH_NO" => $P_AUTH_NO,
            "P_HASH"    => $P_HASH,
            "HashData"  => $md5_hash );


        if ($md5_hash == $P_HASH) {
            if($P_STATUS == "0021"){

                //Feature #3008: Change the KM conversion rate
                $km_conversion_rate = KmConversionRate::where("type", "=", 'settlebank')->first();
                if($km_conversion_rate!=null){
                    $converted_km = ceil($P_AMT * ($km_conversion_rate->rate/100) );
                }else{
                    $converted_km = $P_AMT;
                }

                $kmTransaction = new KmTransaction();
                $kmTransaction->type = 'Point Conversion';
                $kmTransaction->description = "PG";
                $kmTransaction->date = date("Y-m-d H:i:s");
                $kmTransaction->accumulated_km = $converted_km;
                $kmTransaction->user_id = $user_id;
                $kmTransaction->km_transaction_code_id = 1;
                $kmTransaction->paid_amount = $P_AMT;
                $kmTransaction->tmoa_res_order_id = $P_OID;
                $kmTransaction->tmoa_res_transaction_id = $P_TR_NO;
                $kmTransaction->tmoa_req_amount = $P_AMT;
                $kmTransaction->converted_amount = $converted_km;
                $kmTransaction->service_provider_id = 2;
                $kmTransaction->save();

                noti_write("./pg_rnoti_response.log", $kmTransaction->toArray());
                //update user.kong
                $userKong = $user->kong != "" ? $user->kong : 0;
                $user->kong = $userKong + $converted_km;
                $user->save();

                app(\App\Http\Controllers\SettingController::class)->commonSetting($user->id,'conversion');

                $resp = noti_success($value);
                //store database result here.
                //insert km_transaction.
            }else if($P_STATUS == "0031"){
                $resp = noti_failure($value);
            }else if($P_STATUS == "0051"){
                $resp = noti_waiting_pay($value);
            }else{
                $resp = false;
            }
        }
        else {
            noti_hash_err($value);
        }
        //Do not remove.
        if($resp){
            echo "OK";
        }else{
            echo "FAIL";
        }
    }

    public function ocb_start(Request $request){
        $user_id = $request->USERID;
        $lang = $request->LANG=='' ? 'ko':$request->LANG;
        App::setLocale($lang);
        $user = User::find($user_id);
        if($user==null){
            abort(404);
        }
        return view("mn_conversion_ocb", compact("user_id"));
    }

    public function ocb_returnurl(Request $request){
        $contents = '';
        if(file_exists("mn_api_response.txt")){
            $contents = file_get_contents("mn_api_response.txt");
        }
        $new_contents = $contents."\n".json_encode($_REQUEST);
        file_put_contents("mn_api_response.txt",$new_contents);


        $sid = $request->SID;
        $user_id = $request->USERID;
        $auth_id = $request->AUTHID;
        $order_id = $request->TXNO;
        $transaction_id = $request->MCTTRNO;
        $amount = $request->PAYPOINT;
        $converted_km = $request->PAYPOINT;

        //Feature #3008: Change the KM conversion rate
       $km_conversion_rate = KmConversionRate::where("type", "=", 'ocb')->first();
       if($km_conversion_rate!=null){
           $converted_km = ceil($amount * ($km_conversion_rate->rate/100) );
       }else{
           $converted_km = $amount;
       }
        try{
            $kmTransaction = new KmTransaction();
            $kmTransaction->type = 'Point Conversion';
            $kmTransaction->description = 'OKCashback';
            $kmTransaction->date = date("Y-m-d H:i:s");
            $kmTransaction->accumulated_km = $converted_km;
            $kmTransaction->user_id = $user_id;
            $kmTransaction->km_transaction_code_id = 1;
            $kmTransaction->paid_amount = $amount;
            $kmTransaction->tmoa_res_order_id = $order_id;
            $kmTransaction->tmoa_res_transaction_id = $transaction_id;
            $kmTransaction->tmoa_req_amount = $amount;
            $kmTransaction->converted_amount = $converted_km;
            $kmTransaction->service_provider_id = 1;
            $kmTransaction->save();

            $user = User::find($user_id);
            $userKong = $user->kong != "" ? $user->kong : 0;
            $user->kong = $userKong + $converted_km;
            $user->save();

            app(\App\Http\Controllers\SettingController::class)->commonSetting($user->id, 'conversion');

        }catch(Exception $ex){
            return response()->json([
                'status' => false,
            ]);
        }

        return response()->json([
            'status' => true,
        ]);

    }

    public function ocb_userurl(Request $request){
        $result = $request->REPLYCODE;
        $user_id = $request->USERID;

        $user = User::find($user_id);
        if($user==null){
            abort(404);
        }
        $km_transaction = KmTransaction::where("user_id", $user->id)->orderBy("id", "desc")->first();
        $amount = $km_transaction->paid_amount;
        $km_amount = $km_transaction->accumulated_km;
        $total = $user->kong + $user->bonus_kong;

        return view("mn_userurl", compact('user_id', 'amount', 'km_amount', 'total'));
    }

}
