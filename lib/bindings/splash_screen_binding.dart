import 'package:get/get.dart';


import '../controller/splash_controller/splash_screen_controller.dart';


class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}