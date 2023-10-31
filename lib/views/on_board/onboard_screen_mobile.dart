import 'dart:collection';

import 'package:crypinvest/widgets/gradient_container/gradient_container.dart';

import '../../backend/local_storage/local_storage.dart';
import '../../controller/app_settings/app_setting_controller.dart';
import '../../controller/onboard_controller/on_board_controller.dart';
import '../../custom_assets/assets.gen.dart';
import '../../utils/basic_screen_imports.dart';

class OnBoardScreenMobile extends StatelessWidget {
  OnBoardScreenMobile({Key? key}) : super(key: key);

  final controller = Get.put(OnBoardController());
  final appController = Get.put(AppSettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GradientContainer(child: _bodyWidget(context)));
  }

  // all elements contained in body widget
  _bodyWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: mainEnd,
      children: [
        verticalSpace(Dimensions.heightSize * 6),
        Image.asset(Assets.onboard.welcome.path, height: 260.h, width: 257.w),
        const Spacer(),
        TitleHeading1Widget(
          text: 'Secure Staking Platform',
          maxLines: 1,
          textOverflow: TextOverflow.ellipsis,
          color: CustomColor.primaryDarkColor,
          padding: EdgeInsets.only(
            left: Dimensions.paddingSize * 0.4,
            right: Dimensions.paddingSize * 0.4,
          ),
        ),
        verticalSpace(Dimensions.heightSize * 0.66),
        TitleHeading3Widget(
          text: 'By staking money you can easily earn through this system',
          padding: EdgeInsets.only(
            left: Dimensions.paddingSize * 0.4,
            right: Dimensions.paddingSize * 0.4,
          ),
          color: CustomColor.greyBlackColor,
          fontWeight: FontWeight.w700,
          textAlign: TextAlign.center,
          maxLines: 2,
          opacity: 0.6,
          textOverflow: TextOverflow.ellipsis,
        ),
        verticalSpace(Dimensions.heightSize * 3),
        SizedBox(
          height: Dimensions.heightSize * 3.6,
          width: Dimensions.widthSize * 17.8,
          child: PrimaryButton(
            fontSize: Dimensions.headingTextSize3,
            title: Strings.getStarted.tr,
            fontWeight: FontWeight.w700,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius * 10)),
            onPressed: () {
              LocalStorage.saveOnboardDoneOrNot(isOnBoardDone: true);
              controller.pageNavigate();
            },
            borderColor: Get.isDarkMode
                ? CustomColor.primaryDarkColor
                : CustomColor.primaryLightColor,
            buttonColor: Get.isDarkMode
                ? CustomColor.primaryDarkColor
                : CustomColor.primaryLightColor,
          ),
        ),
        verticalSpace(Dimensions.heightSize * 6),
      ],
    );
  }
}
