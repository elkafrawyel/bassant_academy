import 'package:bassant_academy/app/res/res.dart';
import 'package:bassant_academy/presentation/controller/app_config_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../widgets/animated_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.find<AppConfigController>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color(0xffEFC75E),
              Color(0xffC56D1C)
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: AnimatedWidgets(
              duration: 2,
              horizontalOffset: 0,
              verticalOffset: 200,
              child: Image.asset(
                Res.logoWhiteImage,
                width: 250,
                height: 250,
              ),
            ),
          ),
        ),
      ),
    );
  }
}