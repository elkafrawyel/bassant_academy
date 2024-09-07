import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/app/util/information_viewer.dart';
import 'package:bassant_academy/app/util/operation_reply.dart';
import 'package:bassant_academy/app/util/util.dart';
import 'package:bassant_academy/data/providers/network/api_provider.dart';
import 'package:bassant_academy/data/providers/storage/local_provider.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_progress_button.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_text_field/app_text_field.dart';
import 'package:fcm_config/fcm_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';

import '../../../../app/res/res.dart';
import '../../../../data/entities/auth_response.dart';
import '../../../controller/app_config_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<AppTextFormFieldState> nameKey =
      GlobalKey<AppTextFormFieldState>();

  final TextEditingController emailController = TextEditingController();
  final GlobalKey<AppTextFormFieldState> emailKey =
      GlobalKey<AppTextFormFieldState>();

  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<AppTextFormFieldState> phoneKey =
      GlobalKey<AppTextFormFieldState>();

  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<AppTextFormFieldState> passwordKey =
      GlobalKey<AppTextFormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'sign_up',
          child: Text('sign_up'.tr),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Center(
                child: Hero(
                  tag: 'logo',
                  child: SvgPicture.asset(
                    Res.iconLogo,
                    width: 150,
                    height: 150,
                  ),
                ),
              ),
              AppTextFormField(
                key: nameKey,
                controller: nameController,
                hintText: 'name'.tr,
                appFieldType: AppFieldType.text,
              ),
              AppTextFormField(
                key: emailKey,
                controller: emailController,
                hintText: 'email'.tr,
                appFieldType: AppFieldType.email,
              ),
              AppTextFormField(
                key: phoneKey,
                controller: phoneController,
                hintText: 'phone'.tr,
                appFieldType: AppFieldType.phone,
              ),
              AppTextFormField(
                key: passwordKey,
                controller: passwordController,
                hintText: 'password'.tr,
                appFieldType: AppFieldType.password,
              ),
              20.ph,
              AppProgressButton(
                onPressed: _signUp,
                text: 'sign_up'.tr,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future _signUp(AnimationController animationController) async {
    passwordKey.currentState?.updateHelperText('');
    if (nameController.text.isEmpty ||
        (nameKey.currentState?.hasError ?? false)) {
      nameKey.currentState?.shake();
      return;
    } else if (emailController.text.isEmpty ||
        (emailKey.currentState?.hasError ?? false)) {
      emailKey.currentState?.shake();
      return;
    } else if (phoneController.text.isEmpty ||
        (phoneKey.currentState?.hasError ?? false)) {
      phoneKey.currentState?.shake();
      return;
    } else if (passwordController.text.isEmpty ||
        (passwordKey.currentState?.hasError ?? false)) {
      passwordKey.currentState?.shake();
      return;
    } else {
      animationController.forward();
      String? deviceId = await Utils.getUniqueDeviceId();
      String? firebaseToken = await FCMConfig.instance.messaging.getToken();
      OperationReply operationReply = await APIProvider.instance.post(
        endPoint: Res.apiRegister,
        fromJson: AuthResponse.fromJson,
        requestBody: {
          'username': nameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'phone': phoneController.text,
          'DeviceId': deviceId,
          'FcmToken': firebaseToken,
        },
      );

      if (operationReply.isSuccess()) {
        AuthResponse authResponse = operationReply.result;
        if (authResponse.isAuthenticated ?? false) {
          animationController.reverse();
          await LocalProvider()
              .save(LocalProviderKeys.apiToken, authResponse.token);
          APIProvider.instance.updateTokenHeader(authResponse.token);

          await LocalProvider().save(
            LocalProviderKeys.userId,
            authResponse.userId,
          );
          Get.find<AppConfigController>().isLoggedIn.value = true;
        }
      } else {
        animationController.reverse();
        passwordKey.currentState?.updateHelperText(operationReply.message);
        InformationViewer.showSnackBar(
          operationReply.message,
        );
      }
    }
  }
}
