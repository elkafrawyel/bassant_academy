import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/data/entities/lecture_model.dart';
import 'package:bassant_academy/data/entities/teacher_model.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../app/res/res.dart';
import '../../../../app/util/constants.dart';
import '../../../widgets/app_widgets/app_text.dart';
import '../../video_player_screen/video_player_screen.dart';

class LessonCardView extends StatelessWidget {
  final LectureModel lecture;
  final TeacherModel teacher;

  static double height = 230;

  const LessonCardView({
    super.key,
    required this.lecture,
    required this.teacher,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Get.to(
          () => VideoPlayerScreen(lectureModel: lecture, teacherModel: teacher),
        );
      },
      child: SizedBox(
        width: Get.width * 0.44,
        height: height,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.black,
              width: 0.1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: AppCachedImage(
                  imageUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtCyGq73Yl8yr0YzSuxuS8-fJUQVGXDgPJRw&s',
                  fit: BoxFit.cover,
                  radius: 8,
                  height: height / 2.3,
                  width: double.infinity,
                  // height: imageHeight,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: AppText(
                    lecture.name ?? '',
                    fontSize: 14,
                    maxLines: 3,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Constants.kClickableTextColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        Res.iconClock,
                        width: 20,
                        height: 20,
                      ),
                      5.pw,
                      AppText(lecture.duration ?? ''),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
