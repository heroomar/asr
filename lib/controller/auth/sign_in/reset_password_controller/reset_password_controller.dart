import '../../../../backend/local_storage/local_storage.dart';
import '../../../../backend/model/common/common_success_model.dart';
import '../../../../backend/services/api_services.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../views/congratulation/congratulation_screen.dart';

class ResetPasswordController extends GetxController {
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();

  @override
  void dispose() {
    confirmPassword.dispose();
    newPassword.dispose();
    super.dispose();
  }

  // api loading process indicator variable
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  late CommonSuccessModel _commonSuccessModel;

  CommonSuccessModel get commonSuccessModel => _commonSuccessModel;

  // --------------------------- Api function ----------------------------------
  // reset password process function
  Future<CommonSuccessModel> resetPasswordPrecess() async {
    _isLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'password': newPassword.text,
      'password_confirmation': confirmPassword.text,
      'token': LocalStorage.getToken()
    };

    await ApiServices.resetPasswordApi(body: inputBody).then((value) {
      _commonSuccessModel = value!;
      LocalStorage.saveSuccess(
          success: _commonSuccessModel.message!.success!.first.toString());
      LocalStorage.removeToken();

      goToCongratulationScreen();
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _commonSuccessModel;
  }

  goToCongratulationScreen() {
    Get.to(
      () => const CongratulationScreen(
        route: Routes.signInScreen,
        subTitle: Strings.resetPasswordSuccessText,
      ),
    );
  }
}
