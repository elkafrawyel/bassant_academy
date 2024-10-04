import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/data/providers/storage/local_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/my_controllers/pagination_controller/data/config_data.dart';
import '../../../controller/my_controllers/pagination_controller/pagination_controller.dart';
import '../../api_state_views/handel_api_state.dart';
import '../app_text.dart';

class AppPaginatedListview<T> extends StatefulWidget {
  final Widget Function(T item) child;
  final Widget? shimmerLoading;
  final Widget? emptyView;
  final ConfigData<T> configData;

  const AppPaginatedListview({
    super.key,
    required this.child,
    required this.configData,
    this.shimmerLoading,
    this.emptyView,
  });

  @override
  State<AppPaginatedListview<T>> createState() =>
      _AppPaginatedListviewState<T>();
}

class _AppPaginatedListviewState<T> extends State<AppPaginatedListview<T>> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaginationController<T>>(
      init: PaginationController<T>(
        widget.configData,
      ),
      dispose: (state) {
        _scrollController.dispose();
      },
      initState: (state) {
        _scrollController.addListener(
          () {
            if (_scrollController.position.pixels ==
                _scrollController.position.maxScrollExtent) {
              state.controller?.callMoreData();
            }
          },
        );
      },
      builder: (controller) {
        return HandleApiState.operation(
          operationReply: controller.operationReply,
          shimmerLoader: widget.shimmerLoading == null
              ? null
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) =>
                      widget.shimmerLoading,
                ),
          child: RefreshIndicator(
            backgroundColor: Theme.of(context).primaryColor,
            color: Colors.white,
            onRefresh: controller.refreshApiCall,
            child: controller.operationReply.isEmpty()
                ? widget.emptyView ?? const SizedBox()
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: controller.paginationList.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index < controller.paginationList.length) {
                        return widget.child(controller.paginationList[index]);
                      } else {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 28.0,
                              top: 18.0,
                            ),
                            child: controller.loadingMoreEnd
                                ? _loadingMoreEndView()
                                : controller.loadingMore
                                    ? _loadingMoreView()
                                    : const SizedBox(),
                          ),
                        );
                      }
                    },
                  ),
          ),
        );
      },
    );
  }

  Widget _loadingMoreView() => Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator.adaptive(),
            10.pw,
            AppText(
              LocalProvider().isAr()
                  ? 'يتم تحميل مزيد من البيانات'
                  : 'Loading more data from',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade300,
            ),
          ],
        ),
      );

  Widget _loadingMoreEndView() => Center(
        child: AppText(
          LocalProvider().isAr()
              ? 'لا يوجد المزيد من البيانات'
              : 'End of the data',
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Colors.grey.shade300,
        ),
      );
}
