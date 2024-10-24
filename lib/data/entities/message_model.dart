import 'package:bassant_academy/data/providers/storage/local_provider.dart';

class MessageModel {
  MessageModel({
    this.messageBody,
    this.image,
    this.senderName,
    this.senderID,
    this.date,
  });

  MessageModel.fromJson(dynamic json) {
    messageBody = json['messageBody'];
    image = json['image'];
    senderName = json['senderName'];
    senderID = json['senderID'];
    date = json['date'];
  }

  String? messageBody;
  String? image;
  String? senderName;
  String? senderID;
  String? date;

  bool isCurrentUser() =>
      LocalProvider().get(LocalProviderKeys.userId) == senderID;

  @override
  String toString() {
    return date!;
  }
}
