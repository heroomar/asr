import '../../../../utils/basic_screen_imports.dart';
import '../../routes/routes.dart';

class WelcomeScreenController extends GetxController {
  goToSignInScreen() {
    Get.toNamed(Routes.signInScreen);
  }

  void goToSignUpScreen() {
    Get.toNamed(Routes.signUpScreen);
  }
}
