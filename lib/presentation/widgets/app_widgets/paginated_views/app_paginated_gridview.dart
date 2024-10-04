import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/data/providers/storage/local_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/my_controllers/pagination_controller/data/config_data.dart';
import '../../../controller/my_controllers/pagination_controller/pagination_controller.dart';
import '../../api_state_views/handel_api_state.dart';
import '../app_text.dart';

class AppPaginatedGridView<T> extends StatefulWidget {
  final Widget Function(T item) child;
  final Widget? shimmerLoading;
  final Widget? emptyView;
  final ConfigData<T> configData;
  final int crossAxisCount;

  const AppPaginatedGridView({
    super.key,
    required this.child,
    required this.configData,
    required this.crossAxisCount,
    this.shimmerLoading,
    this.emptyView,
  });

  @override
  State<AppPaginatedGridView<T>> createState() =>
      _AppPaginatedGridviewState<T>();
}

class _AppPaginatedGridviewState<T> extends State<AppPaginatedGridView<T>> {
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
              : GridView.builder(
                  controller: _scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.crossAxisCount,
                  ),
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int index) =>
                      widget.shimmerLoading,
                ),
          child: RefreshIndicator(
            onRefresh: controller.refreshApiCall,
            child: controller.operationReply.isEmpty()
                ? widget.emptyView ?? const SizedBox()
                : Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          controller: _scrollController,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: widget.crossAxisCount,
                          ),
                          itemCount: controller.paginationList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return widget
                                .child(controller.paginationList[index]);
                          },
                        ),
                      ),
                      Offstage(
                        offstage: !controller.loadingMore &&
                            !controller.loadingMoreEnd,
                        child: Center(
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
                        ),
                      )
                    ],
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
              maxLines: 2,
              centerText: true,
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
