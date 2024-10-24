import 'package:bassant_academy/presentation/screens/chat/chat_screen.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../../../data/entities/student_model.dart';

class MyStudentCard extends StatelessWidget {
  final StudentModel student;

  const MyStudentCard({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.to(
          () => ChatScreen(
            name: student.name!,
            id: student.id!,
          ),
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(12),
        side: const BorderSide(
          color: Colors.black,
          width: 0.2,
        ),
      ),
      title: AppText(
        student.name ?? '',
        fontWeight: FontWeight.w700,
      ),
      trailing: const Icon(
        Icons.message,
      ),
    );
  }
}
