import 'package:crypinvest/language/language_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../backend/model/profile/profile_model.dart';
import '../../utils/basic_screen_imports.dart';

class CountryDropdownInputWidget extends StatelessWidget {
  final RxString selectMethod;
  final List<Country> itemsList;
  final void Function(Country?)? onChanged;
  final String hintText, labelText;
  final bool readOnly;
  final Widget? suffix;
  final IconData iconData;
  final double size;
  final EdgeInsetsGeometry padding;

  CountryDropdownInputWidget({
    Key? key,
    required this.itemsList,
    required this.selectMethod,
    required this.hintText,
    required this.labelText,
    this.readOnly = false,
    this.onChanged,
    this.suffix,
    required this.iconData,
    this.size = 24,
    required this.padding,
  }) : super(key: key);
  final languageController = Get.put(LanguageController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: InputDecorator(
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius * 0.5),
                  topRight: Radius.circular(Dimensions.radius * 0.5),
                ),
                borderSide: BorderSide(
                  color: CustomColor.greyBlackColor.withOpacity(.35),
                  width: 2.5,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius * 0.8),
                  topRight: Radius.circular(Dimensions.radius * 0.8),
                ),
                borderSide: const BorderSide(
                    color: CustomColor.greyBlackColor, width: 2),
              ),
              errorBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius * 0.8),
                  topRight: Radius.circular(Dimensions.radius * 0.8),
                ),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
              focusedErrorBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius * 0.8),
                  topRight: Radius.circular(Dimensions.radius * 0.8),
                ),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
              contentPadding: EdgeInsets.only(
                  left: Dimensions.paddingSize * .75,
                  right: Dimensions.paddingSize * .5,
                  top: Dimensions.paddingSize * .1,
                  bottom: Dimensions.paddingSize * .1),
              filled: true,
              fillColor: CustomColor.whiteColor.withOpacity(.06),
              hintText: languageController.getTranslation(hintText),
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
              suffixIcon: suffix,
            ),
            child: DropdownButtonHideUnderline(
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                  ),
                  hint: Padding(
                    padding: EdgeInsets.only(
                      right: Dimensions.paddingSize * 0.2,
                    ),
                    child: Text(
                      languageController.getTranslation(selectMethod.value),
                      style: CustomStyle.lightHeading3TextStyle
                          .copyWith(color: CustomColor.primaryLightColor),
                    ),
                  ),
                  icon: const Padding(
                    padding: EdgeInsets.only(left: 14),
                    child: Icon(
                      Icons.arrow_drop_down,
                      color: CustomColor.primaryLightColor,
                    ),
                  ),
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                  items: itemsList.map<DropdownMenuItem<Country>>((value) {
                    return DropdownMenuItem<Country>(
                      value: value,
                      child: Text(
                        value.name,
                        style: GoogleFonts.inter(
                          color: selectMethod.value == value.name
                              ? CustomColor.primaryLightColor
                              : CustomColor.primaryLightColor,
                          fontSize: Dimensions.headingTextSize4,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: onChanged,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
