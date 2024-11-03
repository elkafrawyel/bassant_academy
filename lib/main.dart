import 'dart:io';

import 'package:bassant_academy/app/config/notifications/notifications_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_prevent_screenshot/disablescreenshot.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

import 'app/util/util.dart';
import 'data/providers/storage/local_provider.dart';
import 'firebase_options.dart';
import 'presentation/app.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (
        X509Certificate cert,
        String host,
        int port,
      ) =>
          true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  await LocalProvider().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationsService().init();
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);
  await setUpSecureMode(enabled: true);

  runApp(const App());
}

Future setUpSecureMode({required bool enabled}) async {
  if (enabled) {
    ///flutter_windowmanager
    if (Platform.isAndroid) {
      await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    }

    ///flutter_prevent_screenshot
    await FlutterPreventScreenshot.instance.screenshotOff();
  } else {
    ///flutter_windowmanager
    if (Platform.isAndroid) {
      await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
    }

    ///flutter_prevent_screenshot
    await FlutterPreventScreenshot.instance.screenshotOn();
  }
}

Future _firebaseBackgroundMessage(RemoteMessage remoteMessage) async {
  if (remoteMessage.notification != null) {
    Utils.logMessage('Background Notification Received.');
  }
}
