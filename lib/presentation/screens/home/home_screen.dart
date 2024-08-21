import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/app/res/res.dart';
import 'package:bassant_academy/app/util/constants.dart';
import 'package:bassant_academy/presentation/controller/home_screen_controller/home_screen_controller.dart';
import 'package:bassant_academy/presentation/screens/home/components/app_horizontal_list_view.dart';
import 'package:bassant_academy/presentation/screens/home/components/app_shimmer_horizontal_list_view.dart';
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
          return RefreshIndicator(
            onRefresh: homeScreenController.refreshApiCall,
            child: CustomScrollView(
              slivers: [
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
                SliverPadding(
                  padding: const EdgeInsetsDirectional.only(bottom: 50),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      homeScreenController.operationReply.isLoading()
                          ? [
                              const AppShimmerHorizontalListView(),
                              const AppShimmerHorizontalListView(),
                              const AppShimmerHorizontalListView(),
                              const AppShimmerHorizontalListView(),
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
