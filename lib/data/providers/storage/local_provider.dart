import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../app/util/constants.dart';
import '../../../app/util/util.dart';
import '../../../presentation/controller/app_config_controller.dart';
import '../network/api_provider.dart';

enum LocalProviderKeys {
  language, //String
  notifications, //int
  apiToken, //String
  userId, //String
  isStudent, //int
}

class LocalProvider {
  final GetStorage _box = GetStorage();

  Future init() async {
    await GetStorage.init();
    //set keys default values
    dynamic language = get(LocalProviderKeys.language);
    if (language == null) {
      save(LocalProviderKeys.language, Constants.mainAppLanguage);
    }

    dynamic notifications = get(LocalProviderKeys.notifications);
    if (notifications == null) {
      save(LocalProviderKeys.notifications, true);
    }

    debugPrint('LocalProvider initialization.');
  }

  String getAppLanguage() =>
      get(LocalProviderKeys.language) ?? Constants.mainAppLanguage;

  bool isLogged() => get(LocalProviderKeys.apiToken) != null;

  String? apiToken() => get(LocalProviderKeys.apiToken);

  bool isAr() => get(LocalProviderKeys.language) == 'ar';

  /// ============= ============== ===================  =================
  Future save(LocalProviderKeys localProviderKeys, dynamic value) async {
    await GetStorage().write(localProviderKeys.name, value);
    Utils.logMessage('Setting value to ${localProviderKeys.name} => $value');
  }

  dynamic get(LocalProviderKeys localProviderKeys) {
    return GetStorage().read(localProviderKeys.name);
  }

  Future<void> signOut() async {
    await _box.erase();
    Get.find<AppConfigController>().isLoggedIn.value = false;
    APIProvider.instance.updateTokenHeader(null);
    Utils.logMessage('User Logged Out Successfully');
  }
}
