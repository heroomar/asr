import 'package:crypinvest/backend/backend_utils/custom_loading_api.dart';

import '../../../../widgets/inputs/two_f_a_otp_input.dart';
import '../../../../controller/drawer/settings/two_f_a_otp_controller.dart';
import '../../../../controller/drawer/two_f_a_security_controller.dart';
import '../../../../utils/basic_widget_imports.dart';
import '../../../../widgets/appbar/custom_app_bar.dart';
import '../../../../widgets/buttons/primary_button.dart';

class TwoFAOtpVerificationScreenMobile extends StatelessWidget {
  TwoFAOtpVerificationScreenMobile({super.key});

  final controllerTwoFA = Get.put(TwoFASecurityController());
  final controller = Get.put(TwoFAOtpVerificationController());
  final twoFAOtpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
        onTap: () {
          Get.back();
        },
      ),
      backgroundColor: CustomColor.primaryLightScaffoldBackgroundColor,
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: Dimensions.marginSizeHorizontal,
          right: Dimensions.marginSizeHorizontal,
          top: Dimensions.marginSizeVertical * 5),
      child: ListView(
        children: [
          _twoFAOtpVerificationTextWidget(context),
          _twoFAOtpVerificationEmailTextWidget(context),
          _twoFAOtpInputWidget(context),
          _buttonWidget(context),
        ],
      ),
    );
  }

  _twoFAOtpVerificationTextWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        verticalSpace(Dimensions.heightSize),
        TitleHeading2Widget(
          text: Strings.twoFaVerification,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  _twoFAOtpVerificationEmailTextWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        TitleHeading4Widget(
          padding: EdgeInsets.only(
            top: Dimensions.paddingSize * .25,
          ),
          text: Strings.googleCodeHere,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode
              ? CustomColor.primaryDarkTextColor
              : CustomColor.primaryLightTextColor.withOpacity(0.4),
        ),
      ],
    );
  }

  _twoFAOtpInputWidget(BuildContext context) {
    return Column(
      children: [
        verticalSpace(Dimensions.heightSize * 2),
        TwoFAOtpInput(
          controller: controller,
          twoFAOtpFormKey: twoFAOtpFormKey,
        ),
      ],
    );
  }

  _buttonWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.marginSizeVertical,
      ),
      child: Obx(
        () => controllerTwoFA.isLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
                title: Strings.submit.tr,
                onPressed: () {
                  if (twoFAOtpFormKey.currentState!.validate()) {
                    controllerTwoFA.twoFAEnabledProcess();
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
