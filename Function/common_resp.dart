

class CommonResp {
  EncryptData data;
  String message;

  CommonResp({this.data, this.message});

  factory CommonResp.fromJson(Map<String, dynamic> json) {
    return CommonResp(
      data: json['data'] != null ? EncryptData.fromJson(json['data']) : null,
      message: json['message'],
    );
  }

  
class EncryptData {
  String mac;
  String value;

  EncryptData({this.mac, this.value});

  factory EncryptData.fromJson(Map<String, dynamic> json) {
    return EncryptData(
      mac: json['mac'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mac'] = this.mac;
    data['value'] = this.value;
    return data;
  }

  @override
  String toString() {
    return '{"mac": "$mac", "value": "$value"}';
  }
}

class CommonCallBack {
  dynamic data;
  dynamic error;
  String message;
  String status;

  CommonCallBack({this.error, this.data, this.message, this.status});

  
  }
}
