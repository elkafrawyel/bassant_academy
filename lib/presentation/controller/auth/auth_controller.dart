import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {

  AuthController();

  void login({
    required String phone,
    required String password,
    required AnimationController animationController,
    bool? rememberMe,
  }) async {
    animationController.forward();

    animationController.reverse();
  }

  void forgetPassword({
    required String phoneNumber,
    required AnimationController animationController,
  }) async {
    animationController.forward();

  }

  Future register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required AnimationController animationController,
  }) async {

    animationController.forward();

    animationController.reverse();
  }
}
