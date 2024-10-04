import 'dart:io';

import 'package:bassant_academy/data/providers/storage/local_provider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static String getImagePath(String name, {String format = 'png'}) {
    return 'assets/images/$name.$format';
  }

  static void logMessage(String message, {bool isError = false}) {
    if (kDebugMode) {
      Get.log(message, isError: isError);
    }
  }

  static hideGetXDialog() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  String formatNumbers(
    String number, {
    String? symbol,
    int? digits = 1,
  }) {
    return '${NumberFormat.decimalPatternDigits(
      locale: Get.locale?.languageCode == 'ar' ? 'ar_EG' : 'en_US',
      decimalDigits: digits,
    ).format(
      num.parse(number),
    )} ${symbol ?? (Get.locale?.languageCode == 'ar' ? 'ريال' : 'SAR')}';
  }

  static Future<String?> getUniqueDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
    return null;
  }

  Future<void> launchUrlString(String url) async {
    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      throw Exception('Could not launch $url');
    }
  }

  static String getTimeFromDate(DateTime? date, {DateFormat? dateFormat}) {
    if (date == null) {
      return '';
    } else {
      return DateFormat(
        dateFormat?.pattern ?? DateFormat.HOUR_MINUTE,
        LocalProvider().getAppLanguage(),
      ).format(date);
    }
  }
}
