import 'package:crypinvest/extensions/context_ext.dart';
import 'package:crypinvest/utils/basic_screen_imports.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.title,
    required this.balance,
    required this.buttonText,
    required this.onTap,
  });

  final String title, balance, buttonText;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.h * 0.25,
      width: context.w * 0.6,
      margin: EdgeInsets.only(
        right: Dimensions.marginSizeHorizontal * 0.6,
        bottom: Dimensions.marginSizeHorizontal * 0.6,
      ),
      padding: EdgeInsets.all(Dimensions.paddingSize * 0.5),
      decoration: BoxDecoration(
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
      child: Column(
        mainAxisAlignment: mainCenter,
        children: [
          TitleHeading2Widget(
            text: balance,
            maxLines: 1,
            textOverflow: TextOverflow.ellipsis,
            color: CustomColor.blackColor,
          ),
          TitleHeading3Widget(
            text: title,
            opacity: 0.6,
            maxLines: 1,
            textOverflow: TextOverflow.ellipsis,
            color: CustomColor.blackColor,
            fontSize: Dimensions.headingTextSize3 - 2,
          ),
          verticalSpace(Dimensions.heightSize * 1.5),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Dimensions.paddingSize * 0.7),
            child: PrimaryButton(
              height: Dimensions.buttonHeight * 0.62,
              title: buttonText,
              onPressed: onTap,
              borderColor: Get.isDarkMode
                  ? CustomColor.primaryDarkColor
                  : CustomColor.primaryLightColor,
              buttonColor: Get.isDarkMode
                  ? CustomColor.primaryDarkColor
                  : CustomColor.primaryLightColor,
            ),
          )
        ],
      ),
    );
  }
}
