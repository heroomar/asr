import '../../../../backend/local_storage/local_storage.dart';
import '../../../../backend/model/auth/signup_model.dart';
import '../../../../backend/services/api_services.dart';
import '../../../../utils/basic_screen_imports.dart';

import '../../../../routes/routes.dart';

class SignUpController extends GetxController {
  final userNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final signUpEmail = TextEditingController();
  final signUpPasswordController = TextEditingController();
  final referralController = TextEditingController();
  RxBool isSelected = true.obs;

  // api loading process indicator variable
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  late SignUpModel _signUpModel;

  SignUpModel get signUpModel => _signUpModel;

  // --------------------------- Api function ----------------------------------
  // Sign up process function
  Future<SignUpModel> signUpProcess() async {
    _isLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'firstname': firstNameController.text,
      'username': firstNameController.text,
      'lastname': lastNameController.text,
      'email': signUpEmail.text,
      'password': signUpPasswordController.text,
      'referral': referralController.text,
      // 'policy': "on",
    };

    await ApiServices.signUpApi(body: inputBody).then((value) {
      _signUpModel = value!;

      // LocalStorage.saveGuestUser(isGuest: false);
      LocalStorage.saveToken(token: signUpModel.data.token.toString());
      LocalStorage.saveMailToken(
        token: signUpModel.data.authorization.token.toString(),
      );
      LocalStorage.saveEmail(email: signUpEmail.text);
      if (signUpModel.data.authorization.status == true) {
        goToSignUpOtpScreen();
      } else {
        Get.offNamedUntil(Routes.dashboardScreen, (route) => false);
      }

      // Get.toNamed(Routes.signUpOtpScreen);

      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _signUpModel;
  }

  goToSignUpOtpScreen() {
    LocalStorage.saveEmail(email: signUpEmail.text);
    Get.toNamed(Routes.signUpOtpScreen);
  }

  goToSignInScreen() {
    Get.toNamed(Routes.signInScreen);
  }
}
