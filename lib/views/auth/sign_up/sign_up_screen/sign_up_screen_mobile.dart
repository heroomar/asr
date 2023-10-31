import 'package:crypinvest/backend/backend_utils/custom_loading_api.dart';
import 'package:crypinvest/language/language_controller.dart';
import 'package:crypinvest/widgets/gradient_container/gradient_container.dart';
import 'package:flutter/gestures.dart';
import '../../../../backend/backend_utils/custom_snackbar.dart';
import '../../../../backend/local_storage/local_storage.dart';
import '../../../../controller/auth/sign_up/sign_up_controller/sign_up_controller.dart';
import '../../../../custom_assets/assets.gen.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/inputs/check_box_widget.dart';
import '../../../../widgets/inputs/password_input_widget.dart';
import '../../../../widgets/others/custom_back_button.dart';

class SignUpScreenMobile extends StatelessWidget {
  SignUpScreenMobile({super.key});

  final controller = Get.put(SignUpController());
  final signUpFormKey = GlobalKey<FormState>();
  final languageController = Get.put(LanguageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColor.transparentColor,
        body: GradientContainer(child: _bodyWidget(context)));
  }

  // here in body widget all the widget are listed
  _bodyWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: Dimensions.marginSizeHorizontal * 0.6,
          right: Dimensions.marginSizeHorizontal * 0.6,
          top: Dimensions.marginSizeVertical * .5),
      child: ListView(
        children: [
          const CustomBackButton(),
          _appLogoWidget(context),
          _signUpTextWidget(context),
          _inputAndButtonWidget(context),
          _alreadyHaveAnAccount(context),
        ],
      ),
    );
  }

  //app logo widget
  _appLogoWidget(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .15,
      margin: EdgeInsets.only(
        left: Dimensions.marginSizeHorizontal * 3,
        right: Dimensions.marginSizeHorizontal * 3,
        top: Dimensions.marginSizeVertical * 1.5,
        bottom: Dimensions.marginSizeVertical * 1.5,
      ),
      child: Image.asset(Assets.onboard.onboardNew.path),
    );
  }

  //Sign Up text Widget
  _signUpTextWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleHeading1Widget(
          text: Strings.signUp.tr,
          color: Get.isDarkMode
              ? CustomColor.primaryDarkColor
              : CustomColor.primaryLightColor,
        ),
        verticalSpace(Dimensions.heightSize * .5),
        TitleHeading4Widget(
          text: Strings.signUpSubtitle.tr,
          color: Get.isDarkMode
              ? CustomColor.greyBlackColor.withOpacity(.6)
              : CustomColor.greyBlackColor.withOpacity(.6),
        ),
        verticalSpace(Dimensions.heightSize * .5),
      ],
    );
  }

  //first name last name  email and password input field  button widgets
  _inputAndButtonWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _signUpInputWidget(context),
        _privacyPolicyWidget(context),
        verticalSpace(Dimensions.heightSize * 1.8),
        _buttonWidget(context),
      ],
    );
  }

  //login input field widget
  _signUpInputWidget(BuildContext context) {
    return Form(
      key: signUpFormKey,
      child: Padding(
        padding: EdgeInsets.only(top: Dimensions.paddingSize),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: PrimaryTextInputWidget(
                    keyboardType: TextInputType.emailAddress,
                    hintText: Strings.firstName.tr,
                    controller: controller.firstNameController,
                    borderColor: Get.isDarkMode
                        ? CustomColor.greyBlackColor.withOpacity(.15)
                        : CustomColor.greyBlackColor.withOpacity(.15),
                    color: Get.isDarkMode
                        ? CustomColor.greyBlackColor.withOpacity(.1)
                        : CustomColor.greyBlackColor.withOpacity(.1),
                    labelText: Strings.firstName,
                  ),
                ),
                horizontalSpace(Dimensions.paddingSize),
                Expanded(
                  flex: 1,
                  child: PrimaryTextInputWidget(
                    keyboardType: TextInputType.emailAddress,
                    hintText: Strings.lastName.tr,
                    controller: controller.lastNameController,
                    borderColor: Get.isDarkMode
                        ? CustomColor.greyBlackColor.withOpacity(.15)
                        : CustomColor.greyBlackColor.withOpacity(.15),
                    color: Get.isDarkMode
                        ? CustomColor.greyBlackColor.withOpacity(.1)
                        : CustomColor.greyBlackColor.withOpacity(.1),
                    labelText: Strings.lastName,
                  ),
                ),
              ],
            ),
            verticalSpace(Dimensions.heightSize),
            //TODO: username field is added
            PrimaryTextInputWidget(
              keyboardType: TextInputType.emailAddress,
              hintText: Strings.username.tr,
              controller: controller.userNameController,
              borderColor: Get.isDarkMode
                  ? CustomColor.greyBlackColor.withOpacity(.15)
                  : CustomColor.greyBlackColor.withOpacity(.15),
              color: Get.isDarkMode
                  ? CustomColor.greyBlackColor.withOpacity(.1)
                  : CustomColor.greyBlackColor.withOpacity(.1),
              labelText: Strings.username,
            ),
            verticalSpace(Dimensions.heightSize),
            PrimaryTextInputWidget(
              keyboardType: TextInputType.emailAddress,
              hintText: Strings.enterEmailAddress.tr,
              controller: controller.signUpEmail,
              borderColor: Get.isDarkMode
                  ? CustomColor.greyBlackColor.withOpacity(.15)
                  : CustomColor.greyBlackColor.withOpacity(.15),
              color: Get.isDarkMode
                  ? CustomColor.greyBlackColor.withOpacity(.1)
                  : CustomColor.greyBlackColor.withOpacity(.1),
              labelText: Strings.emailAddress,
            ),
            verticalSpace(Dimensions.heightSize),
            PasswordInputWidget(
              hintText: Strings.enterPassword.tr,
              controller: controller.signUpPasswordController,
              borderColor: Get.isDarkMode
                  ? CustomColor.greyBlackColor.withOpacity(.15)
                  : CustomColor.greyBlackColor.withOpacity(.15),
              color: Get.isDarkMode
                  ? CustomColor.greyBlackColor
                  : CustomColor.greyBlackColor.withOpacity(.1),
              labelText: Strings.password,
            ),


            //TODO: new referal textfield added
            verticalSpace(Dimensions.heightSize),
            PrimaryTextInputWidget(
              hintText: Strings.referralCode.tr,
              controller: controller.referralController,
              borderColor: Get.isDarkMode
                  ? CustomColor.greyBlackColor.withOpacity(.15)
                  : CustomColor.greyBlackColor.withOpacity(.15),
              color: Get.isDarkMode
                  ? CustomColor.greyBlackColor
                  : CustomColor.greyBlackColor.withOpacity(.1),
              labelText: Strings.referralCode,
            ),
          ],
        ),
      ),
    );
  }

  //sign up button widget
  _buttonWidget(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: Dimensions.marginSizeVertical * .5),
          child: Obx(
            () => controller.isLoading
                ? const CustomLoadingAPI()
                : PrimaryButton(
                    title: Strings.signUp.tr,
                    fontWeight: FontWeight.normal,
                    buttonTextColor: Get.isDarkMode
                        ? CustomColor.primaryBGDarkColor
                        : CustomColor.primaryBGLightColor,
                    fontSize: Dimensions.headingTextSize3 * .88,
                    onPressed: () {
                      if (signUpFormKey.currentState!.validate()) {
                        controller.isSelected.value == false
                            ? controller.signUpProcess()
                            : CustomSnackBar.error(Strings.acceptTerms);
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
        ),
        verticalSpace(Dimensions.heightSize * 1.58),
      ],
    );
  }

//already have an account and sign up button widget
  _alreadyHaveAnAccount(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(
            top: Dimensions.paddingSize * .66, bottom: Dimensions.paddingSize),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: languageController
                    .getTranslation(Strings.alreadyHaveAnAccount),
                style: Get.isDarkMode
                    ? CustomStyle.darkHeading5TextStyle.copyWith(
                        color: CustomColor.greyBlackColor.withOpacity(.30),
                        fontWeight: FontWeight.w600)
                    : CustomStyle.lightHeading5TextStyle.copyWith(
                        color: CustomColor.greyBlackColor.withOpacity(.30),
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
                text: languageController.getTranslation(Strings.signIn),
                style: Get.isDarkMode
                    ? CustomStyle.darkHeading5TextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: CustomColor.primaryDarkColor)
                    : CustomStyle.lightHeading5TextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: CustomColor.primaryLightColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    controller.goToSignInScreen();
                  },
              )
            ],
          ),
        ),
      ),
    );
  }

  _privacyPolicyWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: Dimensions.paddingSize * .5, left: Dimensions.paddingSize * .10),
      child: FittedBox(
        child: Row(
          crossAxisAlignment: crossStart,
          children: [
            CheckBoxWidget(
              color: CustomColor.greyBlackColor,
              isChecked: controller.isSelected,
              onChecked: (value) {
                controller.isSelected.value = value;
              },
              title: Strings.agreedWithTerms,
            ),
          ],
        ),
      ),
    );
  }
}
