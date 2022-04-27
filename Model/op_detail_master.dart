class OpDetailMaster {
  bool _Status;
  String _Error;
  OpDetail _Data;

  OpDetailMaster({bool status, String error, OpDetail data}) {
    this._Status = status;
    this._Error = error;
    this._Data = data;
  }

  bool get status => _Status;
  set status(bool status) => _Status = status;
  String get error => _Error;
  set error(String error) => _Error = error;
  OpDetail get data => _Data;
  set data(OpDetail data) => _Data = data;


  OpDetailMaster.fromJson(Map<String, dynamic> json) {
    _Status = json[''];
    _Error = json[''];
    if (json[''] != null) {
      _Data = new OpDetail.fromJson(json['']);
    }
  }

}

class OpDetail {
  int _Id;
  String _Title;
  String _Brand;
  int _CateId;
  String _Sell_Price;
  int _Status_Id;
  int mTag_Id;
  String _Image;
  String _Recommend_flag;
  String _Option_flag;
  String _ExplanTxt;
  String _CautionTxt;
  List<String> _ProductImgs;

  int get id => _Id;
  set id(int id) => _Id = id;

  String get title => _Title;
  set title(String title) => _Title = title;

  String get brand => _Brand;
  set brand(String brand) => _Brand = brand;

  int get cate_id => _CateId;
  set cate_id(int id) => _CateId = id;

  String get sell_price => _Sell_Price;
  set sell_price(String sell_price) => _Sell_Price = sell_price;

  int get status_id => _Status_Id;
  set status_id(int status_id) => _Status_Id = status_id;

  int get tag_id => mTag_Id;
  set tag_id(int tag_id) => mTag_Id = tag_id;

  String get thumb => _Image;
  set thumb(String thumb) => _Image = thumb;

  String get recommend_flag => _Recommend_flag;
  set recommend_flag(String recommend_flag) => _Recommend_flag = recommend_flag;

  String get option_flag => _Option_flag;
  set option_flag(String option_flag) => _Option_flag = option_flag;

  String get explan_txt => _ExplanTxt;
  set explan_txt(String explan_txt) => _ExplanTxt = explan_txt;

  String get caution_txt => _CautionTxt;
  set caution_txt(String caution_txt) => _CautionTxt = caution_txt;

  List<String> get product_imgs => _ProductImgs;
  set product_imgs(List<String> productImgs) => _ProductImgs = productImgs;

  OpDetail.fromJson(Map<String, dynamic> json) {
    _Id = json[''];
    _Title = json[''];
    _Brand = json[''];
    _CateId = json[''];
    _Sell_Price = json[''];
    _Status_Id = json[''];
    mTag_Id = json[''];
    _Image = json[''];
    _Recommend_flag = json[''];
    _Option_flag = json[''];
    _ExplanTxt = json[''];
    _CautionTxt = json[''];

    if(json[''] != null){
      _ProductImgs = new List();
      json[''].forEach((v) {
        _ProductImgs.add(v);
      });
    }
  }



}