import 'package:bassant_academy/presentation/screens/chat/components/message_types/text_message_bubble.dart';
import 'package:flutter/material.dart';

import '../../../../app/config/date_helper.dart';
import '../../../../data/entities/message_model.dart';
import '../../../widgets/app_widgets/app_text.dart';

class TextBubbleView extends StatefulWidget {
  final MessageModel messageModel;
  const TextBubbleView({
    super.key,
    required this.messageModel,
  });

  @override
  State<TextBubbleView> createState() => _TextBubbleViewState();
}

class _TextBubbleViewState extends State<TextBubbleView> {
  bool _showDate = false;

  @override
  Widget build(BuildContext context) {
    bool isCurrentUser = widget.messageModel.isCurrentUser();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: GestureDetector(
            onTap: () => setState(() => _showDate = !_showDate),
            child: TextMessageBubble(
              text: widget.messageModel.messageBody ?? '',
              color: isCurrentUser
                  ? Theme.of(context).primaryColor
                  : const Color(0xffE0F1FF),
              tail: true,
              isSender: isCurrentUser,
              textStyle: TextStyle(
                color: isCurrentUser ? Colors.white : const Color(0xff424B59),
                fontSize: 14,
              ),
              linkStyle: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
        ),
        Offstage(
          offstage: !_showDate,
          child: Align(
            alignment: isCurrentUser
                ? AlignmentDirectional.centerStart
                : AlignmentDirectional.centerEnd,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 28.0, vertical: 8.0),
              child: AppText(
                DateHelper().getTimeFromDateString(widget.messageModel.date),
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ),
        )
      ],
    );
  }
}
