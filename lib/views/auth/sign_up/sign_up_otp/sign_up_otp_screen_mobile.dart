import 'package:crypinvest/backend/backend_utils/custom_loading_api.dart';
import 'package:crypinvest/widgets/gradient_container/gradient_container.dart';

import '../../../../backend/local_storage/local_storage.dart';
import '../../../../custom_assets/assets.gen.dart';
import '../../../../widgets/inputs/sign_up_otp_input_widget.dart';

import '../../../../controller/auth/sign_up/sign_up_controller/sign_up_controller.dart';
import '../../../../controller/auth/sign_up/sign_up_otp_verification_controller/sign_up_otp_verification_controller.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/others/custom_back_button.dart';

class SignUpOtpScreenMobile extends StatelessWidget {
  SignUpOtpScreenMobile({super.key});

  final signUpOtpFormKey = GlobalKey<FormState>();
  final controller = Get.put(SignUpOtpVerificationController());
  final controllerSignUp = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GradientContainer(child: _bodyWidget(context)));
  }

  _bodyWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: Dimensions.marginSizeHorizontal,
          right: Dimensions.marginSizeHorizontal,
          top: Dimensions.marginSizeVertical),
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: Dimensions.marginSizeVertical * 1),
            child: const CustomBackButton(),
          ),
          Image.asset(
            Assets.clipart.otpImg.path,
            width: 180.w,
            height: 180.h,
          ),
          _otpWidget(context),
        ],
      ),
    );
  }

  _otpWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.radius * 4),
          topRight: Radius.circular(Dimensions.radius * 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          _otpVerificationTextWidget(context),
          _otpVerificationEmailTextWidget(context),
          _otpInputWidget(context),
          _timerWidget(context),
          _buttonWidget(context),
        ],
      ),
    );
  }

  _otpVerificationTextWidget(BuildContext context) {
    return Column(
      children: [
        verticalSpace(Dimensions.heightSize),
        TitleHeading2Widget(
          text: Strings.oTPVerification,
          textAlign: TextAlign.center,
          color: CustomColor.primaryDarkColor,
        ),
      ],
    );
  }

  //otp verification subString and user provided email text widget
  _otpVerificationEmailTextWidget(BuildContext context) {
    return TitleHeading4Widget(
      padding: EdgeInsets.only(top: Dimensions.paddingSize * .25),
      text:
          "${Strings.enterVerificationCodeTextOne.tr} ${LocalStorage.getEmail()} ",
      textAlign: TextAlign.start,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode
          ? CustomColor.greyBlackColor
          : CustomColor.greyBlackColor,
    );
  }

  //otp input widget
  _otpInputWidget(BuildContext context) {
    return Column(
      children: [
        verticalSpace(Dimensions.heightSize * 2),
        SignUpOtpInputWidget(
          signUpOtpFormKey: signUpOtpFormKey,
          controller: controller,
        ),
      ],
    );
  }

  _timerWidget(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.access_time_outlined,
                color: CustomColor.primaryLightColor,
              ),
              verticalSpace(Dimensions.widthSize * 4),
              horizontalSpace(Dimensions.widthSize),
              TitleHeading4Widget(
                text:
                    '0${controller.minuteRemaining.value}:${controller.secondsRemaining.value}',
                color: Get.isDarkMode
                    ? CustomColor.whiteColor
                    : CustomColor.primaryLightColor,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          controller.secondsRemaining.value > 0
              ? SizedBox(
                  height: Dimensions.heightSize,
                )
              : _textAndTextButtonWidget(context),
        ],
      ),
    );
  }

  _textAndTextButtonWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Get.isDarkMode
              ? CustomColor.whiteColor
              : CustomColor.primaryLightColor.withOpacity(.20),
          borderRadius: BorderRadius.circular(Dimensions.radius * 2.5)),
      margin: EdgeInsets.only(
          top: Dimensions.marginSizeVertical * 1.5,
          bottom: Dimensions.marginSizeVertical),
      padding: EdgeInsets.symmetric(
          vertical: Dimensions.heightSize,
          horizontal: Dimensions.widthSize * 2),
      child: InkWell(
        onTap: controller.resendCode,
        child: CustomTitleHeadingWidget(
          text: Strings.resend.tr,
          style: Get.isDarkMode
              ? CustomStyle.darkHeading5TextStyle.copyWith(
                  color: CustomColor.whiteColor,
                  fontSize: Dimensions.headingTextSize4)
              : CustomStyle.lightHeading5TextStyle.copyWith(
                  color: CustomColor.whiteColor,
                  fontSize: Dimensions.headingTextSize4),
        ),
      ),
    );
  }

  _buttonWidget(context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.marginSizeVertical,
      ),
      child: Obx(
        () => controller.isLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
                title: Strings.submit.tr,
                onPressed: () {
                  if (signUpOtpFormKey.currentState!.validate()) {
                    controller.emailVerificationProcess();
                  }
                },
                borderColor: Get.isDarkMode
                    ? CustomColor.primaryDarkColor
                    : CustomColor.primaryLightColor,
                buttonColor: Get.isDarkMode
                    ? CustomColor.primaryDarkColor
                    : CustomColor.primaryLightColor,
              ),
      ),
    );
  }
}
