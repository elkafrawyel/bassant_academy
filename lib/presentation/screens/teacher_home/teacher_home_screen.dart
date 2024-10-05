import 'package:bassant_academy/presentation/screens/messages/components/messages_list.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';

import '../../../app/res/res.dart';
import '../../../app/util/information_viewer.dart';
import '../../../app/util/operation_reply.dart';
import '../../../data/entities/general_response.dart';
import '../../../data/providers/network/api_provider.dart';
import '../../../data/providers/storage/local_provider.dart';
import '../../widgets/app_widgets/app_dialog.dart';
import 'my_students/my_students_list.dart';

class TeacherHomeScreen extends StatefulWidget {
  const TeacherHomeScreen({super.key});

  @override
  State<TeacherHomeScreen> createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: AppText('home'.tr),
          actions: [
            IconButton(
              onPressed: () {
                scaleDialog(
                  context: context,
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppText(
                      'logout_message'.tr,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  cancelText: 'cancel'.tr,
                  onCancelClick: Get.back,
                  confirmText: 'logout'.tr,
                  onConfirmClick: _singOut,
                  barrierDismissible: true,
                  cancelColor: Colors.black,
                  confirmColor: Colors.red,
                );
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.redAccent,
              ),
            )
          ],
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 3,
            labelStyle: const TextStyle(
              fontSize: 16,
            ),
            tabs: [
              Tab(
                text: 'my_students'.tr,
              ),
              Tab(
                text: 'messages'.tr,
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MyStudentsList(),
            MessagesList(),
          ],
        ),
      ),
    );
  }

  Future _singOut() async {
    OperationReply operationReply = await APIProvider.instance.get(
      endPoint: Res.apiLogout,
      fromJson: GeneralResponse.fromJson,
    );
    if (operationReply.isSuccess()) {
      GeneralResponse generalResponse = operationReply.result;
      await LocalProvider().signOut();
      InformationViewer.showSuccessToast(msg: generalResponse.message);
    } else {
      InformationViewer.showErrorToast(msg: operationReply.message);
    }
  }
}
