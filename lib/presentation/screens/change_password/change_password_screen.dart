import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/res/res.dart';
import '../../../app/util/information_viewer.dart';
import '../../../app/util/operation_reply.dart';
import '../../../data/entities/general_response.dart';
import '../../../data/providers/network/api_provider.dart';
import '../../widgets/app_widgets/app_progress_button.dart';
import '../../widgets/app_widgets/app_text_field/app_text_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<AppTextFormFieldState> passwordState =
      GlobalKey<AppTextFormFieldState>();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<AppTextFormFieldState> confirmPasswordState =
      GlobalKey<AppTextFormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          'change_password'.tr,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            children: [
              AppTextFormField(
                key: passwordState,
                controller: passwordController,
                hintText: 'password'.tr,
                appFieldType: AppFieldType.password,
              ),
              AppTextFormField(
                key: confirmPasswordState,
                controller: confirmPasswordController,
                hintText: 'confirm_password'.tr,
                appFieldType: AppFieldType.confirmPassword,
              ),
              20.ph,
              AppProgressButton(
                onPressed: _changePassword,
                text: 'change'.tr,
                width: MediaQuery.sizeOf(context).width / 1.5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _changePassword(AnimationController animationController) async {
    if (passwordController.text.isEmpty ||
        (passwordState.currentState?.hasError ?? false)) {
      passwordState.currentState?.shake();
      return;
    } else if (confirmPasswordController.text.isEmpty ||
        (confirmPasswordState.currentState?.hasError ?? false)) {
      confirmPasswordState.currentState?.shake();
      return;
    } else {
      animationController.forward();
      OperationReply operationReply = await APIProvider.instance.post(
        endPoint: Res.apiEditProfile,
        fromJson: GeneralResponse.fromJson,
        requestBody: {
          "password": passwordController.text,
        },
      );
      if (operationReply.isSuccess()) {
        GeneralResponse generalResponse = operationReply.result;
        InformationViewer.showSuccessToast(msg: generalResponse.message);
        Get.back();
      } else {
        InformationViewer.showErrorToast(msg: operationReply.message);
      }
    }
  }
}
