import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/app/res/res.dart';
import 'package:bassant_academy/data/entities/notification_model.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class NotificationCardView extends StatelessWidget {
  final NotificationModel notificationModel;

  const NotificationCardView({
    super.key,
    required this.notificationModel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(
          color: Color(0xffEFC75E),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            AppText(
              notificationModel.title ?? '',
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: const Color(0xffEFC75E),
            ),
            10.ph,
            AppText(
              notificationModel.title ?? '',
              fontSize: 16,
              fontWeight: FontWeight.w800,
              maxLines: 3,
              color: const Color(0xff404040),
            ),
            10.ph,
            Container(
              decoration: BoxDecoration(
                color: const Color(0xff2D8CFF),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    Res.iconZoom,
                  ),
                  AppText(
                    'join_now'.tr,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            10.ph,
            const Align(
              alignment: AlignmentDirectional.centerEnd,
              child: AppText(
                '02:45 PM 19/08/2024',
                fontSize: 16,
                fontWeight: FontWeight.w800,
                maxLines: 3,
                color: Color(0xffD9D9D9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
