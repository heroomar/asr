import 'package:crypinvest/widgets/gradient_container/gradient_container.dart';

import '../../../../custom_assets/assets.gen.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/others/custom_image_widget.dart';

class SignUpCongratulationScreenMobile extends StatelessWidget {
  const SignUpCongratulationScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(Routes.dashboardScreen);
        return false;
      },
      child: GradientContainer(
        child: Scaffold(
          body: _bodyWidget(context),
        ),
      ),
    );
  }

  // body : List of widget
  _bodyWidget(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
            left: Dimensions.paddingSize, right: Dimensions.paddingSize),
        child: Column(
          // crossAxisAlignment: crossCenter,
          mainAxisAlignment: mainCenter,
          children: [
            _congratulationImageWidget(context),
            _signUpCongratulationTitleTextWidget(context),
            _signUpCongratulationSubTitleTextWidget(context),
            _okayButtonWidget(context),
          ],
        ),
      ),
    );
  }

  //okay button takes  to dashboard
  _okayButtonWidget(BuildContext context) {
    return PrimaryButton(
      title: Strings.goToDashboard.tr,
      onPressed: () {
        Get.offAllNamed(Routes.dashboardScreen);
      },
      borderColor: Theme.of(context).primaryColor,
      buttonColor: Theme.of(context).primaryColor,
      // shape: RoundedRectangleBorder(borderRadius: ),
    );
  }

  //congratulation image widget
  _congratulationImageWidget(BuildContext context) {
    return CircleAvatar(
      radius: Dimensions.radius * 8.5,
      backgroundColor: CustomColor.primaryLightColor.withOpacity(.20),
      child: CircleAvatar(
        radius: Dimensions.radius * 6.5,
        backgroundColor: CustomColor.primaryLightColor.withOpacity(.20),
        child: CircleAvatar(
          radius: Dimensions.radius * 5.5,
          backgroundColor: CustomColor.primaryLightColor,
          child: CustomImageWidget(
            height: Dimensions.heightSize * 3,
            width: Dimensions.widthSize * 3,
            scale: 4,
            path: Assets.icon.tickMark,
          ),
        ),
      ),
    );
  }

  //congratulation text widget
  _signUpCongratulationTitleTextWidget(BuildContext context) {
    return TitleHeading2Widget(
      text: Strings.congratulation.tr,
      color: CustomColor.primaryLightColor,
      padding: EdgeInsets.only(top: Dimensions.paddingSize),
    );
  }

  //congratulation subtitle text widget
  _signUpCongratulationSubTitleTextWidget(BuildContext context) {
    return TitleHeading4Widget(
      textAlign: TextAlign.center,
      text: Strings.signUpSuccessText.tr,
      padding: EdgeInsets.only(
        top: Dimensions.paddingSize * 0.33,
        bottom: Dimensions.paddingSize * 0.833,
      ),
      fontWeight: FontWeight.w500,
      fontSize: Dimensions.headingTextSize3,
      color: Get.isDarkMode
          ? CustomColor.greyBlackColor.withOpacity(0.60)
          : CustomColor.greyBlackColor.withOpacity(0.60),
    );
  }
}
