import 'package:bassant_academy/data/entities/user_model.dart';
import 'package:bassant_academy/presentation/screens/chat/chat_screen.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_text.dart';
import 'package:flutter/material.dart';

class MyStudentCard extends StatelessWidget {
  final UserModel student;
  const MyStudentCard({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => const ChatScreen(),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: [
              Expanded(
                child: AppText(
                  student.name ?? '',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
