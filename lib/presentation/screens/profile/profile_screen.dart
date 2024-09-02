import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/app/res/res.dart';
import 'package:bassant_academy/app/util/constants.dart';
import 'package:bassant_academy/presentation/screens/edit_profile/edit_profile_screen.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_dialog.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controller/home_screen/home_screen_controller.dart';
import '../../widgets/app_widgets/app_cached_image.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
              bool? result = await Get.to(() => const EditProfileScreen());
              if (result ?? false) {
                setState(() {});
              }
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
        child: GetBuilder<HomeScreenController>(
          builder: (homeScreenController) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: AlignmentDirectional.centerStart,
                  decoration: BoxDecoration(
                    color: const Color(0xffFFF7E1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(Res.iconProfile),
                        10.pw,
                        AppText(
                          homeScreenController
                                  .profileResponse?.data?.user?.name ??
                              '',
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(Res.iconEmail),
                        10.pw,
                        AppText(
                          homeScreenController
                                  .profileResponse?.data?.user?.email ??
                              '',
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(Res.iconPhone),
                        10.pw,
                        AppText(
                          homeScreenController
                                  .profileResponse?.data?.user?.phone ??
                              '',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Constants.kClickableTextColor,
                        )
                      ],
                    ),
                  ),
                ),
                30.ph,
                GetBuilder<HomeScreenController>(
                    builder: (homeScreenController) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppCachedImage(
                        imageUrl: homeScreenController
                            .profileResponse?.data?.country?.image,
                        width: 30,
                        height: 25,
                        radius: 8,
                      ),
                      10.pw,
                      AppText(
                        '${homeScreenController.profileResponse?.data?.country?.name ?? ''} , ${homeScreenController.profileResponse?.data?.university?.name ?? ''}',
                        fontSize: 16,
                      )
                    ],
                  );
                }),
                10.ph,
                GetBuilder<HomeScreenController>(
                    builder: (homeScreenController) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(
                        '${homeScreenController.profileResponse?.data?.collage?.name ?? ''} , ',
                        fontSize: 16,
                      ),
                      AppText(
                        homeScreenController
                                .profileResponse?.data?.level?.name ??
                            '',
                        color: Constants.kClickableTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  );
                }),
                20.ph,
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18.0,
                      vertical: 12.0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        scaleDialog(
                          context: context,
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AppText(
                              'delete_message'.tr,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          cancelText: 'cancel'.tr,
                          onCancelClick: Get.back,
                          confirmText: 'delete'.tr,
                          onConfirmClick: _deleteAccount,
                          barrierDismissible: true,
                          cancelColor: Colors.black,
                          confirmColor: Colors.red,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.delete_forever,
                                color: Colors.red.shade500,
                              ),
                              AppText(
                                'delete_account'.tr,
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _deleteAccount() async {}
}
