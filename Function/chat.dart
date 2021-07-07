import 'package:floor/floor.dart';

@entity
class ChatMessageData {
  @primaryKey
  String id;
  String message;
  String receiver;
  String sender;
  String status; //0-Pending,1-Send,2-Deliver,3-Read,4-Deleted
  String createdAt;
  String selfRead; //0-Pending,1-Read

  ChatMessageData(this.id, this.message, this.receiver, this.sender, this.status, this.createdAt, this.selfRead);

  factory ChatMessageData.fromJson(Map<String, dynamic> json) {
    return ChatMessageData(
      json['id'],
      json['message'],
      json['receiver'],
      json['sender'],
      json['status'],
      json['created_at'],
      json['self_read'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['receiver'] = this.receiver;
    data['sender'] = this.sender;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

@entity
class ChatUser {
  @primaryKey
  String id;

  String title;

  String picture;

  String selfRead;

  ChatUser(this.id, this.title, this.picture);

  factory ChatUser.fromJson(Map<String, dynamic> json) {
    return ChatUser(
      json['id'],
      json['title'],
      json['picture'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['picture'] = this.picture;
    return data;
  }
}


