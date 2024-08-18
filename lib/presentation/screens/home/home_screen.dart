import 'package:bassant_academy/app/types/booking_filter_type.dart';
import 'package:bassant_academy/presentation/controller/home_screen_controller/home_screen_controller.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText('app_name'.tr),
      ),
      body: GetBuilder<HomeScreenController>(
        builder: (homeScreenController) {
          return Center(
            child: AppText('app_name'.tr),
          );
        },
      ),
    );
  }
}
