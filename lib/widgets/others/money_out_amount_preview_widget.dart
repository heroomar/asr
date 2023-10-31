import '../../utils/basic_screen_imports.dart';

extension MoneyOutAmountPreviewWidget on Widget {
  Widget moneyOutAmountPreviewWidget({
    required amount,
  }) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
          color: CustomColor.drawerBackgroundColor,
          borderRadius: BorderRadius.circular(Dimensions.radius * 1.5),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              CustomColor.backgroundGradientTopColor,
              CustomColor.backgroundGradientBottomColor,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: CustomColor.greyBlackColor.withOpacity(.1),
              offset: const Offset(1, 1),
              blurRadius: 2,
              spreadRadius: 0.0,
              blurStyle: BlurStyle.outer,
            ),
            BoxShadow(
              color: CustomColor.greyBlackColor.withOpacity(.1),
              offset: const Offset(1, 1),
              blurRadius: 2,
              spreadRadius: 0.0,
            ),
          ]),
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
