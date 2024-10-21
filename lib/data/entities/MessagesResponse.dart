class LastMessagesResponse {
  LastMessagesResponse({
    this.data,
    this.errorOccurred,
    this.status,
    this.message,
  });

  LastMessagesResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(LastMessageModel.fromJson(v));
      });
    }
    errorOccurred = json['errorOccurred'];
    status = json['status'];
    message = json['message'];
  }

  List<LastMessageModel>? data;
  bool? errorOccurred;
  num? status;
  String? message;
}

class LastMessageModel {
  LastMessageModel({
    this.id,
    this.name,
    this.lastMessage,
    this.date,
    this.senderId,
  });

  LastMessageModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    lastMessage = json['lastMessage'];
    date = json['date'];
    senderId = json['senderId'];
  }

  String? id;
  String? name;
  String? lastMessage;
  String? date;
  String? senderId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['lastMessage'] = lastMessage;
    map['date'] = date;
    map['senderId'] = senderId;
    return map;
  }
}
