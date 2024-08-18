import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/app/res/res.dart';
import 'package:bassant_academy/presentation/controller/app_config_controller.dart';
import 'package:bassant_academy/presentation/screens/home/home_screen.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_progress_button.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_text.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_text_field/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<AppTextFormFieldState> phoneState = GlobalKey<AppTextFormFieldState>();
  final GlobalKey<AppTextFormFieldState> passwordState = GlobalKey<AppTextFormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 12),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Image.asset(
                  Res.logoImage,
                  width: 150,
                  height: 150,
                ),
              ),
              AppTextFormField(
                key: phoneState,
                controller: phoneController,
                hintText: 'phoneOrEmail'.tr,
                appFieldType: AppFieldType.text,
                // prefixIcon: Res.iconPhone,
              ),
              AppTextFormField(
                key: passwordState,
                controller: passwordController,
                hintText: 'password'.tr,
                appFieldType: AppFieldType.password,
                // prefixIcon: Res.iconPassword,
              ),
              20.ph,
              AppProgressButton(
                onPressed: _login,
                text: 'login'.tr,
                width: MediaQuery.sizeOf(context).width / 1.5,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future _login(AnimationController animationController) async {
    if (phoneController.text.isEmpty || (phoneState.currentState?.hasError ?? false)) {
      phoneState.currentState?.shake();
      return;
    } else if (passwordController.text.isEmpty || (passwordState.currentState?.hasError ?? false)) {
      passwordState.currentState?.shake();
      return;
    } else {
      Get.find<AppConfigController>().isLoggedIn.value = true;
    }
  }
}
