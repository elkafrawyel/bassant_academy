import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/presentation/controller/students/students_controller.dart';
import 'package:bassant_academy/presentation/widgets/api_state_views/handel_api_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/app_widgets/app_text.dart';
import 'components/my_student_card.dart';

class MyStudentsList extends StatefulWidget {
  const MyStudentsList({super.key});

  @override
  State<MyStudentsList> createState() => _MyStudentsListState();
}

class _MyStudentsListState extends State<MyStudentsList> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentsController>(
        init: StudentsController(),
        builder: (studentsController) {
          return HandleApiState.controller(
            generalController: studentsController,
            emptyView: Center(
              child: AppText(
                'empty_students'.tr,
                fontSize: 18,
              ),
            ),
            child: RefreshIndicator(
              onRefresh: studentsController.refreshApiCall,
              child: ListView.separated(
                separatorBuilder: (context, index) => 10.ph,
                itemBuilder: (context, index) => MyStudentCard(
                  student: studentsController.students[index],
                ),
                itemCount: studentsController.students.length,
              ),
            ),
          );
        });
  }
}
