import 'package:crypinvest/language/language_controller.dart';
import 'package:crypinvest/utils/custom_color.dart';
import 'package:crypinvest/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeLanguageWidget extends StatelessWidget {
  ChangeLanguageWidget({super.key, this.isOnboard = false});
  final bool isOnboard;
  final _languageController = Get.put(LanguageController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _languageController.isLoading
          ? const Text('')
          : !isOnboard
              ? _dropDown(context)
              : Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSize * 0.15,
                    horizontal: Dimensions.paddingSize * 0.5,
                  ),
                  decoration: BoxDecoration(
                    color: CustomColor.whiteColor.withOpacity(0.5),
                    borderRadius:
                        BorderRadius.circular(Dimensions.radius * 0.6),
                  ),
                  child: _dropDown(context),
                ),
    );
  }

  _dropDown(BuildContext context) {
    return DropdownButton<String>(
      dropdownColor: CustomColor.whiteColor,
      value: _languageController.selectedLanguage.value,
      underline: isOnboard ? Container() : null,
      icon: Icon(
        Icons.arrow_drop_down_rounded,
        color: isOnboard ? CustomColor.primaryLightColor : null,
      ).paddingOnly(top: Dimensions.heightSize * 0.2),
      onChanged: (String? newValue) {
        if (newValue != null) {
          _languageController.changeLanguage(newValue);
        }
      },
      items: _languageController.languages.map<DropdownMenuItem<String>>(
        (language) {
          return DropdownMenuItem<String>(
            value: language.code,
            child: Text(
              isOnboard ? language.code.toUpperCase() : language.name,
              style: const TextStyle(color: CustomColor.primaryLightColor),
            ),
          );
        },
      ).toList(),
    );
  }
}
