import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/config/app_theme.dart';
import '../../app/util/util.dart';
import '../../data/providers/storage/local_provider.dart';
import '../screens/auth/login/login_screen.dart';
import '../screens/home/home_screen.dart';
import 'auth_controller/auth_binding.dart';
import 'home_screen_controller/home_screen_binding.dart';

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
        Get.offAll(() => const HomeScreen(), binding: HomeScreenBinding());
      } else {
        // if (LocalProvider().get(LocalProviderKeys.introScreen) == 0) {
        //   Get.offAll(() => const IntroScreen());
        // } else {
        Get.offAll(() => const LoginScreen(), binding: AuthBinding());
        // }
      }
    });
  }

  initialize() async {
    isLoggedIn.value = LocalProvider().isLogged();
    _applySavedTheme();
    // PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // appVersion = packageInfo.version;
  }

  void _applySavedTheme() {
    int currentTheme = LocalProvider().get(LocalProviderKeys.appTheme) ?? 0;
    if (currentTheme != 1) {
      theme.value = AppTheme.lightTheme;
      isDarkMode.value = false;
    } else {
      theme.value = AppTheme.darkTheme;
      isDarkMode.value = true;
    }
  }

  void toggleAppTheme() async {
    int currentTheme = LocalProvider().get(LocalProviderKeys.appTheme) ?? 0;
    await LocalProvider().save(LocalProviderKeys.appTheme, currentTheme == 1 ? 0 : 1);
    if (theme.value == AppTheme.darkTheme) {
      theme.value = AppTheme.lightTheme;
      isDarkMode.value = false;
    } else {
      theme.value = AppTheme.darkTheme;
      isDarkMode.value = true;
    }
  }
}
