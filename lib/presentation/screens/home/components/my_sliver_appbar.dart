import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/presentation/screens/notifications/notifications_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../app/res/res.dart';
import '../../../../app/util/constants.dart';
import '../../../controller/home_screen/home_screen_controller.dart';
import '../../../widgets/app_widgets/app_cached_image.dart';
import '../../../widgets/app_widgets/app_text.dart';

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
                    AppText(
                      "${'hello'.tr}, أحمد",
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
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
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppCachedImage(
                              imageUrl: homeScreenController.countryImage,
                              width: 30,
                              height: 25,
                              radius: 8,
                            ),
                            10.pw,
                            AppText(
                              '${homeScreenController.countryName} , ${homeScreenController.universityName}',
                              fontSize: 16,
                            )
                          ],
                        ),
                        10.ph,
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppText(
                              '${homeScreenController.collegeName}, ',
                              fontSize: 16,
                            ),
                            AppText(
                              homeScreenController.levelName,
                              color: Constants.kClickableTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
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

  Widget _cardView() => Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  const AppCachedImage(
                    imageUrl:
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_Egypt.svg/1024px-Flag_of_Egypt.svg.png',
                    width: 40,
                    height: 30,
                    radius: 8,
                  ),
                  10.pw,
                  const AppText('مصر , جامعة المنصورة')
                ],
              ),
              Row(
                children: [
                  const AppText('كلية الطب البشري , '),
                  AppText(
                    'الفرقة الرابعة',
                    color: Constants.kClickableTextColor,
                  ),
                ],
              )
            ],
          ),
        ),
      );
}
