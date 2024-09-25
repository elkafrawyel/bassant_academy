import 'package:bassant_academy/app/config/notifications/notification_mixin.dart';
import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/app/res/res.dart';
import 'package:bassant_academy/presentation/controller/notifications/notifications_controller.dart';
import 'package:bassant_academy/presentation/screens/notifications/components/notification_card_view.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/entities/notification_model.dart';
import '../../controller/my_controllers/pagination_controller/data/config_data.dart';
import '../../widgets/api_state_views/handel_api_state.dart';
import '../../widgets/api_state_views/pagination_view.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with FCMNotificationMixin {
  final NotificationsController notificationsController = Get.put(
    NotificationsController(
      ConfigData(
        apiEndPoint: Res.apiNotifications,
        // emptyListMessage: 'empty_notifications'.tr,
        fromJson: NotificationModel.fromJson,
        isPostRequest: true,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          'notifications'.tr,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: false,
      ),
      body: GetBuilder<NotificationsController>(
        builder: (_) {
          return HandleApiState.operation(
            operationReply: notificationsController.operationReply,
            emptyView: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications,
                    size: 200,
                    color: Colors.grey.shade500,
                  ),
                  20.ph,
                  AppText(
                    'empty_notifications'.tr,
                    color: Colors.grey.shade500,
                    fontSize: 16,
                  ),
                  // 40.ph,
                  // ElevatedButton(
                  //   onPressed: () {
                  //     notificationsController.refreshApiCall();
                  //   },
                  //   style:
                  //       ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 38.0),
                  //     child: AppText(
                  //       'refresh'.tr,
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
            child: PaginationView(
              loadMoreData: notificationsController.callMoreData,
              showLoadMoreWidget: notificationsController.loadingMore,
              showLoadMoreEndWidget: notificationsController.loadingMoreEnd,
              child: RefreshIndicator(
                color: const Color(0xff3D6AA5),
                backgroundColor: Colors.white,
                onRefresh: notificationsController.refreshApiCall,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                    itemBuilder: (context, index) => NotificationCardView(
                      notificationModel:
                          notificationsController.paginationList[index],
                    ),
                    separatorBuilder: (context, index) => 5.ph,
                    itemCount: notificationsController.paginationList.length,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void onNotify(RemoteMessage notification) {
    notificationsController.refreshApiCall(loading: false);
  }
}
