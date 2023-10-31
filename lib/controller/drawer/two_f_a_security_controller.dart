import 'package:crypinvest/controller/drawer/settings/two_f_a_otp_controller.dart';
import 'package:crypinvest/routes/routes.dart';

import '../../../../utils/basic_screen_imports.dart';
import '../../backend/model/authorization/two_fa/two_fa_model.dart';
import '../../backend/model/common/common_success_model.dart';
import '../../backend/services/api_services.dart';

class TwoFASecurityController extends GetxController {
  final controller = Get.put(TwoFAOtpVerificationController());

  @override
  void onInit() {
    getGoogleTwoFaData();
    super.onInit();
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late GoogleTwoFaModel _googleTwoFaModel;
  GoogleTwoFaModel get googleTwoFaModel => _googleTwoFaModel;

  Future<GoogleTwoFaModel> getGoogleTwoFaData() async {
    _isLoading.value = true;
    update();

    await ApiServices.googleTwoFaApi().then((value) {
      _googleTwoFaModel = value!;
      update();

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
      _isLoading.value = false;
    });

    _isLoading.value = false;
    update();
    return _googleTwoFaModel;
  }

//google two fa
  late CommonSuccessModel _updateTwoFAModelData;

  CommonSuccessModel get updateTwoFAModelData => _updateTwoFAModelData;

  Future<CommonSuccessModel> twoFAEnabledProcess() async {
    _isLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'code': controller.pinCodeController.text,
    };

    await ApiServices.twoFaVerifyAPi(body: inputBody).then((value) {
      _updateTwoFAModelData = value!;

      Get.offAllNamed(Routes.twoFaVerificationSuccessScreen);
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
      _isLoading.value = false;
      update();
    });

    return _updateTwoFAModelData;
  }
}
