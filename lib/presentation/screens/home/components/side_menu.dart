import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/app/res/res.dart';
import 'package:bassant_academy/app/util/constants.dart';
import 'package:bassant_academy/presentation/screens/profile/profile_screen.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_text.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/language_views/app_language_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.8,
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).padding.top + kToolbarHeight,
          horizontal: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              Res.iconDrawerLogo,
              height: 50,
            ),
            40.ph,
            ListTile(
              onTap: () {
                Get.back();
              },
              leading: SvgPicture.asset(
                Res.iconHome,
                width: 25,
                height: 25,
              ),
              title: AppText(
                'home'.tr,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () {
                Get.back();
                Get.to(() => const ProfileScreen());
              },
              leading: SvgPicture.asset(
                Res.iconProfile,
                width: 25,
                height: 25,
              ),
              title: AppText(
                'profile'.tr,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            ListTile(
              leading: SvgPicture.asset(
                Res.iconSubjects,
                width: 25,
                height: 25,
              ),
              title: AppText(
                'add_subjects'.tr,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            ListTile(
              leading: SvgPicture.asset(
                Res.iconAbout,
                width: 25,
                height: 25,
              ),
              title: AppText(
                'about_academy'.tr,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            ListTile(
              leading: SvgPicture.asset(
                Res.iconLanguage,
                width: 25,
                height: 25,
              ),
              title: AppText(
                'app_language'.tr,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            20.ph,
            const AppLanguageRow(),
            40.ph,
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      Res.iconSignOut,
                      width: 25,
                      height: 25,
                    ),
                    10.pw,
                    AppText(
                      'logout'.tr,
                      color: Constants.kClickableTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
