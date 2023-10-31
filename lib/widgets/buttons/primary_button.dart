import 'package:crypinvest/language/language_controller.dart';

import '../../utils/basic_widget_imports.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.borderColor = CustomColor.primaryLightColor,
    this.borderWidth = 2,
    this.height,
    this.buttonColor = CustomColor.primaryLightColor,
    this.buttonTextColor = CustomColor.primaryLightTextColor,
    this.shape,
    this.icon,
    this.fontSize,
    this.fontWeight,
  }) : super(key: key);
  final String title;
  final VoidCallback onPressed;
  final Color borderColor;
  final double borderWidth;
  final double? height;

  final Color buttonColor;
  final Color buttonTextColor;
  final OutlinedBorder? shape;
  final Widget? icon;
  final double? fontSize;
  final FontWeight? fontWeight;
  final controller = Get.put(LanguageController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: height ?? Dimensions.buttonHeight * 0.8,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: shape ??
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius * 0.7),
                ),
            backgroundColor: buttonColor,
            foregroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            side: BorderSide(
              width: borderWidth,
              color: borderColor,
            ),
          ),
          child: FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  controller.getTranslation(title),
                  style: CustomStyle.darkHeading3TextStyle.copyWith(
                    fontSize: fontSize,
                    fontWeight: fontWeight ?? FontWeight.w700,
                    color: buttonTextColor,
                  ),
                ),
                icon ?? const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
