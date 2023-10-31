import '../../utils/basic_screen_imports.dart';

class ProfitLogWidget extends StatelessWidget {
  const ProfitLogWidget(
      {super.key,
      required this.title,
      required this.dateText,
      required this.investmentAmount,
      required this.profitAmount,
      required this.monthText});

  final String title, monthText, dateText, investmentAmount, profitAmount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.paddingSize * 0.3),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
          color: CustomColor.primaryLightColor.withOpacity(.08),
        ),
        padding: EdgeInsets.only(right: Dimensions.paddingSize * 0.2),
        height: Dimensions.heightSize * 6,
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                margin: EdgeInsets.only(
                  left: Dimensions.marginSizeVertical * 0.4,
                  top: Dimensions.marginSizeVertical * 0.4,
                  bottom: Dimensions.marginSizeVertical * 0.4,
                  right: Dimensions.marginSizeVertical * 0.2,
                ),
                padding: EdgeInsets.only(
                  left: Dimensions.paddingSize * 0.2,
                  right: Dimensions.paddingSize * 0.2,
                ),
                decoration: BoxDecoration(
                    color: CustomColor.primaryLightColor.withOpacity(.10),
                    borderRadius: BorderRadius.circular(Dimensions.radius)),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: mainCenter,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: crossCenter,
                  children: [
                    TitleHeading4Widget(
                      text: dateText,
                      fontSize: Dimensions.headingTextSize1,
                      fontWeight: FontWeight.w600,
                      color: CustomColor.greyBlackColor,
                    ),
                    TitleHeading4Widget(
                      text: monthText,
                      fontSize: Dimensions.headingTextSize6 - 2,
                      fontWeight: FontWeight.w500,
                      color: CustomColor.greyBlackColor,
                    ),
                  ],
                ),
              ),
            ),
            horizontalSpace(Dimensions.widthSize),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: crossStart,
                mainAxisAlignment: mainCenter,
                children: [
                  TitleHeading1Widget(
                    text: title,
                    fontSize: Dimensions.headingTextSize4 + 1,
                    fontWeight: FontWeight.w700,
                    color: CustomColor.primaryLightColor,
                  ),
                  verticalSpace(Dimensions.widthSize * 0.4),
                  TitleHeading2Widget(
                      maxLines: 1,
                      text: investmentAmount,
                      fontSize: Dimensions.headingTextSize5,
                      fontWeight: FontWeight.normal,
                      color: CustomColor.greyBlackColor.withOpacity(.6)),
                ],
              ),
            ),
            Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: mainCenter,
                  children: [
                    TitleHeading2Widget(
                        maxLines: 1,
                        text: profitAmount,
                        fontSize: Dimensions.headingTextSize3 - 2,
                        fontWeight: FontWeight.normal,
                        color: CustomColor.primaryLightColor),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
