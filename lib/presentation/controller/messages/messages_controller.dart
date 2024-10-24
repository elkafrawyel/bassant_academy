import 'package:bassant_academy/app/res/res.dart';
import 'package:bassant_academy/app/util/operation_reply.dart';
import 'package:bassant_academy/data/entities/MessagesResponse.dart';
import 'package:bassant_academy/data/providers/network/api_provider.dart';
import 'package:bassant_academy/presentation/controller/my_controllers/general_controller.dart';

class MessagesController extends GeneralController {
  List<LastMessageModel> lastMessages = [];

  @override
  void onInit() {
    super.onInit();
    lastMessages.clear();
    _loadMessages();
  }

  @override
  Future<void> refreshApiCall() async {
    _loadMessages();
  }

  Future _loadMessages() async {
    // operationReply = OperationReply.loading();
    operationReply = await APIProvider.instance.get(
      endPoint: Res.apiLastMessages,
      fromJson: LastMessagesResponse.fromJson,
    );
    if (operationReply.isSuccess()) {
      LastMessagesResponse lastMessagesResponse = operationReply.result;
      lastMessages = lastMessagesResponse.data ?? [];
    }
    if (lastMessages.isEmpty) {
      operationReply = OperationReply.empty();
    } else {
      operationReply = OperationReply.success();
    }
  }
}
