import '../../utils/basic_screen_imports.dart';

extension MoneyTransferAmountPreviewWidget on Widget {
  Widget moneyTransferAmountPreviewWidget({
    required amount,
  }) {
    return Container(
      height: 150.h,
      decoration: BoxDecoration(
        color: CustomColor.drawerBackgroundColor,
        borderRadius: BorderRadius.circular(Dimensions.radius * 1.5),
        gradient: gradientBackground(),
        boxShadow: boxShadow(),
      ),
      margin:
          EdgeInsets.symmetric(vertical: Dimensions.marginSizeVertical * 0.5),
      child: Column(
        mainAxisAlignment: mainCenter,
        children: [
          CustomTitleHeadingWidget(
            padding: EdgeInsets.only(bottom: Dimensions.paddingSize * .25),
            text: amount,
            textAlign: TextAlign.center,
            style: CustomStyle.darkHeading1TextStyle.copyWith(
              fontSize: Dimensions.headingTextSize4 * 2,
              fontWeight: FontWeight.w800,
              color: CustomColor.primaryLightColor,
            ),
          ),
          const TitleHeading4Widget(
            text: Strings.enteredAmount,
            textAlign: TextAlign.center,
            color: CustomColor.greyBlackColor,
          ),
        ],
      ),
    );
  }
}
