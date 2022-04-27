class OpCategoryMaster {
  bool _Status;
  String _Error;
  List<OpCategoryItem> _Data;

  OpCategoryMaster({bool status, String error, List<OpCategoryItem> data}) {
    this._Status = status;
    this._Error = error;
    this._Data = data;
  }

  bool get status => _Status;
  set status(bool status) => _Status = status;
  String get error => _Error;
  set error(String error) => _Error = error;
  List<OpCategoryItem> get data => _Data;
  set data(List<OpCategoryItem> data) => _Data = data;


  OpCategoryMaster.fromJson(Map<String, dynamic> json) {
    _Status = json[''];
    _Error = json[''];
    if (json[''] != null) {
      _Data = new List<OpCategoryItem>();
      json[''].forEach((v) {
        _Data.add(new OpCategoryItem.fromJson(v));
      });
    }
  }

}

class OpCategoryItem {
  int _Id;
  String _Title_kr;
  String _Title_en;
  String _Description;
  String _Image;

  int get id => _Id;
  set id(int id) => _Id = id;
  String get title => _Title_kr;
  set title(String title) => title = _Title_kr;
  String get image => _Image;
  set image(String image) => _Image = image;

  OpCategoryItem.fromJson(Map<String, dynamic> json) {
    _Id = json[''];
    _Title_kr = json[''];
    _Image = json[''];
  }
}