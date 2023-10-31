import '../../utils/basic_screen_imports.dart';

extension MoneyTransferAmountInformation on Widget {
  Widget moneyTransferAmountInformationWidget({
    required information,
    required enteredAmount,
    required enterAmountRow,
    charges,
    chargeRate,
    received,
    receivedRow,
    total,
    totalRow,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSize * 0.5,
          vertical: Dimensions.paddingSize * 0.5),
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
              color: CustomColor.primaryDarkColor,
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
              children: [
                Row(
                  mainAxisAlignment: mainSpaceBet,
                  children: [
                    TitleHeading4Widget(
                        text: enteredAmount, color: CustomColor.greyBlackColor),
                    TitleHeading3Widget(
                      text: enterAmountRow,
                      color: CustomColor.primaryLightColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                verticalSpace(Dimensions.heightSize * 0.7),
                Row(
                  mainAxisAlignment: mainSpaceBet,
                  children: [
                    TitleHeading4Widget(
                        text: charges, color: CustomColor.greyBlackColor),
                    TitleHeading3Widget(
                      text: chargeRate,
                      color: CustomColor.primaryLightColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                verticalSpace(Dimensions.heightSize * 0.7),
                Row(
                  mainAxisAlignment: mainSpaceBet,
                  children: [
                    TitleHeading4Widget(
                        text: received, color: CustomColor.greyBlackColor),
                    TitleHeading3Widget(
                      text: receivedRow,
                      color: CustomColor.primaryLightColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                verticalSpace(Dimensions.heightSize * 0.7),
                Row(
                  mainAxisAlignment: mainSpaceBet,
                  children: [
                    TitleHeading4Widget(
                        text: total, color: CustomColor.greyBlackColor),
                    TitleHeading3Widget(
                      text: totalRow,
                      color: CustomColor.primaryLightColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
