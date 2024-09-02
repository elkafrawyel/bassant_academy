import 'package:bassant_academy/app/res/res.dart';
import 'package:bassant_academy/app/util/operation_reply.dart';
import 'package:bassant_academy/data/entities/profile_response.dart';
import 'package:bassant_academy/data/providers/network/api_provider.dart';
import 'package:bassant_academy/presentation/screens/country/country_screen.dart';
import 'package:get/route_manager.dart';

import '../my_controllers/general_controller.dart';

class HomeScreenController extends GeneralController {
  ProfileResponse? profileResponse;

  @override
  void onInit() async {
    super.onInit();

    init();
  }

  Future init() async {
    operationReply = OperationReply.loading();

    operationReply = await APIProvider.instance.get(
      endPoint: Res.apiGetStudentProfile,
      fromJson: ProfileResponse.fromJson,
    );
    if (operationReply.isSuccess()) {
      profileResponse = operationReply.result;

      if (profileResponse?.data?.user?.isFirstLogin ?? false) {
        operationReply = OperationReply.empty(message: '');
        Get.to(() => const CountryScreen());
      } else {
        operationReply = OperationReply.success();
      }
    } else {
      operationReply = OperationReply.failed(message: operationReply.message);
    }
  }

  @override
  Future<void> refreshApiCall() async {
    await init();
  }
}
