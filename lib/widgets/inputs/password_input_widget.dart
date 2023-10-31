import 'package:crypinvest/language/language_controller.dart';

import '../../utils/basic_widget_imports.dart';
import 'package:iconsax/iconsax.dart';

class PasswordInputWidget extends StatefulWidget {
  const PasswordInputWidget({
    Key? key,
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.readOnly = false,
    this.focusedBorderWidth = 2,
    this.enabledBorderWidth = 2.5,
    this.errorBorderWidth = 2,
    this.focusedErrorBorderWidth = 2,
    this.color = Colors.white,
    required this.borderColor,
    this.suffixColor = CustomColor.primaryLightColor,
    required this.labelText,
  }) : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final Color? color;
  final double focusedBorderWidth;
  final double enabledBorderWidth;
  final double errorBorderWidth;
  final double focusedErrorBorderWidth;
  final Color borderColor;
  final Color? suffixColor;

  @override
  State<PasswordInputWidget> createState() => _PasswordInputWidgetState();
}

class _PasswordInputWidgetState extends State<PasswordInputWidget> {
  bool isVisibility = true;
  FocusNode? focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode!.dispose();
    super.dispose();
  }

  final languageController = Get.put(LanguageController());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        TitleHeading4Widget(
          text: widget.labelText,
          fontSize: Dimensions.headingTextSize3,
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.left,
          color: CustomColor.greyBlackColor,
          padding: EdgeInsets.only(bottom: Dimensions.paddingSize * .25),
        ),
        SizedBox(
          child: TextFormField(
            style: Get.isDarkMode
                ? CustomStyle.darkHeading3TextStyle
                    .copyWith(color: CustomColor.primaryDarkColor)
                : CustomStyle.lightHeading3TextStyle
                    .copyWith(color: CustomColor.primaryLightColor),
            readOnly: widget.readOnly!,
            // style: CustomStyle.textStyle,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            validator: (String? value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
            onTap: () {
              setState(() {
                focusNode!.requestFocus();
              });
            },
            onFieldSubmitted: (value) {
              setState(() {
                focusNode!.unfocus();
              });
            },
            cursorColor: CustomColor.primaryLightColor,
            focusNode: focusNode,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius * 0.5),
                  topRight: Radius.circular(Dimensions.radius * 0.5),
                ),
                borderSide: BorderSide(
                  color: widget.borderColor.withOpacity(0.4),
                  width: widget.enabledBorderWidth,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius * 0.8),
                  topRight: Radius.circular(Dimensions.radius * 0.8),
                ),
                borderSide: BorderSide(
                  color: CustomColor.greyBlackColor,
                  width: widget.focusedBorderWidth,
                ),
              ),
              errorBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius * 0.8),
                  topRight: Radius.circular(Dimensions.radius * 0.8),
                ),
                borderSide: BorderSide(
                    color: Colors.red, width: widget.errorBorderWidth),
              ),
              focusedErrorBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius * 0.8),
                  topRight: Radius.circular(Dimensions.radius * 0.8),
                ),
                borderSide: BorderSide(
                    color: Colors.red, width: widget.focusedErrorBorderWidth),
              ),
              // filled: true,
              fillColor: focusNode!.hasFocus
                  ? CustomColor.primaryLightColor.withOpacity(.15)
                  : CustomColor.whiteColor.withOpacity(.06),
              contentPadding: EdgeInsets.only(
                  left: Dimensions.paddingSize * .75,
                  right: Dimensions.paddingSize * .5,
                  top: Dimensions.paddingSize * .5,
                  bottom: Dimensions.paddingSize * .5),
              hintText: languageController.getTranslation(widget.hintText),
              hintStyle: Get.isDarkMode
                  ? CustomStyle.darkHeading3TextStyle.copyWith(
                      color: CustomColor.greyBlackColor.withOpacity(0.1),
                      fontWeight: FontWeight.w500,
                      fontSize: Dimensions.headingTextSize3,
                    )
                  : CustomStyle.lightHeading3TextStyle.copyWith(
                      color: CustomColor.greyBlackColor.withOpacity(0.1),
                      fontWeight: FontWeight.w500,
                      fontSize: Dimensions.headingTextSize3,
                    ),
              suffixIcon: IconButton(
                icon: Icon(
                  isVisibility ? Iconsax.eye : Iconsax.eye_slash,
                  color: widget.suffixColor?.withOpacity(0.6),
                  size: Dimensions.iconSizeDefault,
                ),
                color: widget.color,
                onPressed: () {
                  setState(() {
                    isVisibility = !isVisibility;
                  });
                },
              ),
            ),
            obscureText: isVisibility,
          ),
        )
      ],
    );
  }
}
