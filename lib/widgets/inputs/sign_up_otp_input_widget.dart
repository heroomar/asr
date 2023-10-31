import '../../../../controller/auth/sign_up/sign_up_otp_verification_controller/sign_up_otp_verification_controller.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../utils/basic_screen_imports.dart';

class SignUpOtpInputWidget extends StatelessWidget {
  const SignUpOtpInputWidget({
    super.key,
    required this.signUpOtpFormKey,
    required this.controller,
  });

  final GlobalKey<FormState> signUpOtpFormKey;
  final SignUpOtpVerificationController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.89,
      color: Colors.transparent,
      child: Form(
        key: signUpOtpFormKey,
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
            borderWidth: Dimensions.widthSize * 0.2,
            shape: PinCodeFieldShape.underline,
            fieldHeight: 52,
            fieldWidth: 47,
            activeFillColor: Colors.transparent,
            inactiveColor: CustomColor.greyBlackColor.withOpacity(0.15),
            activeColor: CustomColor.primaryLightColor,
            selectedColor: CustomColor.primaryLightColor,
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
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onCompleted: (v) {},
          onChanged: (value) {
            controller.changeCurrentText(value);
          },
          beforeTextPaste: (text) {
            return true;
          },
        ),
      ),
    );
  }
}
