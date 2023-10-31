import 'dart:async';
import 'package:get/get.dart';
import '../../backend/local_storage/local_storage.dart';
import '../../routes/routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _goToScreen();
  }

  _goToScreen() async {
    Timer(const Duration(seconds: 5), () {
      LocalStorage.isLoggedIn()
          ? Get.offAndToNamed(Routes.dashboardScreen)
          : Get.offAndToNamed(
              LocalStorage.isOnBoardDone()
                  ? Routes.signInScreen
                  : Routes.onBoardScreen,
            );
    });
  }
}
