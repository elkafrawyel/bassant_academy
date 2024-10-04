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
  const ChatScreen({super.key});

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
        title: const AppText('User Name'),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppPaginatedGroupedListview<MessageModel>(
                configData: ConfigData<MessageModel>(
                  apiEndPoint: Res.apiNotifications,
                  emptyListMessage: 'empty_notifications'.tr,
                  fromJson: MessageModel.fromJson,
                  isPostRequest: true,
                ),
                child: (MessageModel item) => item.isTextMessage
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

  _addMessage(String message) {
    paginationController.paginationList.insert(
      0,
      MessageModel(
        title: message,
        creationDate: DateTime.now().toIso8601String(),
        isCurrentUser: true,
        isTextMessage: false,
      ),
    );

    paginationController.update();
  }

  @override
  void onNotify(RemoteMessage notification) {
    _addMessage(notification.notification?.title ?? 'title here');
  }
}
