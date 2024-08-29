import 'package:flutter/material.dart';

class Constants {
  // Colors
  static Color kClickableTextColor = const Color(0xffC56D1C);
  // static String mainAppLanguage = 'en';

  // static String mainAppLanguage = Get.deviceLocale?.languageCode ?? 'ar';
  static String mainAppLanguage = 'ar';
  static String defaultUserType = 'client';
  static String defaultApiTokenType = 'Bearer';
}

double kRadius = 18;
double kBorderWidth = 0.0;
double kSelectedBorderWidth = 2;

final List<BoxShadow> shadows = [
  const BoxShadow(
    color: Color(0x28000000),
    offset: Offset(0, 5),
    blurRadius: 30,
  ),
];
