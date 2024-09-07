import 'package:bassant_academy/app/extensions/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../app/res/res.dart';
import '../../../../app/util/constants.dart';
import '../../../controller/home_screen/home_screen_controller.dart';
import '../../../widgets/app_widgets/app_cached_image.dart';
import '../../../widgets/app_widgets/app_text.dart';
import '../../notifications/notifications_screen.dart';

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final GlobalKey<ScaffoldState> scaffoldKey;

  MySliverAppBar({
    required this.expandedHeight,
    required this.scaffoldKey,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    bool expanded = shrinkOffset / expandedHeight == 0;

    return Stack(
      fit: StackFit.passthrough,
      clipBehavior: Clip.none,
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadiusDirectional.vertical(
              bottom: Radius.circular(15),
            ),
          ),
        ),
        AnimatedPadding(
          duration: const Duration(milliseconds: 500),
          padding: EdgeInsets.symmetric(vertical: expanded ? 60 : 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  scaffoldKey.currentState?.openDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  color: Constants.kClickableTextColor,
                ),
              ),
              FittedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GetBuilder<HomeScreenController>(
                        builder: (homeScreenController) {
                      return AppText(
                        "${'hello'.tr}, ${homeScreenController.profileResponse?.data?.user?.name ?? ''}",
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      );
                    }),
                    Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.sizeOf(context).width / 2),
                      child: AppText(
                        "home_message".tr,
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.to(() => NotificationsScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    Res.iconNotification,
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: expandedHeight / 1.5 - shrinkOffset,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Card(
              elevation: 10,
              child: SizedBox(
                height: expandedHeight / 2,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: GetBuilder<HomeScreenController>(
                      builder: (homeScreenController) {
                    return homeScreenController.operationReply.isLoading()
                        ? Center(child: Lottie.asset(Res.animApiLoading))
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AppCachedImage(
                                      imageUrl: homeScreenController
                                          .profileResponse
                                          ?.data
                                          ?.country
                                          ?.image,
                                      width: 30,
                                      height: 25,
                                      radius: 8,
                                    ),
                                    10.pw,
                                    AppText(
                                      '${homeScreenController.profileResponse?.data?.country?.name ?? ''}, ${homeScreenController.profileResponse?.data?.university?.name ?? ''}',
                                      fontSize: 16,
                                    )
                                  ],
                                ),
                              ),
                              10.ph,
                              Flexible(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AppText(
                                      '${homeScreenController.profileResponse?.data?.collage?.name ?? ''}, ',
                                      fontSize: 16,
                                    ),
                                    AppText(
                                      homeScreenController.profileResponse?.data
                                              ?.level?.name ??
                                          '',
                                      color: Constants.kClickableTextColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                  }),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => expandedHeight / 2;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
