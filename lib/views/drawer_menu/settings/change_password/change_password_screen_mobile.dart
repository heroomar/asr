import 'package:crypinvest/backend/backend_utils/custom_loading_api.dart';
import 'package:crypinvest/widgets/gradient_container/gradient_container.dart';
import '../../../../controller/drawer/settings/change_password_controller.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/appbar/custom_app_bar.dart';
import '../../../../widgets/inputs/password_input_widget.dart';

class ChangePasswordScreenMobile extends StatelessWidget {
  ChangePasswordScreenMobile({super.key});

  final controller = Get.put(ChangePasswordController());

  final changePasswordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Scaffold(
        appBar: CustomAppBar(
          title: Strings.changePassword.tr,
          titleClr: CustomColor.primaryDarkColor,
          bgClr: CustomColor.transparentColor,
          elevation: 0.0,
          onTap: () {
            Get.back();
          },
        ),
        body: Obx(
          () => controller.isUpdateLoading
              ? const CustomLoadingAPI()
              : _bodyWidget(context),
        ),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize),
      children: [
        _passwordInputWidget(context),
        _buttonWidget(context),
      ],
    );
  }

  _passwordInputWidget(BuildContext context) {
    return Form(
      key: changePasswordFormKey,
      child: Padding(
        padding: EdgeInsets.only(top: Dimensions.paddingSize),
        child: Column(
          children: [
            PasswordInputWidget(
              hintText: Strings.enterPassword.tr,
              controller: controller.oldPasswordController,
              borderColor: Get.isDarkMode
                  ? CustomColor.greyBlackColor.withOpacity(.15)
                  : CustomColor.greyBlackColor.withOpacity(.15),
              color: Get.isDarkMode
                  ? CustomColor.primaryBGDarkColor
                  : CustomColor.primaryBGLightColor,
              labelText: Strings.oldPassword,
            ),
            verticalSpace(Dimensions.heightSize),
            PasswordInputWidget(
              hintText: Strings.enterPassword.tr,
              controller: controller.newPasswordController,
              borderColor: Get.isDarkMode
                  ? CustomColor.greyBlackColor.withOpacity(.15)
                  : CustomColor.greyBlackColor.withOpacity(.15),
              color: Get.isDarkMode
                  ? CustomColor.primaryBGDarkColor
                  : CustomColor.primaryBGLightColor,
              labelText: Strings.newPassword,
            ),
            verticalSpace(Dimensions.heightSize),
            PasswordInputWidget(
              hintText: Strings.enterPassword.tr,
              controller: controller.confirmNewPasswordController,
              borderColor: Get.isDarkMode
                  ? CustomColor.greyBlackColor.withOpacity(.15)
                  : CustomColor.greyBlackColor.withOpacity(.15),
              color: Get.isDarkMode
                  ? CustomColor.primaryBGDarkColor
                  : CustomColor.primaryBGLightColor,
              labelText: Strings.confirmPassword,
            ),
          ],
        ),
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: Dimensions.marginSizeVertical * 1.5),
          child: PrimaryButton(
            title: Strings.changePassword.tr,
            fontWeight: FontWeight.normal,
            buttonTextColor: Get.isDarkMode
                ? CustomColor.primaryBGDarkColor
                : CustomColor.primaryBGLightColor,
            fontSize: Dimensions.headingTextSize3 * .88,
            onPressed: () {
              if (changePasswordFormKey.currentState!.validate()) {
                controller.changePasswordProcess();
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
      ],
    );
  }
}
