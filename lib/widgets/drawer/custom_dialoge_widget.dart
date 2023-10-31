import 'package:crypinvest/backend/backend_utils/custom_loading_api.dart';
import 'package:crypinvest/language/english.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/sign_out/sign_out_controller.dart';
import '../../language/language_controller.dart';
import '../../utils/custom_color.dart';
import '../../utils/dimensions.dart';

class CustomDialog {
  static show(
      {required String title,
      required String subtitle,
      required VoidCallback cancelOnTap,
      required VoidCallback confirmOnTap}) {
    final logOutController = Get.put(LogOutController());
    final languageController = Get.put(LanguageController());
    return Get.defaultDialog(
        title: languageController.getTranslation(title),
        titleStyle: GoogleFonts.inter(
          fontSize: Dimensions.headingTextSize2,
          fontWeight: FontWeight.bold,
          color: CustomColor.primaryLightColor,
        ),
        content: Text(
          languageController.getTranslation(subtitle),
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: Dimensions.headingTextSize3 * 1.06,
            fontWeight: FontWeight.w500,
            color: CustomColor.greyBlackColor.withOpacity(0.6),
          ),
        ),
        confirm: logOutController.isLoading
            ? const CustomLoadingAPI()
            : TextButton(
                onPressed: confirmOnTap,
                child: Container(
                  padding: EdgeInsets.all(Dimensions.paddingSize * 0.2),
                  decoration: BoxDecoration(
                      color: CustomColor.primaryLightColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    languageController.getTranslation(Strings.yes),
                    style: GoogleFonts.inter(
                      fontSize: Dimensions.headingTextSize3 * 1.06,
                      fontWeight: FontWeight.w500,
                      color: CustomColor.whiteColor,
                    ),
                  ),
                )),
        cancel: TextButton(
            onPressed: cancelOnTap,
            child: Container(
              padding: EdgeInsets.all(Dimensions.paddingSize * 0.2),
              decoration: BoxDecoration(
                  color: CustomColor.primaryLightColor,
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                languageController.getTranslation(Strings.no),
                style: GoogleFonts.inter(
                  fontSize: Dimensions.headingTextSize3 * 1.06,
                  fontWeight: FontWeight.w500,
                  color: CustomColor.whiteColor,
                ),
              ),
            )),
        radius: 10.0);
  }
}
