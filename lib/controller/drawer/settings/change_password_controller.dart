import '../../../../utils/basic_screen_imports.dart';
import '../../../backend/model/common/common_success_model.dart';
import '../../../backend/services/api_services.dart';

class ChangePasswordController extends GetxController {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();
  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  final _isUpdateLoading = false.obs;
  bool get isUpdateLoading => _isUpdateLoading.value;

  late CommonSuccessModel _updatePasswordModel;

  CommonSuccessModel get depositMethodsModel => _updatePasswordModel;

  Future<CommonSuccessModel> changePasswordProcess() async {
    _isUpdateLoading.value = true;
    Map<String, String> inputBody = {
      'current_password': oldPasswordController.text,
      'password': newPasswordController.text,
      'password_confirmation': confirmNewPasswordController.text,
    };
    await ApiServices.changePasswordApi(body: inputBody).then((value) {
      _updatePasswordModel = value!;
      _isUpdateLoading.value = false;
        oldPasswordController.clear();
      newPasswordController.clear();
      confirmNewPasswordController.clear();
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isUpdateLoading.value = false;
    update();
    return _updatePasswordModel;
  }
}
