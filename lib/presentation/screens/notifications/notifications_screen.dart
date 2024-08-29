import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/presentation/controller/notifications/notifications_controller.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/entities/notification_model.dart';
import '../../controller/my_controllers/pagination_controller/data/config_data.dart';
import '../../widgets/api_state_views/handel_api_state.dart';
import '../../widgets/api_state_views/pagination_view.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});

  final NotificationsController notificationsController = Get.put(
    NotificationsController(
      ConfigData(
        apiEndPoint: 'notifications',
        emptyListMessage: 'empty_notifications'.tr,
        fromJson: NotificationsModel.fromJson,
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
                  const Icon(
                    Icons.notifications,
                    size: 200,
                    color: Colors.black45,
                  ),
                  20.ph,
                  AppText('empty_notifications'.tr),
                  40.ph,
                  ElevatedButton(
                    onPressed: () {
                      notificationsController.refreshApiCall();
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 38.0),
                      child: AppText(
                        'refresh'.tr,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
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
                child: ListView.separated(
                  itemBuilder: (context, index) => Card(
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(
                      width: 0.2,
                    )),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(38.0),
                        child: AppText(
                            notificationsController.paginationList[index].id ??
                                ''),
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => 5.ph,
                  itemCount: notificationsController.paginationList.length,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
