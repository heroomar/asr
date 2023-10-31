import 'dart:async';

import '../../../../backend/local_storage/local_storage.dart';
import '../../../../backend/model/common/common_success_model.dart';
import '../../../../backend/services/api_services.dart';
import '../../../../utils/basic_screen_imports.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../routes/routes.dart';

class SignUpOtpVerificationController extends GetxController {
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
    signUpResendOtpProcess();
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

  late CommonSuccessModel _commonSuccessModel;

  CommonSuccessModel get commonSuccessModel => _commonSuccessModel;

  // --------------------------- Api function ----------------------------------
  // email verification process function
  Future<CommonSuccessModel> emailVerificationProcess() async {
    _isLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      "token": LocalStorage.getMailToken(),
      'code': pinCodeController.text
    };

    await ApiServices.emailVerificationApi(body: inputBody).then((value) {
      _commonSuccessModel = value!;
      LocalStorage.saveSuccess(
          success: _commonSuccessModel.message!.success!.first.toString());
      goToSignUpCongratulationScreen();
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _commonSuccessModel;
  }

  // --------------------------- Api function start ----------------------------------
  //resend otp process function
  Future<CommonSuccessModel> signUpResendOtpProcess() async {
    update();

    await ApiServices.signUpResendOtpApi(body: {}).then((value) {
      _commonSuccessModel = value!;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    update();
    return _commonSuccessModel;
  }

// --------------------------- Api function end ----------------------------------

  goToSignUpCongratulationScreen() {
    LocalStorage.isLoginSuccess(isLoggedIn: true);
    LocalStorage.isLoggedIn();
    Get.toNamed(Routes.signUpCongratulationScreen);
  }
}
