import 'package:crypinvest/widgets/gradient_container/gradient_container.dart';

import '../../../../controller/drawer/settings/settings_controller.dart';
import '../../../../language/language_drop_down.dart';
import '../../../../utils/basic_widget_imports.dart';
import '../../../../widgets/appbar/custom_app_bar.dart';

class SettingsScreenMobile extends StatelessWidget {
  SettingsScreenMobile({super.key});

  final controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Scaffold(
        appBar: CustomAppBar(
          title: Strings.settings.tr,
          titleClr: CustomColor.primaryDarkColor,
          bgClr: CustomColor.transparentColor,
          elevation: 0.0,
          onTap: () {
            Get.back();
          },
        ),
        body: _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(
          top: Dimensions.paddingSize,
          left: Dimensions.paddingSize,
          right: Dimensions.paddingSize),
      children: [
        _kycVerificationWidget(context),
        _twoFaSecurityWidget(context),
        _changeLanguageWidget(context),
        _changePasswordWidget(context),
        // _deleteAccountWidget(context),
      ],
    );
  }

  _kycVerificationWidget(BuildContext context) {
    return InkWell(
      highlightColor: CustomColor.transparentColor,
      onTap: () {
        controller.goToKycVerificationScreen();
      },
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleHeading4Widget(
              padding:
                  EdgeInsets.symmetric(vertical: Dimensions.paddingSize * .2),
              text: Strings.kycVerification,
              fontWeight: FontWeight.normal,
              fontSize: Dimensions.headingTextSize3,
              color: CustomColor.greyBlackColor,
            ),
            Divider(
              thickness: Dimensions.radius * .1,
              color: CustomColor.whiteColor.withOpacity(.10),
            ),
          ],
        ),
      ),
    );
  }

  _twoFaSecurityWidget(BuildContext context) {
    return InkWell(
      highlightColor: CustomColor.transparentColor,
      onTap: () {
        controller.goToTwoFASecurityScreen();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleHeading4Widget(
            padding:
                EdgeInsets.symmetric(vertical: Dimensions.paddingSize * .2),
            text: Strings.twoFASecurity,
            fontWeight: FontWeight.normal,
            fontSize: Dimensions.headingTextSize3,
            color: CustomColor.greyBlackColor,
          ),
          Divider(
            thickness: Dimensions.radius * .1,
            color: CustomColor.whiteColor.withOpacity(.10),
          ),
        ],
      ),
    );
  }

  _changeLanguageWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: TitleHeading4Widget(
                padding:
                    EdgeInsets.symmetric(vertical: Dimensions.paddingSize * .2),
                text: Strings.changeLanguage,
                fontWeight: FontWeight.normal,
                fontSize: Dimensions.headingTextSize3,
                color: CustomColor.greyBlackColor,
              ),
            ),
            Expanded(child: ChangeLanguageWidget())
          ],
        ),
        Divider(
          thickness: Dimensions.radius * .1,
          color: CustomColor.whiteColor.withOpacity(.10),
        ),
      ],
    );
  }

  _changePasswordWidget(BuildContext context) {
    return InkWell(
      highlightColor: CustomColor.transparentColor,
      onTap: () {
        controller.goToChangePasswordScreen();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleHeading4Widget(
            padding:
                EdgeInsets.symmetric(vertical: Dimensions.paddingSize * .2),
            text: Strings.changePassword,
            fontWeight: FontWeight.normal,
            fontSize: Dimensions.headingTextSize3,
            color: CustomColor.greyBlackColor,
          ),
          Divider(
            thickness: Dimensions.radius * .1,
            color: CustomColor.whiteColor.withOpacity(.10),
          ),
        ],
      ),
    );
  }

  // _deleteAccountWidget(BuildContext context) {
  //   return InkWell(
  //     highlightColor: CustomColor.transparentColor,
  //     onTap: () {},
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         TitleHeading4Widget(
  //           padding:
  //               EdgeInsets.symmetric(vertical: Dimensions.paddingSize * .2),
  //           text: Strings.deleteAccount,
  //           fontWeight: FontWeight.normal,
  //           fontSize: Dimensions.headingTextSize3,
  //           color: CustomColor.redColor,
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
