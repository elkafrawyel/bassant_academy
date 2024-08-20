import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/app/res/res.dart';
import 'package:bassant_academy/app/types/booking_filter_type.dart';
import 'package:bassant_academy/app/util/constants.dart';
import 'package:bassant_academy/presentation/controller/home_screen_controller/home_screen_controller.dart';
import 'package:bassant_academy/presentation/screens/home/components/side_menu.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_cached_image.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

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
        drawer: SideMenu(),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 1.0,
              surfaceTintColor: Colors.transparent,
              leadingWidth: 50,
              centerTitle: false,
              backgroundColor: Theme.of(context).primaryColor,
              leading: IconButton(
                onPressed: () {
                  scaffoldKey.currentState?.openDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  color: Constants.kClickableTextColor,
                ),
              ),
              title: Text(
                '${'hello'.tr}, أحمد',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              expandedHeight: MediaQuery.sizeOf(context).height * 0.2,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      100.ph,
                      Card(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                AppCachedImage(
                                  imageUrl:
                                      'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_Egypt.svg/1024px-Flag_of_Egypt.svg.png',
                                  isCircular: true,
                                  width: 40,
                                  height: 40,
                                ),
                                20.pw,
                                AppText('مصر , جامعة المنصورة')
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    Res.iconNotification,
                  ),
                )
              ],
            )
          ],
        ));
  }
}
