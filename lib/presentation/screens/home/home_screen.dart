import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/app/res/res.dart';
import 'package:bassant_academy/app/util/constants.dart';
import 'package:bassant_academy/presentation/controller/home_screen_controller/home_screen_controller.dart';
import 'package:bassant_academy/presentation/screens/home/components/app_horizontal_list_view.dart';
import 'package:bassant_academy/presentation/screens/home/components/side_menu.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_cached_image.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'components/my_sliver_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const SideMenu(),
      body: GetBuilder<HomeScreenController>(
        builder: (homeScreenController) {
          return CustomScrollView(
            slivers: [
              // SliverAppBar(
              //   elevation: 1.0,
              //   surfaceTintColor: Colors.transparent,
              //   // backgroundColor: Theme.of(context).primaryColor,
              //   leadingWidth: 50,
              //   centerTitle: false,
              //   leading: IconButton(
              //     onPressed: () {
              //       scaffoldKey.currentState?.openDrawer();
              //     },
              //     icon: Icon(
              //       Icons.menu,
              //       color: Constants.kClickableTextColor,
              //     ),
              //   ),
              //   title: Text(
              //     '${'hello'.tr}, أحمد',
              //     style: const TextStyle(
              //       color: Colors.white,
              //     ),
              //   ),
              //   pinned: true,
              //   snap: false,
              //   floating: true,
              //   expandedHeight: MediaQuery.sizeOf(context).height * 0.2,
              //   flexibleSpace: FlexibleSpaceBar(
              //     background: Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Stack(
              //         fit: StackFit.passthrough,
              //         alignment: AlignmentDirectional.bottomCenter,
              //         children: [
              //           Container(
              //             decoration: BoxDecoration(
              //                 color: Theme.of(context).primaryColor,
              //                 borderRadius: BorderRadiusDirectional.vertical(bottom: Radius.circular(30))),
              //           ),
              //           PositionedDirectional(
              //             bottom: -20,
              //             start: 0,
              //             end: 0,
              //             child: Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Card(
              //                 child: Column(
              //                   mainAxisSize: MainAxisSize.min,
              //                   children: [
              //                     Row(
              //                       children: [
              //                         const AppCachedImage(
              //                           imageUrl:
              //                               'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_Egypt.svg/1024px-Flag_of_Egypt.svg.png',
              //                           isCircular: true,
              //                           width: 40,
              //                           height: 40,
              //                         ),
              //                         20.pw,
              //                         const AppText('مصر , جامعة المنصورة')
              //                       ],
              //                     )
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              //   actions: [
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: SvgPicture.asset(
              //         Res.iconNotification,
              //       ),
              //     )
              //   ],
              // ),
              SliverPersistentHeader(
                delegate: MySliverAppBar(
                  expandedHeight: MediaQuery.sizeOf(context).height * 0.24,
                  scaffoldKey: scaffoldKey,
                ),
                pinned: true,
              ),
              SliverPadding(
                padding: const EdgeInsets.only(top: 80),
                sliver: SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          width: 5,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        10.pw,
                        AppText(
                          'your_study_material'.tr,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  homeScreenController.operationReply.isLoading()
                      ? [
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height / 2,
                            child: const Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          ),
                        ]
                      : homeScreenController.subjects
                          .map(
                            (subject) => AppHorizontalListView(
                              title: subject['name'],
                              data: subject['lessons'],
                            ),
                          )
                          .toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
