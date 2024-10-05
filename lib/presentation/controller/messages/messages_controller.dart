import 'package:bassant_academy/app/util/operation_reply.dart';
import 'package:bassant_academy/data/entities/message_model.dart';
import 'package:bassant_academy/presentation/controller/my_controllers/general_controller.dart';

class MessagesController extends GeneralController {
  List<MessageModel> messages = [];

  @override
  void onInit() {
    super.onInit();
    messages.clear();
    _loadMessages();
  }

  @override
  Future<void> refreshApiCall() async {
    _loadMessages();
  }

  Future _loadMessages() async {
    operationReply = OperationReply.loading();
    await Future.delayed(const Duration(seconds: 3));
    // messages = ([
    //   MessageModel(
    //     title: 'Hello',
    //     creationDate: DateTime.now().toIso8601String(),
    //     isCurrentUser: true,
    //   ),
    //   MessageModel(
    //     title: 'Welcome',
    //     creationDate: DateTime.now().toIso8601String(),
    //     isCurrentUser: true,
    //   ),
    //   MessageModel(
    //     title: 'How are you doing?',
    //     creationDate: DateTime.now().toIso8601String(),
    //     isCurrentUser: true,
    //   ),
    // ]);
    if (messages.isEmpty) {
      operationReply = OperationReply.empty();
    } else {
      operationReply = OperationReply.success();
    }
  }
}
