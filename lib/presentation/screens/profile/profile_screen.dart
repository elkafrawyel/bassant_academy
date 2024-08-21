import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/app/res/res.dart';
import 'package:bassant_academy/app/util/constants.dart';
import 'package:bassant_academy/presentation/screens/edit_profile/edit_profile_screen.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';

import '../../widgets/app_widgets/app_cached_image.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          'profile'.tr,
          fontWeight: FontWeight.w700,
        ),
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () async {
              bool result = await Get.to(() => const EditProfileScreen());
            },
            child: SvgPicture.asset(
              Res.iconEdit,
              width: 30,
              height: 30,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: AlignmentDirectional.centerStart,
              decoration: BoxDecoration(
                color: const Color(0xffFFF7E1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(Res.iconProfile),
                    10.pw,
                    AppText(
                      'احمد عبدالرحمن',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Constants.kClickableTextColor,
                    )
                  ],
                ),
              ),
            ),
            10.ph,
            Container(
              alignment: AlignmentDirectional.centerStart,
              decoration: BoxDecoration(
                color: const Color(0xffFFF7E1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(Res.iconEmail),
                    10.pw,
                    AppText(
                      'user@email.com',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Constants.kClickableTextColor,
                    )
                  ],
                ),
              ),
            ),
            10.ph,
            Container(
              alignment: AlignmentDirectional.centerStart,
              decoration: BoxDecoration(
                color: const Color(0xffFFF7E1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(Res.iconPhone),
                    10.pw,
                    AppText(
                      '01033221100',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Constants.kClickableTextColor,
                    )
                  ],
                ),
              ),
            ),
            30.ph,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppCachedImage(
                  imageUrl:
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_Egypt.svg/1024px-Flag_of_Egypt.svg.png',
                  width: 30,
                  height: 25,
                  radius: 8,
                ),
                10.pw,
                const AppText(
                  'مصر , جامعة المنصورة',
                  fontSize: 16,
                )
              ],
            ),
            10.ph,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppText(
                  'كلية الطب البشري , ',
                  fontSize: 16,
                ),
                AppText(
                  'الفرقة الرابعة',
                  color: Constants.kClickableTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
