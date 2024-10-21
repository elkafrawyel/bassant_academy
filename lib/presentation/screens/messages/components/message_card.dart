import 'package:bassant_academy/data/entities/MessagesResponse.dart';
import 'package:bassant_academy/data/providers/storage/local_provider.dart';
import 'package:bassant_academy/presentation/screens/chat/chat_screen.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_time_ago/get_time_ago.dart';

class MessageCard extends StatelessWidget {
  final LastMessageModel lastMessageModel;
  const MessageCard({
    super.key,
    required this.lastMessageModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => ChatScreen(
            name: lastMessageModel.name!,
            id: lastMessageModel.id!,
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        lastMessageModel.name ?? '',
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        maxLines: 1,
                      ),
                      AppText(
                        lastMessageModel.lastMessage ?? '',
                        maxLines: 1,
                        fontWeight: FontWeight.w200,
                        fontSize: 13,
                      ),
                    ],
                  ),
                ),
              ),
              AppText(
                GetTimeAgo.parse(
                  DateTime.parse(lastMessageModel.date ?? ''),
                  locale: LocalProvider().getAppLanguage(),
                ),
                fontWeight: FontWeight.normal,
                fontSize: 12,
              )
            ],
          ),
        ),
      ),
    );
  }
}
