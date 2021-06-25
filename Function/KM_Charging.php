<?php
class PaymentController extends Controller
{
    public function __construct() {
    }

    public function webview(Request $request){
        $user_id = $request->USERID;
        $request_amount = $amount = $request->AMOUNT;
        $type = $request->TYPE;
        $provider_id = $request->PROVIDERID;
        $lang = $request->LANG;
        if($lang==''){
            $lang = "ko";
        }
        App::setLocale($lang);
        $user = User::find($user_id);
        if($user==null){
            abort(404);
        }
        if($amount=='' || $type==''){
            abort(404);
        }
        if($provider_id==''){
            $provider_id = "1";
        }
        $merchant = Merchant::find($provider_id);
        if($merchant==null){
            abort(404);
        }
        $charging_rate = null;
        if($type=='1'){//card
            $charging_rate = KmChargingRate::where("type", "PG_creditcard")->first();
        }else if($type=='3'){//
            $charging_rate = KmChargingRate::where("type", "PG_phone")->first();
        }
        if($charging_rate!=null){
            $rate = $charging_rate->rate;
        }else{
            $rate = 0;
        }
        if($rate>0){
            $amount = ceil($amount + ($amount * ($rate/100)));
        }
        $fee = $amount - $request_amount;
        return view('payment.webview', compact('user', 'amount', 'type', 'merchant', 'lang', 'fee'));
    }

    public function pay_rcv(Request $request, $lang, $USERID, $PROVIDERID, $FEE=0){
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

        $P_STATUS    = $request->PStateCd;   
        $P_TR_NO     = $request->PTrno;     
        $P_AUTH_DT   = $request->PAuthDt;    
        $P_AUTH_NO   = $request->PAuthNo;    
        $P_TYPE      = $request->PType;     
        $P_MID       = $request->PMid;       
        $P_OID       = $request->POid;       
        $P_AMT       = $request->PAmt;       
        $P_HASH      = $request->PHash;      
        $P_DATA      = $P_STATUS.$P_TR_NO.$P_AUTH_DT.$P_TYPE.$P_MID.$P_OID.$P_AMT;

        $user = User::find($USERID);
        if($user==null){
            abort(404);
        }

        if($P_STATUS=="0031"){
            return view('payment.canceled');
        }else{
            $total = $user->kong + $user->bonus_kong;
            $P_AMT = $P_AMT - $FEE;
            return view('payment.pay_rcv',compact('P_STATUS', 'P_TR_NO', 'P_AUTH_DT', 'P_AUTH_NO', 'P_TYPE', 'P_MID', 'P_OID', 'P_AMT', 'P_HASH', 'P_DATA', 'total'));
        }

    }

    public function pay_cancel(){
        return view('payment.canceled');
    }

    public function canceled(Request $request, $lang, $USERID, $PROVIDERID){
        App::setLocale($lang);
        return view('payment.canceled');
    }

    public function rnoti(Request $request, $lang, $USERID, $PROVIDERID, $FEE=0){
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

        $P_STATUS;	  
        $P_TR_NO;    	
        $P_AUTH_DT;   
        $P_AUTH_NO;   
        $P_TYPE;      
        $P_MID;    	  
        $P_OID;   	  
        $P_FN_CD1;   	
        $P_FN_CD2;   	
        $P_FN_NM;   	
        $P_UNAME;     
        $P_AMT;      	
        $P_NOTI;      
        $P_RMESG1;    
        $P_RMESG2;    
        $P_HASH;      

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

         $PG_AUTH_KEY = ($merchant->current_mode=='test') ? $merchant->auth_key_test:$merchant->auth_key;
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
            $amount = $P_AMT;
            $charging_rate = null;
            if($P_STATUS == "2100"){
                $kmTransaction = new KmTransaction();
                $kmTransaction->date = date("Y-m-d H:i:s");
                if($P_TYPE=="MOBILE"){
                    $kmTransaction->type = '휴대폰 충전';
                    $kmTransaction->description = '휴대폰 소액결제';
                }else if($P_TYPE=="CARD"){
                    $kmTransaction->type = '신용카드 충전';
                    $kmTransaction->description = $P_FN_NM;
                }else{ //BANK
                    $kmTransaction->type = '계좌이체 충전';
                    $kmTransaction->description = '-';
                }
                if($FEE>0){
                    $amount = $amount - $FEE;
                }
                $kmTransaction->accumulated_km = $amount;
                $kmTransaction->user_id = $user_id;
                $kmTransaction->tmoa_res_transaction_id = $P_TR_NO;
                $kmTransaction->km_transaction_code_id = 2;
                $kmTransaction->paid_amount = $P_AMT;
                $kmTransaction->converted_amount = $amount;
                noti_write("./pg_rnoti_response.log", $kmTransaction->toArray());
                $kmTransaction->save();
                //update user.kong
                $user->kong = $user->kong + $amount;
                $user->save();

                if($amount>50000){
                    app(\App\Http\Controllers\SettingController::class)->commonSetting($user->id, 'km_charge5');
                }else if($amount>30000 && $amount<=50000){
                    app(\App\Http\Controllers\SettingController::class)->commonSetting($user->id, 'km_charge4');
                }else if($amount>10000 && $amount<=30000){
                    app(\App\Http\Controllers\SettingController::class)->commonSetting($user->id, 'km_charge3');
                }else if($amount>5000 && $amount<=10000){
                    app(\App\Http\Controllers\SettingController::class)->commonSetting($user->id, 'km_charge2');
                }else{
                    app(\App\Http\Controllers\SettingController::class)->commonSetting($user->id, 'km_charge1');
                }

                $resp = noti_success($value);
                //store database result here.
                //insert km_transaction.

                $ch = new ChargeHistory();
                $ch->date = date("Y-m-d H:i:s");
                $ch->krw_amount = $P_AMT;
                $ch->kong_mileage = $amount;
                $ch->pg_code = $P_TR_NO;
                $ch->user_email = $user->email;
                $ch->user_nick_name = $user->nick_name;
                $ch->save();

            }else if($P_STATUS == "3100"){
                $resp = noti_failure($value);
            }else if($P_STATUS == "5100"){
                $resp = noti_waiting_pay($value);
            }else{
                $resp = false;
            }
        }
        else {
            noti_hash_err($value);
        }

    }

}
