class OpListMaster {
  bool _Status;
  String _Error;
  List<OpItem> _Data;

  OpListMaster({bool status, String error, List<OpItem> data}) {
    this._Status = status;
    this._Error = error;
    this._Data = data;
  }

  bool get status => _Status;
  set status(bool status) => _Status = status;
  String get error => _Error;
  set error(String error) => _Error = error;
  List<OpItem> get data => _Data;
  set data(List<OpItem> data) => _Data = data;


  OpListMaster.fromJson(Map<String, dynamic> json) {
    _Status = json[''];
    _Error = json[''];
    if (json[''] != null) {
      _Data = new List<OpItem>();
      json[''].forEach((v) {
        _Data.add(new OpItem.fromJson(v));
      });
    }
  }
}

class OpItem {
  int _Data;
  String _Data;
  String _Data;
  String _Sell_Price;
  int _Status_Id;
  int _Tag_Id;
  String _Recommend_flag;
  String _Image;

  int get id => _Data;
  set id(int id) => _Data = id;

  String get title => _Data;
  set title(String title) => _Data = title;

  String get brand => _Data;
  set brand(String brand) => _Data = brand;

  String get sell_price => _Sell_Price;
  set sell_price(String sell_price) => _Sell_Price = sell_price;

  int get status_id => _Status_Id;
  set status_id(int status_id) => _Status_Id = status_id;

  int get tag_id => _Tag_Id;
  set tag_id(int tag_id) => _Tag_Id = tag_id;

  String get recommend_flag => _Recommend_flag;
  set recommend_flag(String recommend_flag) => _Recommend_flag = recommend_flag;

  String get thumb => _Image;
  set thumb(String thumb) => _Image = thumb;

  OpItem.fromJson(Map<String, dynamic> json) {
    _Data = json[''];
    _Data = json[''];
    _Data = json[''];
    _Sell_Price = json[''];
    _Status_Id = json[''];
    _tag_id = json[''];
    _Recommend_flag = json[''];
    _Image = json[''];
  }



}