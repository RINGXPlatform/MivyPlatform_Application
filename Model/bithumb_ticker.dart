class Bithumb_Ticker {
  String status;
  Ticker data;

  Bithumb_Ticker({this.status, this.data});

  Bithumb_Ticker.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Ticker.fromJson(json['data']) : null;
  }
}

class Ticker{
  double closing_price;
  Ticker.fromJson(Map<String,dynamic> json){
    closing_price = double.parse(json['closing_price']);
  }
}