import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/app/res/res.dart';
import 'package:bassant_academy/app/util/information_viewer.dart';
import 'package:bassant_academy/app/util/operation_reply.dart';
import 'package:bassant_academy/data/entities/general_response.dart';
import 'package:bassant_academy/data/providers/network/api_provider.dart';
import 'package:bassant_academy/presentation/controller/home_screen/home_screen_controller.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/app_widgets/app_progress_button.dart';
import '../../widgets/app_widgets/app_text_field/app_text_field.dart';
import '../change_password/change_password_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  final GlobalKey<AppTextFormFieldState> nameKey =
      GlobalKey<AppTextFormFieldState>();

  late TextEditingController emailController;

  final GlobalKey<AppTextFormFieldState> emailKey =
      GlobalKey<AppTextFormFieldState>();

  late TextEditingController phoneController;
  final GlobalKey<AppTextFormFieldState> phoneKey =
      GlobalKey<AppTextFormFieldState>();

  final HomeScreenController homeScreenController = Get.find();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: homeScreenController.profileResponse?.data?.user?.name,
    );
    emailController = TextEditingController(
      text: homeScreenController.profileResponse?.data?.user?.email,
    );
    phoneController = TextEditingController(
      text: homeScreenController.profileResponse?.data?.user?.phone,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          'edit_profile'.tr,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 12.0,
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => const ChangePasswordScreen());
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.lock,
                        color: Colors.red.shade500,
                      ),
                      5.pw,
                      AppText(
                        'change_password'.tr,
                        underLine: true,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
              20.ph,
              Center(
                child: AppProgressButton(
                  onPressed: _editProfile,
                  text: 'change'.tr,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future _editProfile(AnimationController animationController) async {
    phoneKey.currentState?.updateHelperText('');

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
    } else {
      animationController.forward();
      OperationReply operationReply = await APIProvider.instance.post(
        endPoint: Res.apiEditProfile,
        fromJson: GeneralResponse.fromJson,
        requestBody: {
          "name": nameController.text,
          "email": emailController.text,
          "phone": phoneController.text,
        },
      );
      if (operationReply.isSuccess()) {
        animationController.reverse();

        GeneralResponse generalResponse = operationReply.result;
        InformationViewer.showSuccessToast(msg: generalResponse.message);
        homeScreenController.init();
      } else {
        animationController.reverse();
        phoneKey.currentState?.updateHelperText(operationReply.message);
        InformationViewer.showErrorToast(msg: operationReply.message);
      }
    }
  }
}
