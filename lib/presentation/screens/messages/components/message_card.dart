import 'package:bassant_academy/data/providers/storage/local_provider.dart';
import 'package:bassant_academy/presentation/screens/chat/chat_screen.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_time_ago/get_time_ago.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const ChatScreen());
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        'Mahmoud Ashraf',
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        maxLines: 1,
                      ),
                      AppText(
                        'Hello',
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
                  DateTime.now().subtract(
                    const Duration(minutes: 20),
                  ),
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
