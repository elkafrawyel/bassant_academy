import 'package:bassant_academy/app/util/operation_reply.dart';
import 'package:bassant_academy/presentation/controller/general_controller.dart';
import 'package:fcm_config/fcm_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/util/util.dart';
import '../../../firebase_options.dart';

class HomeScreenController extends GeneralController {
  List subjects = [];

  @override
  void onInit() async {
    super.onInit();
    initializeNotifications();
    getSubjects();
  }

  Future<void> getSubjects() async {
    operationReply = OperationReply.loading();
    await Future.delayed(const Duration(seconds: 4));
    subjects = [
      {
        'name': 'مادة الهستولوجيا',
        'lessons': [
          {'name': 'هستولوجي (علم الانسجة) المحاضرة الأولي'},
          {'name': 'هستولوجي (علم الانسجة) المحاضرة الثانية'},
          {'name': 'هستولوجي (علم الانسجة) المحاضرة الثالثة'}
        ]
      },
      {
        'name': 'الفارماكولوجيا الاكلينيكية',
        'lessons': [
          {'name': 'الفارماكولوجيا الاكلينيكية 1'},
          {'name': 'الفارماكولوجيا الاكلينيكية 2'},
          {'name': 'الفارماكولوجيا الاكلينيكية 3'}
        ]
      },
      {
        'name': 'الفارماكولوجيا الاكلينيكية',
        'lessons': [
          {'name': 'الفارماكولوجيا الاكلينيكية 1'},
          {'name': 'الفارماكولوجيا الاكلينيكية 2'},
          {'name': 'الفارماكولوجيا الاكلينيكية 3'}
        ]
      },
      {
        'name': 'الفارماكولوجيا الاكلينيكية',
        'lessons': [
          {'name': 'الفارماكولوجيا الاكلينيكية 1'},
          {'name': 'الفارماكولوجيا الاكلينيكية 2'},
          {'name': 'الفارماكولوجيا الاكلينيكية 3'}
        ]
      },
    ];

    operationReply = OperationReply.success();
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

  @override
  Future<void> refreshApiCall() async {
    await getSubjects();
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  Utils.logMessage("Handling a background message: ${message.messageId}");
  // Get.find<HomeScreenController>().handleRemoteMessage(message);
}
