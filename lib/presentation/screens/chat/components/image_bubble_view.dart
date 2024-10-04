import 'package:bassant_academy/presentation/screens/chat/components/message_types/image_message_bubble.dart';
import 'package:flutter/material.dart';

import '../../../../data/entities/message_model.dart';

class ImageBubbleView extends StatefulWidget {
  final MessageModel messageModel;

  const ImageBubbleView({
    super.key,
    required this.messageModel,
  });

  @override
  State<ImageBubbleView> createState() => _ImageBubbleViewState();
}

class _ImageBubbleViewState extends State<ImageBubbleView> {
  @override
  Widget build(BuildContext context) {
    return ImageMessageBubble(
      image:
          'https://hackspirit.com/wp-content/uploads/2021/06/Copy-of-Rustic-Female-Teen-Magazine-Cover.jpg',
      color: Theme.of(context).primaryColor,
      tail: true,
    );
  }
}
