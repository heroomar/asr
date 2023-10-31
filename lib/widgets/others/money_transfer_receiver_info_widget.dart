import '../../utils/basic_screen_imports.dart';

extension MoneyTransferReceiverInformation on Widget {
  Widget moneyTransferReceiverInformationWidget({
    required information,
    required receiverEmailAddress,
    emailAddress,
  }) {
    return Container(
      height: Dimensions.heightSize * 9,
      margin: EdgeInsets.only(top: Dimensions.heightSize * 0.25),
      decoration: BoxDecoration(
        color: CustomColor.drawerBackgroundColor,
        borderRadius: BorderRadius.circular(Dimensions.radius * 1.5),
        gradient: gradientBackground(),
        boxShadow: boxShadow(),
      ),
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: Dimensions.paddingSize * 0.7,
              bottom: Dimensions.paddingSize * 0.3,
              left: Dimensions.paddingSize * 0.7,
              right: Dimensions.paddingSize * 0.7,
            ),
            child: TitleHeading3Widget(
              text: information,
              textAlign: TextAlign.left,
              color: CustomColor.primaryLightColor,
            ),
          ),
          const Divider(thickness: 2, color: CustomColor.primaryLightColor),
          Padding(
            padding: EdgeInsets.only(
              top: Dimensions.paddingSize * 0.3,
              bottom: Dimensions.paddingSize * 0.6,
              left: Dimensions.paddingSize * 0.7,
              right: Dimensions.paddingSize * 0.7,
            ),
            child: Column(
              crossAxisAlignment: crossStart,
              children: [
                TitleHeading4Widget(
                  text: receiverEmailAddress,
                  color: Get.isDarkMode
                      ? CustomColor.greyBlackColor
                      : CustomColor.greyBlackColor,
                  fontWeight: FontWeight.w600,
                ),
                verticalSpace(Dimensions.heightSize * 0.2),
                TitleHeading4Widget(
                  text: emailAddress,
                  textAlign: TextAlign.start,
                  color: CustomColor.greyBlackColor,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
