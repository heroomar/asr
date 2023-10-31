import 'package:crypinvest/backend/backend_utils/custom_loading_api.dart';
import 'package:crypinvest/widgets/appbar/custom_app_bar.dart';
import 'package:crypinvest/widgets/gradient_container/gradient_container.dart';

import '../../../../controller/auth/sign_in/reset_password_controller/reset_password_controller.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/inputs/password_input_widget.dart';

class ResetPasswordScreenMobile extends StatelessWidget {
  ResetPasswordScreenMobile({Key? key}) : super(key: key);

  final controller = Get.put(ResetPasswordController());
  final resetNewPasswordFormKey = GlobalKey<FormState>();
  final resetConfirmPasswordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(Routes.signInScreen);
        return false;
      },
      child: GradientContainer(
        child: Scaffold(
          backgroundColor: CustomColor.transparentColor,
          appBar: CustomAppBar(
            centerTitle: true,
            alwaysShowBackButton: false,
            titleClr: CustomColor.primaryDarkColor,
            bgClr: CustomColor.transparentColor,
            onTap: () {},
            title: Strings.resetPassword.tr,
          ),
          body: _bodyWidget(context),
        ),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _inputFieldWidget(context),
        ],
      ),
    );
  }

  _inputFieldWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.paddingSize,
        right: Dimensions.paddingSize,
        top: Dimensions.paddingSize * 1.33,
      ),
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          _newPasswordInputWidget(context),
          _resetPasswordButtonWidget(context),
        ],
      ),
    );
  }

//new password input widget
  _newPasswordInputWidget(BuildContext context) {
    return Form(
      key: resetNewPasswordFormKey,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Dimensions.marginBetweenInputBox * .25),
        child: Column(
          children: [
            PasswordInputWidget(
              controller: controller.newPassword,
              hintText: Strings.enterNewPassword.tr,
              labelText: Strings.newPassword.tr,
              borderColor: Get.isDarkMode
                  ? CustomColor.greyBlackColor.withOpacity(.15)
                  : CustomColor.greyBlackColor.withOpacity(.15),
              color: Get.isDarkMode
                  ? CustomColor.primaryBGDarkColor
                  : CustomColor.primaryBGLightColor,
            ),
            verticalSpace(Dimensions.heightSize),
            PasswordInputWidget(
              controller: controller.confirmPassword,
              hintText: Strings.enterConfirmPassword.tr,
              labelText: Strings.confirmPassword.tr,
              borderColor: Get.isDarkMode
                  ? CustomColor.greyBlackColor.withOpacity(.15)
                  : CustomColor.greyBlackColor.withOpacity(.15),
              color: Get.isDarkMode
                  ? CustomColor.primaryBGDarkColor
                  : CustomColor.primaryBGLightColor,
            ),
          ],
        ),
      ),
    );
  }

//reset password button
  _resetPasswordButtonWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.paddingSize),
      child: Obx(() => controller.isLoading
          ? const CustomLoadingAPI()
          : PrimaryButton(
              title: Strings.resetPassword.tr,
              onPressed: () {
                if (resetNewPasswordFormKey.currentState!.validate()) {
                  controller.resetPasswordPrecess();
                }
              },
              borderColor: Theme.of(context).primaryColor,
              buttonColor: Theme.of(context).primaryColor,
            )),
    );
  }
}
