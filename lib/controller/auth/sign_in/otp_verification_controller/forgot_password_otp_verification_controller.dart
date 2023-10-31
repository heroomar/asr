import 'dart:async';
import '../../../../backend/local_storage/local_storage.dart';
import '../../../../backend/model/auth/forgot_password_common_model.dart';
import '../../../../backend/services/api_services.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/basic_screen_imports.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'forgot_password_controller.dart';

class ForgotPasswordOtpVerificationController extends GetxController {
  final forgotPasswordController = Get.put(ForgotPasswordController());
  final otpInputFieldController = TextEditingController();
  final pinCodeController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  var currentText = ''.obs;
  StreamSubscription? streamSubscription;

  changeCurrentText(value) {
    currentText.value = value;
  }

  @override
  void dispose() {
    pinCodeController.clear();
    errorController!.close(); // close the errorController stream
    streamSubscription?.cancel(); // cancel the stream subscription
    super.dispose();
  }

  @override
  void onInit() {
    errorController = StreamController<
        ErrorAnimationType>.broadcast(); // create a broadcast stream
    timerInit();
    super.onInit();
  }

  timerInit() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (minuteRemaining.value != 0) {
        secondsRemaining.value--;
        if (secondsRemaining.value == 0) {
          secondsRemaining.value = 59;
          minuteRemaining.value = 0;
        }
      } else if (minuteRemaining.value == 0 && secondsRemaining.value != 0) {
        secondsRemaining.value--;
      } else {
        enableResend.value = true;
      }
    });
  }

  RxInt secondsRemaining = 59.obs;
  RxInt minuteRemaining = 00.obs;
  RxBool enableResend = false.obs;
  Timer? timer;

  resendCode() {
    forgotPasswordController.forgotPasswordResendProcess();
    timer?.cancel();
    secondsRemaining.value = 59;
    enableResend.value = false;
    timerInit();
  }

  void listenToStream() {
    // cancel any existing subscription
    streamSubscription?.cancel();

    // listen to the stream
    streamSubscription = errorController!.stream.listen((errorAnimationType) {
      // do something with the error
    });
  }

  // api loading process indicator variable
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  late ForgotPasswordCommonModel _forgotPasswordCommonModel;

  ForgotPasswordCommonModel get forgotPasswordCommonModel =>
      _forgotPasswordCommonModel;

  // --------------------------- Api function ----------------------------------
  // forgot password verify otp process function
  Future<ForgotPasswordCommonModel> forgotPasswordVerifyOtpProcess() async {
    _isLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'token': LocalStorage.getToken(),
      'code': pinCodeController.text
    };

    await ApiServices.forgotPasswordVerifyOtpApi(body: inputBody).then((value) {
      _forgotPasswordCommonModel = value!;
      LocalStorage.saveToken(
          token: _forgotPasswordCommonModel.data!.token.toString());
      goToResetPasswordScreen();
      update();
      _isLoading.value = false;
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _forgotPasswordCommonModel;
  }

  goToResetPasswordScreen() {
    Get.toNamed(Routes.resetPasswordScreen);
  }
}
