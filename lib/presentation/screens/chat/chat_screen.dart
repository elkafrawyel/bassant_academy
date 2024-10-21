import 'package:bassant_academy/app/util/information_viewer.dart';
import 'package:bassant_academy/app/util/operation_reply.dart';
import 'package:bassant_academy/app/util/util.dart';
import 'package:bassant_academy/data/entities/send_message_response.dart';
import 'package:bassant_academy/data/providers/network/api_provider.dart';
import 'package:bassant_academy/data/providers/storage/local_provider.dart';
import 'package:bassant_academy/presentation/screens/chat/components/image_bubble_view.dart';
import 'package:bassant_academy/presentation/screens/chat/components/message_types/type_message_bar.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/config/notifications/notification_mixin.dart';
import '../../../app/res/res.dart';
import '../../../data/entities/message_model.dart';
import '../../controller/my_controllers/pagination_controller/data/config_data.dart';
import '../../controller/my_controllers/pagination_controller/pagination_controller.dart';
import '../../widgets/app_widgets/paginated_views/app_paginated_grouped_listview.dart';
import 'components/text_bubble_view.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String id;
  const ChatScreen({
    super.key,
    required this.name,
    required this.id,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with FCMNotificationMixin {
  late PaginationController paginationController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: AppText(widget.name),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppPaginatedGroupedListview<MessageModel>(
                configData: ConfigData<MessageModel>(
                    apiEndPoint: Res.apiChatMessages,
                    emptyListMessage: 'empty_messages'.tr,
                    fromJson: MessageModel.fromJson,
                    isPostRequest: true,
                    parameters: {
                      "recipientId": widget.id,
                      // "recipientId": "08987232-99e6-40c6-b28e-f7a9a99a26ee",
                    }),
                child: (MessageModel item) => item.messageBody != null
                    ? TextBubbleView(
                        messageModel: item,
                      )
                    : ImageBubbleView(messageModel: item),
                instance: (paginationController) =>
                    this.paginationController = paginationController,
              ),
            ),
          ),
          SafeArea(
            child: TypeMessageBar(
              messageBarHintText: LocalProvider().isAr()
                  ? 'اكتب رسالتك هنا'
                  : 'Type your message here',
              sendButtonColor: Theme.of(context).primaryColor,
              onSend: (String message) => _addMessage(message),
              actions: [
                InkWell(
                  child: Icon(
                    Icons.add,
                    color: Theme.of(context).primaryColor,
                    size: 24,
                  ),
                  onTap: () {},
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 8, right: 8),
                //   child: InkWell(
                //     child: Icon(
                //       Icons.camera_alt,
                //       color: context.kPrimaryColor,
                //       size: 24,
                //     ),
                //     onTap: () {},
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _addMessage(String message) async {
    OperationReply operationReply = await APIProvider.instance.post(
      endPoint: Res.apiSendMessage,
      fromJson: SendMessageResponse.fromJson,
      requestBody: {
        "recipientId": widget.id,
        "message": message,
      },
    );

    if (operationReply.isSuccess()) {
      SendMessageResponse sendMessageResponse = operationReply.result;

      MessageModel? messageModel = sendMessageResponse.messageModel;
      if (messageModel != null) {
        paginationController.paginationList.insert(
          0,
          messageModel,
        );
        paginationController.update();
      } else {
        Utils.logMessage('Can\'t Send Message to ${widget.name}');
      }
    } else {
      InformationViewer.showErrorToast(msg: operationReply.message);
    }
  }

  @override
  void onNotify(RemoteMessage notification) {
    print(notification.data);
    MessageModel messageModel = MessageModel.fromJson(
      notification.data,
      // notification.data['message'],
    );
    paginationController.paginationList.insert(
      0,
      messageModel,
    );
    paginationController.update();
  }
}
