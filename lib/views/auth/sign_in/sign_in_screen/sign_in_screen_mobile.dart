import 'dart:ui';
import 'package:crypinvest/backend/backend_utils/custom_loading_api.dart';
import 'package:crypinvest/custom_assets/assets.gen.dart';
import 'package:crypinvest/language/language_controller.dart';
import 'package:crypinvest/widgets/gradient_container/gradient_container.dart';
import '../../../../backend/local_storage/local_storage.dart';
import '../../../../controller/auth/sign_in/otp_verification_controller/forgot_password_controller.dart';
import '../../../../controller/auth/sign_in/sign_in_controller/sign_in_controller.dart';
import '../../../../routes/routes.dart';
import '../../../../widgets/others/custom_back_button.dart';
import 'package:flutter/gestures.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/inputs/password_input_widget.dart';
import '../../../../widgets/text_labels/title_heading5_widget.dart';

class SignInScreenMobile extends StatelessWidget {
  SignInScreenMobile({super.key});

  final controller = Get.put(SignInController());
  final signInformKey = GlobalKey<FormState>();
  final forgotPasswordFormKecy = GlobalKey<FormState>();
  final languageController = Get.put(LanguageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.transparentColor,
      body: GradientContainer(child: _bodyWidget(context)),
    );
  }

  // here in body widget all the widget are listed
  _bodyWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: Dimensions.marginSizeHorizontal,
          right: Dimensions.marginSizeHorizontal,
          top: Dimensions.marginSizeVertical),
      child: ListView(
        children: [
          const CustomBackButton(),
          _appLogoWidget(context),
          _welcomeTextWidget(context),
          _inputAndButtonWidget(context),
          _doNotHaveAnAccount(context),
        ],
      ),
    );
  }

  //app logo widget
  _appLogoWidget(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .17,
      margin: EdgeInsets.only(
        left: Dimensions.marginSizeHorizontal * 3,
        right: Dimensions.marginSizeHorizontal * 3,
        top: Dimensions.marginSizeVertical * 0.7,
        bottom: Dimensions.marginSizeVertical * 0.7,
      ),
      child: Image.asset(Assets.onboard.onboardNew.path),
    );
  }

  //welcome text Widget
  _welcomeTextWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleHeading1Widget(
          text: Strings.signIn.tr,
          color: Get.isDarkMode
              ? CustomColor.primaryDarkColor
              : CustomColor.primaryLightColor,
        ),
        verticalSpace(Dimensions.heightSize * .5),
        TitleHeading4Widget(
          text: Strings.signInSubtitle.tr,
          color: Get.isDarkMode
              ? CustomColor.greyBlackColor.withOpacity(.6)
              : CustomColor.greyBlackColor.withOpacity(.6),
          fontSize: Dimensions.headingTextSize4,
          // textAlign: TextAlign.justify,
        ),
        verticalSpace(Dimensions.heightSize * .5),
      ],
    );
  }

  //email and password input field  button widgets
  _inputAndButtonWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _loginWidget(context),
        _forgotPasswordWidget(context, controller),
        verticalSpace(Dimensions.heightSize * 1.8),
        _buttonWidget(context, controller),
      ],
    );
  }

  //login input field widget
  _loginWidget(BuildContext context) {
    return Form(
      key: signInformKey,
      child: Padding(
        padding: EdgeInsets.only(top: Dimensions.paddingSize),
        child: Column(
          children: [
            PrimaryTextInputWidget(
              keyboardType: TextInputType.emailAddress,
              hintText: "Enter Email Address/username",
              controller: controller.emailController,
              borderColor: Get.isDarkMode
                  ? CustomColor.greyBlackColor
                  : CustomColor.greyBlackColor,
              color: Get.isDarkMode
                  ? CustomColor.greyBlackColor.withOpacity(.1)
                  : CustomColor.greyBlackColor.withOpacity(.1),
              labelText: "Email Address/username",
            ),
            verticalSpace(Dimensions.heightSize),
            PasswordInputWidget(
              hintText: Strings.enterPassword.tr,
              controller: controller.passwordController,
              borderColor: Get.isDarkMode
                  ? CustomColor.greyBlackColor
                  : CustomColor.greyBlackColor,
              color: Get.isDarkMode
                  ? CustomColor.greyBlackColor
                  : CustomColor.greyBlackColor,
              labelText: Strings.password,
            ),
          ],
        ),
      ),
    );
  }

  //forgot password button widget
  _forgotPasswordWidget(BuildContext context, SignInController controller) {
    return InkWell(
      onTap: () => _showForgotPasswordDialog(context),
      child: Padding(
        padding: EdgeInsets.only(
            top: Dimensions.paddingSize * .20,
            bottom: Dimensions.paddingSize * .5),
        child: Row(
          mainAxisAlignment: mainEnd,
          children: [
            CustomTitleHeadingWidget(
              text: Strings.forgotPassword.tr,
              style: Get.isDarkMode
                  ? CustomStyle.darkHeading5TextStyle.copyWith(
                      color: CustomColor.primaryDarkColor,
                      fontSize: Dimensions.headingTextSize6,
                      fontWeight: FontWeight.w600)
                  : CustomStyle.lightHeading5TextStyle.copyWith(
                      color: CustomColor.primaryLightColor,
                      fontSize: Dimensions.headingTextSize6,
                      fontWeight: FontWeight.w600,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  //sign in button widget
  _buttonWidget(BuildContext context, SignInController controller) {
    return Column(
      children: [
        Obx(() => controller.isLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
                title: Strings.signIn.tr,
                fontWeight: FontWeight.normal,
                buttonTextColor: Get.isDarkMode
                    ? CustomColor.primaryBGDarkColor
                    : CustomColor.primaryBGLightColor,
                fontSize: Dimensions.headingTextSize3 * .88,
                onPressed: () {
                  //TODO Uncomment this code when finalize project
                  if (signInformKey.currentState!.validate()) {
                    controller.signInProcess();
                  }
                  // Get.toNamed(Routes.dashboardScreen);
                },
                borderColor: Get.isDarkMode
                    ? CustomColor.primaryDarkColor
                    : CustomColor.primaryLightColor,
                buttonColor: Get.isDarkMode
                    ? CustomColor.primaryDarkColor
                    : CustomColor.primaryLightColor,
              )),
        verticalSpace(Dimensions.heightSize * 1.58),
      ],
    );
  }

//don't have an account and sign up button widget
  _doNotHaveAnAccount(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(
            top: Dimensions.paddingSize * .66, bottom: Dimensions.paddingSize),
        child: RichText(
          text: TextSpan(
            children: [
              // Get language using key
              TextSpan(
                text: languageController
                    .getTranslation(Strings.doNotHaveAnAccount),
                style: Get.isDarkMode
                    ? CustomStyle.darkHeading5TextStyle.copyWith(
                        color: CustomColor.greyBlackColor.withOpacity(.60),
                        fontWeight: FontWeight.w600)
                    : CustomStyle.lightHeading5TextStyle.copyWith(
                        color: CustomColor.greyBlackColor.withOpacity(.60),
                        fontWeight: FontWeight.w600),
              ),
              WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSize * 0.15,
                  ),
                ),
              ),
              TextSpan(
                text: languageController.getTranslation(Strings.signUp),
                style: Get.isDarkMode
                    ? CustomStyle.darkHeading5TextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: CustomColor.primaryDarkColor)
                    : CustomStyle.lightHeading5TextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: CustomColor.primaryLightColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    controller.goToSignUpScreen();
                  },
              )
            ],
          ),
        ),
      ),
    );
  }

  _showForgotPasswordDialog(BuildContext context) {
    final forgotPasswordFormKey = GlobalKey<FormState>();
    final forgotPasswordController = Get.put(ForgotPasswordController());
    Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Dialog(
          surfaceTintColor: CustomColor.forgotColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius),
          ),
          child: GradientContainer(
            child: Padding(
              padding: EdgeInsets.all(Dimensions.paddingSize * 0.75),
              child: Form(
                key: forgotPasswordFormKey,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(
                      mainAxisSize: mainMin,
                      crossAxisAlignment: crossStart,
                      children: [
                        TitleHeading4Widget(
                          padding: EdgeInsets.only(
                              bottom: Dimensions.marginSizeVertical * .5),
                          text: Strings.forgotPassword.tr,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.bold,
                          color: CustomColor.primaryDarkColor,
                        ),
                        TitleHeading5Widget(
                          padding: EdgeInsets.only(
                              bottom: Dimensions.marginSizeVertical),
                          text: Strings.enterYourEmailToResetPassword.tr,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.normal,
                          color: CustomColor.greyBlackColor.withOpacity(.60),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: Dimensions.marginBetweenInputBox),
                          child: PrimaryTextInputWidget(
                            keyboardType: TextInputType.emailAddress,
                            hintText: Strings.enterEmailAddress.tr,
                            controller:
                                forgotPasswordController.forgotEmailController,
                            borderColor: Get.isDarkMode
                                ? CustomColor.greyBlackColor.withOpacity(.15)
                                : CustomColor.greyBlackColor.withOpacity(.15),
                            color: Get.isDarkMode
                                ? CustomColor.greyBlackColor.withOpacity(.1)
                                : CustomColor.greyBlackColor.withOpacity(.1),
                            labelText: Strings.emailAddress,
                          ),
                        ),
                        Obx(() => forgotPasswordController.isLoading
                            ? const CustomLoadingAPI()
                            : PrimaryButton(
                                title: Strings.forgotPasswordSecondary.tr,
                                onPressed: () {
                                  if (forgotPasswordFormKey.currentState!
                                      .validate()) {
                                    forgotPasswordController
                                        .forgotPasswordProcess();
                                  }
                                },
                                borderColor: Get.isDarkMode
                                    ? CustomColor.primaryDarkColor
                                    : CustomColor.primaryLightColor,
                                buttonColor: Get.isDarkMode
                                    ? CustomColor.primaryDarkColor
                                    : CustomColor.primaryLightColor,
                              )),
                        verticalSpace(Dimensions.heightSize),
                      ],
                    ),
                    Positioned(
                      right: -32,
                      top: -32,
                      child: InkWell(
                        onTap: () => Get.back(),
                        child: CircleAvatar(
                          radius: Dimensions.radius * 1.4,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: const Icon(
                            Icons.close_rounded,
                            color: CustomColor.whiteColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
