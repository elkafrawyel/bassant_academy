import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/presentation/controller/messages/messages_controller.dart';
import 'package:bassant_academy/presentation/widgets/api_state_views/handel_api_state.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'message_card.dart';

class MessagesList extends StatelessWidget {
  const MessagesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetBuilder<MessagesController>(
          init: MessagesController(),
          builder: (messagesController) {
            return HandleApiState.controller(
              generalController: messagesController,
              emptyView: Center(
                child: AppText(
                  'empty_messages'.tr,
                  fontSize: 18,
                ),
              ),
              child: RefreshIndicator(
                onRefresh: messagesController.refreshApiCall,
                child: ListView.separated(
                  itemCount: messagesController.lastMessages.length,
                  separatorBuilder: (context, index) => 10.ph,
                  itemBuilder: (context, index) => MessageCard(
                    lastMessageModel: messagesController.lastMessages[index],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
