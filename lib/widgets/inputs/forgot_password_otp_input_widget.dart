import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../controller/auth/sign_in/otp_verification_controller/forgot_password_otp_verification_controller.dart';
import '../../utils/basic_screen_imports.dart';

class ForgotPasswordOtpInputWidget extends StatelessWidget {
  const ForgotPasswordOtpInputWidget({
    super.key,
    required this.forgotPasswordFormKey,
    required this.controller,
  });

  final GlobalKey<FormState> forgotPasswordFormKey;
  final ForgotPasswordOtpVerificationController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: forgotPasswordFormKey,
      child: PinCodeTextField(
        appContext: context,
        backgroundColor: Colors.transparent,
        textStyle: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
        pastedTextStyle: TextStyle(
          color: Colors.orange.shade600,
          fontWeight: FontWeight.bold,
        ),
        length: 6,
        obscureText: false,
        blinkWhenObscuring: true,
        animationType: AnimationType.fade,
        validator: (String? value) {
          if (value!.isEmpty) {
            return Strings.pleaseFillOutTheField;
          } else {
            return null;
          }
        },
        pinTheme: PinTheme(
          errorBorderColor: CustomColor.redColor,
          shape: PinCodeFieldShape.underline,
          fieldHeight: 52.h,
          fieldWidth: 47.w,
          activeFillColor: Colors.transparent,
          inactiveColor: CustomColor.greyBlackColor.withOpacity(.15),
          activeColor: Theme.of(context).primaryColor,
          selectedColor: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius * 0.8),
            topRight: Radius.circular(Dimensions.radius * 0.8),
          ),
        ),
        cursorColor: Get.isDarkMode
            ? CustomColor.primaryLightColor
            : CustomColor.primaryLightColor,
        animationDuration: const Duration(milliseconds: 300),
        errorAnimationController: controller.errorController,
        controller: controller.pinCodeController,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        onCompleted: (v) {},
        onChanged: (value) {
          controller.changeCurrentText(value);
        },
        beforeTextPaste: (text) {
          return true;
        },
      ),
    );
  }
}
