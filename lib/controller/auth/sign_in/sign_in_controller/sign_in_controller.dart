import '../../../../backend/local_storage/local_storage.dart';
import '../../../../backend/model/auth/signin_model.dart';
import '../../../../backend/services/api_services.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/basic_screen_imports.dart';

class SignInController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isFromLogin = false;
  RxBool isSelected = false.obs;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // api loading process indicator variable
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  //model defined
  late SignInModel _signInModel;

  SignInModel get signInModel => _signInModel;

  /*--------------------------- Api function start ----------------------------------*/
  // Sign in process function
  Future<SignInModel> signInProcess() async {
    _isLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'credentials': emailController.text,
      'password': passwordController.text,
    };

    await ApiServices.signInApi(body: inputBody).then((value) {
      _signInModel = value!;

      if (_signInModel.data.userInfo.emailVerified == false) {
        isFromLogin = true;
        _goToEmailVerification();
      } else {
        debugPrint("SMS Verified => Login Process");

        bool twoFaStatus = _signInModel.data.userInfo.twoFactorStatus;
        bool twoFaVerified = _signInModel.data.userInfo.twoFactorVerified;

        /// this is for 2fa check
        if (twoFaStatus == true && twoFaVerified == false) {
          _goToTwoFa(_signInModel);
        } else {
          _goToSavedUser(_signInModel);
        }

        _isLoading.value = false;
        update();
      }

      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _signInModel;
  }

  /*--------------------------- Api function end ----------------------------------*/

  _goToEmailVerification() {
    LocalStorage.saveToken(token: signInModel.data.token);
    LocalStorage.saveMailToken(token: signInModel.data.authorization.token);
     LocalStorage.saveEmail(email: emailController.text);
    Get.toNamed(Routes.signUpOtpScreen);
  }

  _goToSavedUser(SignInModel loginModel) {
    LocalStorage.saveToken(token: loginModel.data.token);
    LocalStorage.isLoginSuccess(isLoggedIn: true);
    LocalStorage.isLoggedIn();
    LocalStorage.saveEmail(email: emailController.text);
    goToDashboardScreen();
  }

  void _goToTwoFa(SignInModel loginModel) {
    LocalStorage.saveToken(token: loginModel.data.token);

    LocalStorage.saveEmail(email: emailController.text);
    Get.toNamed(Routes.twoFAOtpScreen);
  }

  goToResetPasswordScreen() {
    Get.toNamed(Routes.resetPasswordScreen);
  }

  goToSignUpScreen() {
    Get.toNamed(Routes.signUpScreen);
  }

  goToDashboardScreen() {
    Get.offAllNamed(Routes.dashboardScreen);
  }
}
