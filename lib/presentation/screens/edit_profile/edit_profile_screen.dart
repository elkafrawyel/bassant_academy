import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../widgets/app_widgets/app_progress_button.dart';
import '../../widgets/app_widgets/app_text_field/app_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<AppTextFormFieldState> nameKey = GlobalKey<AppTextFormFieldState>();

  final TextEditingController emailController = TextEditingController();
  final GlobalKey<AppTextFormFieldState> emailKey = GlobalKey<AppTextFormFieldState>();

  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<AppTextFormFieldState> phoneKey = GlobalKey<AppTextFormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText('edit_profile'.tr),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
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
              20.ph,
              AppProgressButton(
                onPressed: _editProfile,
                text: 'change'.tr,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future _editProfile(AnimationController animationController) async {
    if (nameController.text.isEmpty || (nameKey.currentState?.hasError ?? false)) {
      nameKey.currentState?.shake();
      return;
    } else if (emailController.text.isEmpty || (emailKey.currentState?.hasError ?? false)) {
      emailKey.currentState?.shake();
      return;
    } else if (phoneController.text.isEmpty || (phoneKey.currentState?.hasError ?? false)) {
      phoneKey.currentState?.shake();
      return;
    } else {}
  }
}
