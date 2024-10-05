import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/config/app_theme.dart';
import '../../app/util/util.dart';
import '../../data/providers/storage/local_provider.dart';
import '../screens/auth/login/login_screen.dart';
import '../screens/home/home_screen.dart';
import 'auth/auth_binding.dart';
import 'home_screen/home_screen_binding.dart';

class AppConfigController extends GetxController {
  RxBool isLoggedIn = false.obs;
  RxBool isDarkMode = false.obs;
  Rx<ThemeData> theme = AppTheme.lightTheme.obs;
  String appVersion = "Not detected";

  List<Locale> supportedLocales = const [
    Locale('ar', 'EG'),
    Locale('en', 'US'),
  ];

  @override
  onReady() {
    super.onReady();

    ever(isLoggedIn, (callback) async {
      Utils.logMessage('Ever called on logged in callback');
      debugPrint('isLoggedIn =>$callback');
      if (callback) {
        // Get.offAll(() => const TeacherHomeScreen());
        Get.offAll(() => const HomeScreen(), binding: HomeScreenBinding());
      } else {
        Get.offAll(() => const LoginScreen(), binding: AuthBinding());
      }
    });
  }

  initialize() async {
    isLoggedIn.value = LocalProvider().isLogged();
  }
}
