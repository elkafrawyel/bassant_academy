import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/app/res/res.dart';
import 'package:bassant_academy/app/util/constants.dart';
import 'package:bassant_academy/app/util/information_viewer.dart';
import 'package:bassant_academy/app/util/operation_reply.dart';
import 'package:bassant_academy/app/util/util.dart';
import 'package:bassant_academy/data/entities/general_response.dart';
import 'package:bassant_academy/data/entities/social_links_response.dart';
import 'package:bassant_academy/data/providers/network/api_provider.dart';
import 'package:bassant_academy/data/providers/storage/local_provider.dart';
import 'package:bassant_academy/presentation/controller/home_screen/home_screen_controller.dart';
import 'package:bassant_academy/presentation/screens/about/about_screen.dart';
import 'package:bassant_academy/presentation/screens/add_subjects/add_subjects_screen.dart';
import 'package:bassant_academy/presentation/screens/profile/profile_screen.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_text.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/language_views/app_language_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../widgets/app_widgets/app_dialog.dart';

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
              onTap: () {
                Get.back();
                Get.to(() => const AddSubjectsScreen());
              },
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
            // ListTile(
            //   onTap: () {
            //     Get.back();
            //     Get.to(() => const AddSubjectsScreen());
            //   },
            //   leading: SvgPicture.asset(
            //     Res.iconSubscriptions,
            //     width: 25,
            //     height: 25,
            //   ),
            //   title: AppText(
            //     'my_subscriptions'.tr,
            //     fontSize: 16,
            //     fontWeight: FontWeight.w700,
            //     color: Colors.white,
            //   ),
            // ),
            ListTile(
              onTap: () {
                Get.back();
                Get.to(() => const AboutScreen());
              },
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
            GestureDetector(
              onTap: () {
                scaleDialog(
                  context: context,
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppText(
                      'logout_message'.tr,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  cancelText: 'cancel'.tr,
                  onCancelClick: Get.back,
                  confirmText: 'logout'.tr,
                  onConfirmClick: _singOut,
                  barrierDismissible: true,
                  cancelColor: Colors.black,
                  confirmColor: Colors.red,
                );
              },
              child: Container(
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
              ),
            ),
            20.ph,
            GetBuilder<HomeScreenController>(
              builder: (homeController) {
                SocialLinksModel? socialLinks = homeController.socialLinksModel;
                return socialLinks == null
                    ? const SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (socialLinks.instagram != null)
                            GestureDetector(
                              onTap: () {
                                Utils().launchUrlString(socialLinks.instagram!);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  Res.iconInstagram,
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                          10.pw,
                          if (socialLinks.faceBook != null)
                            GestureDetector(
                              onTap: () {
                                Utils().launchUrlString(socialLinks.faceBook!);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  Res.iconFacebook,
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                          10.pw,
                          if (socialLinks.tikTok != null)
                            GestureDetector(
                              onTap: () {
                                Utils().launchUrlString(socialLinks.tikTok!);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  Res.iconTiktok,
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                          10.pw,
                          if (socialLinks.whatsapp != null)
                            GestureDetector(
                              onTap: () {
                                Utils().launchUrlString(socialLinks.whatsapp!);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  Res.iconWhatsapp,
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                        ],
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _singOut() async {
    OperationReply operationReply = await APIProvider.instance.get(
      endPoint: Res.apiLogout,
      fromJson: GeneralResponse.fromJson,
    );
    if (operationReply.isSuccess()) {
      GeneralResponse generalResponse = operationReply.result;
      await LocalProvider().signOut();
      InformationViewer.showSuccessToast(msg: generalResponse.message);
    } else {
      InformationViewer.showErrorToast(msg: operationReply.message);
    }
  }
}
