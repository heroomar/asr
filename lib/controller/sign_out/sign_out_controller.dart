import 'package:crypinvest/controller/app_settings/app_setting_controller.dart';
import 'package:get/get.dart';

import '../../../backend/local_storage/local_storage.dart';
import '../../../backend/model/common/common_success_model.dart';
import '../../../backend/services/api_services.dart';
import '../../../routes/routes.dart';

class LogOutController extends GetxController {
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;
  late CommonSuccessModel _logOutModel;

  CommonSuccessModel get logOutModel => _logOutModel;

  Future<CommonSuccessModel> logOutProcess() async {
    _isLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {};

    await ApiServices.logOutApi(body: inputBody).then((value) {
      _logOutModel = value!;
      LocalStorage.logout();
      final appSettingsController = Get.put(AppSettingsController());
      appSettingsController.getAppSettingsData();
      Get.offAllNamed(Routes.signInScreen);
      update();
    }).catchError((onError) {
      log.e(onError);
      _isLoading.value = false;
    });

    _isLoading.value = false;
    update();
    return _logOutModel;
  }
}
