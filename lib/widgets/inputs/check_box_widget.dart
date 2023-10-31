// ignore_for_file: deprecated_member_use

import 'package:crypinvest/backend/local_storage/local_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/basic_widget_imports.dart';

class CheckBoxWidget extends StatelessWidget {
  const CheckBoxWidget({
    Key? key,
    required this.isChecked,
    this.onChecked,
    required this.title,
    this.fontSize = 12,
    this.color = CustomColor.primaryDarkTextColor,
  }) : super(key: key);
  final RxBool isChecked;
  final void Function(bool)? onChecked;
  final String title;
  final double? fontSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: mainCenter,
        children: [
          Row(
            mainAxisAlignment: mainStart,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(Dimensions.radius * .4),
                onTap: () {
                  isChecked.value = !isChecked.value;
                  onChecked!(isChecked.value);
                },
                child: Row(
                  children: [
                    Container(
                      height: Dimensions.heightSize * 1.27,
                      width: Dimensions.widthSize * 1.75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: isChecked.value
                            ? CustomColor.greyBlackColor.withOpacity(0.2)
                            : CustomColor.primaryLightColor,
                        border: Border.all(
                          width: 1.5,
                          color: CustomColor.primaryLightColor.withOpacity(0.2),
                        ),
                      ),
                      child: Icon(
                        Icons.check,
                        size: Dimensions.heightSize,
                        color: isChecked.value
                            ? CustomColor.whiteColor.withOpacity(.00)
                            : CustomColor.whiteColor,
                      ),
                    ),
                    horizontalSpace(Dimensions.widthSize * 0.2),
                    CustomTitleHeadingWidget(
                      text: Strings.agreeWith,
                      style: Get.isDarkMode
                          ? CustomStyle.darkHeading5TextStyle.copyWith(
                              fontSize: fontSize,
                              color: CustomColor.greyBlackColor,
                              letterSpacing: .01,
                              wordSpacing: .01)
                          : CustomStyle.lightHeading5TextStyle.copyWith(
                              fontSize: fontSize,
                              color: CustomColor.greyBlackColor,
                              letterSpacing: .01,
                              wordSpacing: .01),
                    ),
                  ],
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              launch(LocalStorage.getPrivacyPolicy());
            },
            child: CustomTitleHeadingWidget(
              text: title,
              style: Get.isDarkMode
                  ? CustomStyle.darkHeading5TextStyle.copyWith(
                      fontSize: fontSize,
                      color: color,
                      letterSpacing: .01,
                      wordSpacing: .01,
                    )
                  : CustomStyle.lightHeading5TextStyle.copyWith(
                      fontSize: fontSize,
                      color: color,
                      letterSpacing: .01,
                      wordSpacing: .01),
            ),
          ),
        ],
      ),
    );
  }
}
