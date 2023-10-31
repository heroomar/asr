import 'package:crypinvest/widgets/gradient_container/gradient_container.dart';

import '../../../../controller/welcome_screen_controller/welcome_screen_controller.dart';
import '../../backend/local_storage/local_storage.dart';
import '../../custom_assets/assets.gen.dart';
import '../../language/language_drop_down.dart';
import '../../utils/basic_screen_imports.dart';

class WelcomeScreenMobile extends StatelessWidget {
  WelcomeScreenMobile({super.key});

  final controller = Get.put(WelcomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientContainer(child: _bodyWidget(context)),
    );
  }

  _bodyWidget(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding:
              EdgeInsets.symmetric(horizontal: Dimensions.paddingSize * 0.6),
          children: [
            _appLogoWidget(context),
            _welcomeTextWidget(context),
            _welcomeSubtitleTextWidget(context),
            _signInButtonWidget(context),
            _signUpButtonWidget(context),
          ],
        ),
        Positioned(
          top: Dimensions.heightSize * 4,
          right: Dimensions.widthSize * 1,
          child: ChangeLanguageWidget(isOnboard: true),
        ),
      ],
    );
  }

//app logo widget
  _appLogoWidget(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .2,
      margin: EdgeInsets.only(
        top: Dimensions.marginSizeVertical * 6,
        left: Dimensions.marginSizeHorizontal * 2,
        right: Dimensions.marginSizeHorizontal * 2,
      ),
      child: Image.asset(Assets.onboard.onboardNew.path),
    );
  }

  _welcomeTextWidget(BuildContext context) {
    return Center(
      child: TitleHeading2Widget(
        textAlign: TextAlign.center,
        color: CustomColor.primaryLightColor,
        padding: EdgeInsets.only(
          top: Dimensions.marginSizeVertical * 1.5,
          bottom: Dimensions.marginSizeVertical * .2,
        ),
        text: "Wellcome to ASR",
        fontSize: Dimensions.headingTextSize1,
      ),
    );
  }

  _welcomeSubtitleTextWidget(BuildContext context) {
    return CustomTitleHeadingWidget(
      padding: EdgeInsets.only(
          bottom: Dimensions.marginSizeVertical * 1.5,
          left: Dimensions.marginSizeHorizontal * 0.5,
          right: Dimensions.marginSizeHorizontal * 0.5),
      text: "By Staking money you can easily earn throught this system",
      textAlign: TextAlign.center,
      style: Get.isDarkMode
          ? CustomStyle.darkHeading3TextStyle.copyWith(
              color: CustomColor.greyBlackColor.withOpacity(.60),
              fontWeight: FontWeight.w500)
          : CustomStyle.lightHeading3TextStyle.copyWith(
              color: CustomColor.greyBlackColor.withOpacity(.60),
              fontWeight: FontWeight.w500),
    );
  }

  _signInButtonWidget(BuildContext context) {
    return PrimaryButton(
      title: Strings.signIn.tr,
      onPressed: () => controller.goToSignInScreen(),
      borderColor: Get.isDarkMode
          ? CustomColor.primaryDarkColor
          : CustomColor.primaryLightColor,
      buttonColor: Get.isDarkMode
          ? CustomColor.primaryDarkColor
          : CustomColor.primaryLightColor,
      buttonTextColor: Get.isDarkMode
          ? CustomColor.primaryBGDarkColor
          : CustomColor.primaryBGLightColor,
    );
  }

  _signUpButtonWidget(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: Dimensions.marginSizeVertical * .75),
      child: PrimaryButton(
        title: Strings.signUp.tr,
        onPressed: () => controller.goToSignUpScreen(),
        borderColor: Get.isDarkMode
            ? CustomColor.blackColor
            : CustomColor.primaryLightColor,
        buttonColor: CustomColor.transparentColor,
        buttonTextColor: Get.isDarkMode
            ? CustomColor.blackColor
            : CustomColor.primaryLightColor,
      ),
    );
  }
}
