import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../backend/local_storage/local_storage.dart';
import '../../../../backend/model/auth/forgot_password_common_model.dart';
import '../../../../backend/services/api_services.dart';
import '../../../../routes/routes.dart';

class ForgotPasswordController extends GetxController {
  final forgotEmailController = TextEditingController();

  // api loading process indicator variable
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  //model defined
  late ForgotPasswordCommonModel _forgotPasswordCommonModel;

  ForgotPasswordCommonModel get forgotPasswordCommonModel =>
      _forgotPasswordCommonModel;

  // --------------------------- Api function start ----------------------------------
  // forgot password email process function
  Future<ForgotPasswordCommonModel> forgotPasswordProcess() async {
    _isLoading.value = true;

    update();

    Map<String, dynamic> inputBody = {
      'credentials': forgotEmailController.text,
    };

    await ApiServices.forgotPasswordEmailApi(body: inputBody).then((value) {
      _forgotPasswordCommonModel = value!;
      LocalStorage.saveToken(
          token: _forgotPasswordCommonModel.data!.token.toString());
      LocalStorage.saveEmail(email: forgotEmailController.text);
     
      goToForgotPasswordOTPVerificationScreen();
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _forgotPasswordCommonModel;
  }

  // --------------------------- Api function end ----------------------------------

  // --------------------------- Api function start ----------------------------------
  // forgot password email process function
  Future<ForgotPasswordCommonModel> forgotPasswordResendProcess() async {
    _isLoading.value = true;

    update();

    Map<String, dynamic> inputBody = {};

    await ApiServices.forgotPasswordResendOtpApi(body: inputBody).then((value) {
      _forgotPasswordCommonModel = value!;
      LocalStorage.saveForgotPasswordToken(
          isForgotPasswordToken:
              _forgotPasswordCommonModel.data!.token.toString());
      LocalStorage.saveToken(
          token: _forgotPasswordCommonModel.data!.token.toString());
      goToForgotPasswordOTPVerificationScreen();
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _forgotPasswordCommonModel;
  }

  // --------------------------- Api function end ----------------------------------
  goToForgotPasswordOTPVerificationScreen() {
    Get.toNamed(Routes.forgotPasswordOtpVerificationScreen);
  }
}
