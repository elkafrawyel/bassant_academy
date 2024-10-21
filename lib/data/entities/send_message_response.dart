import 'package:bassant_academy/data/entities/message_model.dart';

class SendMessageResponse {
  SendMessageResponse({
    this.messageModel,
  });

  SendMessageResponse.fromJson(dynamic json) {
    messageModel =
        json['data'] != null ? MessageModel.fromJson(json['data']) : null;
  }

  MessageModel? messageModel;
}
