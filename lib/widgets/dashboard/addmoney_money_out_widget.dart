import 'package:crypinvest/utils/basic_widget_imports.dart';

class AddMoneyMoneyOutWidget extends StatelessWidget {
  const AddMoneyMoneyOutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainCenter,
      children: [
        Container(
          height: Dimensions.heightSize,
          width: Dimensions.widthSize * 1.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius * 0.4),
            color: CustomColor.primaryLightColor,
          ),
        ),
        horizontalSpace(Dimensions.widthSize * 0.4),
        TitleHeading3Widget(
          fontSize: Dimensions.headingTextSize6,
          text: Strings.addMoney,
          color: CustomColor.greyBlackColor,
        ),
        horizontalSpace(Dimensions.widthSize),
        Container(
          height: Dimensions.heightSize,
          width: Dimensions.widthSize * 1.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius * 0.4),
            color: CustomColor.secondaryDarkColor,
          ),
        ),
        horizontalSpace(Dimensions.widthSize * 0.4),
        TitleHeading3Widget(
          text: Strings.moneyOut,
          fontSize: Dimensions.headingTextSize6,
          color: CustomColor.greyBlackColor,
        ),
      ],
    );
  }
}
