import 'package:bassant_academy/data/providers/storage/local_provider.dart';

class MessageModel {
  MessageModel({
    this.messageBody,
    this.senderName,
    this.senderID,
    this.date,
  });

  MessageModel.fromJson(dynamic json) {
    messageBody = json['messageBody'];
    senderName = json['senderName'];
    senderID = json['senderID'];
    date = json['date'];
  }

  String? messageBody;
  String? senderName;
  String? senderID;
  String? date;

  bool isCurrentUser() =>
      LocalProvider().get(LocalProviderKeys.userId) == senderID;
}
