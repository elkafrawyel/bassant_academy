import 'dart:io';

import 'package:fcm_config/fcm_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  await initializeNotifications();
  await setUpSecureMode(enabled: true);
  runApp(const App());
}

setUpSecureMode({required bool enabled}) async {
  if (enabled) {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  } else {
    await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
  }
}

Future initializeNotifications() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FCMConfig.instance.init(
    onBackgroundMessage: _firebaseMessagingBackgroundHandler,
    defaultAndroidChannel: const AndroidNotificationChannel(
      'com.bassant.academy',
      'Bassant Academy',
    ),
  );

  FCMConfig.instance.messaging.getToken().then((token) {
    Utils.logMessage('Firebase Token:$token');
  });
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  Utils.logMessage("Handling a background message: ${message.messageId}");
}
