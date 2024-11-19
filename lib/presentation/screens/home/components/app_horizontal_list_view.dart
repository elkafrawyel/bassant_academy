import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/data/entities/lecture_model.dart';
import 'package:bassant_academy/data/entities/teacher_model.dart';
import 'package:flutter/material.dart';

import '../../../widgets/app_widgets/app_text.dart';
import 'lesson_card_view.dart';

class AppHorizontalListView extends StatelessWidget {
  final String title;
  final List<LectureModel>? data;
  final TeacherModel? teacherModel;
  final Function()? onSeeAllClicked;

  const AppHorizontalListView({
    super.key,
    required this.title,
    required this.data,
    this.teacherModel,
    this.onSeeAllClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                title,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              // InkWell(
              //   onTap: onSeeAllClicked,
              //   child: Container(
              //     decoration: BoxDecoration(
              //       color: Theme.of(context).iconTheme.color,
              //       borderRadius: BorderRadius.circular(12.0),
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.symmetric(
              //         horizontal: 8.0,
              //         vertical: 4.0,
              //       ),
              //       child: Row(
              //         children: [
              //           AppText(
              //             'see_all'.tr,
              //             fontSize: 12,
              //             color: Theme.of(context).textTheme.labelLarge?.color,
              //           ),
              //           Icon(
              //             Icons.arrow_forward_ios,
              //             color: Theme.of(context).textTheme.labelLarge?.color,
              //             size: 17,
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        if (data != null || data!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: SizedBox(
              height: LessonCardView.height + 10,
              child: ListView.separated(
                separatorBuilder: (context, index) => 3.pw,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: LessonCardView(
                    lecture: data![index],
                    teacher: teacherModel,
                  ),
                ),
                itemCount: data!.length,
              ),
            ),
          ),
      ],
    );
  }
}
