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
                  : Colors.grey.shade300,
              tail: true,
              isSender: isCurrentUser,
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              linkStyle: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ),
        Offstage(
          offstage: !_showDate,
          child: Align(
            alignment: isCurrentUser
                ? AlignmentDirectional.centerEnd
                : AlignmentDirectional.centerStart,
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
