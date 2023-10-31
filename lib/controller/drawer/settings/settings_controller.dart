import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';

class SettingsController extends GetxController {
  goToKycVerificationScreen() {
    Get.toNamed(Routes.kYCVerificationScreen);
  }

  goToTwoFASecurityScreen() {
    Get.toNamed(Routes.twoFASecurityScreen);
  }

  goToChangePasswordScreen() {
    Get.toNamed(Routes.changePasswordScreen);
  }
}
