import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/app/res/res.dart';
import 'package:bassant_academy/app/util/util.dart';
import 'package:bassant_academy/data/entities/notification_model.dart';
import 'package:bassant_academy/presentation/screens/video_player_screen/video_player_screen.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificationCardView extends StatelessWidget {
  final NotificationModel notificationModel;

  const NotificationCardView({
    super.key,
    required this.notificationModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (notificationModel.lecture != null) {
          Get.to(
            () => VideoPlayerScreen(lectureModel: notificationModel.lecture!),
          );
        }
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(
            color: Color(0xffEFC75E),
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                notificationModel.title ?? '',
                fontWeight: FontWeight.w800,
                color: const Color(0xffEFC75E),
              ),
              10.ph,
              AppText(
                notificationModel.description ?? '',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                maxLines: 3,
                color: const Color(0xff404040),
              ),
              10.ph,
              if (notificationModel.link != null)
                GestureDetector(
                  onTap: () {
                    Utils().launchUrlString(notificationModel.link!);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff2D8CFF),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            Res.iconZoom,
                          ),
                          5.pw,
                          AppText(
                            'join_now'.tr,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              10.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppText(
                    '${DateFormat(
                      DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY,
                      Get.locale?.languageCode,
                    ).format(DateTime.parse(
                      notificationModel.creationDate.toString(),
                    ))}, ',
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    maxLines: 3,
                    color: const Color(0xffD9D9D9),
                  ),
                  AppText(
                    DateFormat(
                      DateFormat.HOUR_MINUTE,
                      Get.locale?.languageCode,
                    ).format(
                      DateTime.parse(
                        notificationModel.creationDate.toString(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
