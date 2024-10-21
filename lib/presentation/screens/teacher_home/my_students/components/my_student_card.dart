import 'package:bassant_academy/presentation/screens/chat/chat_screen.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_text.dart';
import 'package:flutter/material.dart';

import '../../../../../data/entities/student_model.dart';

class MyStudentCard extends StatelessWidget {
  final StudentModel student;
  const MyStudentCard({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ChatScreen(
        name: student.name!,
        id: student.id!,
      ),
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
