import 'package:clipboard/clipboard.dart';
import 'package:crypinvest/backend/backend_utils/custom_loading_api.dart';
import 'package:crypinvest/controller/dashboard/money_out/money_out_manual_controller.dart';
import 'package:crypinvest/routes/routes.dart';
import 'package:crypinvest/utils/basic_screen_imports.dart';
import 'package:crypinvest/widgets/gradient_container/gradient_container.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/appbar/custom_app_bar.dart';
import '../../../backend/backend_utils/custom_snackbar.dart';
import '../../../widgets/dropdown/kyc_dropdown.dart';
import '../../../widgets/inputs/manual_input_field.dart';


class MoneyOutManualPaymentScreen extends StatelessWidget {
  MoneyOutManualPaymentScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final controller = Get.put(MoneyOutManualController());

  final String textToCopy = "0xfbC26841C173e9cce7Be7C811Cb8fE06289Be820";

  void copyToClipboard(BuildContext context) {
    FlutterClipboard.copy(textToCopy);
        Get.snackbar(
          'Copy Text',
          'Text copied to clipboard',
          colorText: CustomColor.whiteColor,
          backgroundColor: CustomColor.primaryDarkColor,
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.symmetric(horizontal: 15),
        );

  }

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Withdraw",
          titleClr: CustomColor.primaryDarkColor,
          bgClr: CustomColor.transparentColor,
          elevation: 0.0,
          onTap: () => Get.back(),
        ),
        body: Obx(
          () => controller.isLoading
              ? const CustomLoadingAPI()
              : _bodyWidget(context),
        ),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSize * 0.7,
        vertical: Dimensions.paddingSize * 0.7,
      ),
      child: Form(
        key: formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Text(
              "Please Before Send And Receive Token You Must Import The Token In Your Wallet By Smart Contract:",
              style: TextStyle(
                fontSize: Dimensions.headingTextSize3,
                fontWeight: FontWeight.w600,
                color: CustomColor.primaryDarkColor.withOpacity(1),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  textToCopy,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: CustomColor.blackColor.withOpacity(1),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.copy, color: CustomColor.blackColor.withOpacity(1),),
                  onPressed: () {
                    copyToClipboard(context);
                  },
                ),
              ],
            ),
            SizedBox(height: 20,),
            // ...controller.inputFields.
            // map((element) {
            //   return element;
            // }).toList(),


            Column(
              children: [
                PrimaryInputWidget(
                  customPadding: EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSize * 0.6,
                      vertical: Dimensions.paddingSize * 0.6),
                  controller: controller.address,
                  label: "Wallet Address",
                  hintText: "Type here...",
                  isValidator: true,
                  isFilled: true,
                  autoFocus: true,
                  fillColor: CustomColor.primaryLightColor.withOpacity(.15),

                ),
                verticalSpace(Dimensions.heightSize),
              ],
            ),


            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Dimensions.marginBetweenInputTitleAndBox,
                ),
                CustomTitleHeadingWidget(
                  text: "Wallet",
                  style: CustomStyle.darkHeading4TextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    color: CustomColor.primaryLightColor,
                  ),
                ),
                SizedBox(
                  height: Dimensions.marginBetweenInputTitleAndBox,
                ),
                KycDynamicDropDown(
                  selectMethod: controller.selectedWallet.value.obs,
                  itemsList: ["Balance","Profit Balance"],
                  onChanged: (value) {

                    controller.selectedWallet.value = value.toString();
                    // controller.selectedWalletCode.value = value.mobileCode;
                    printInfo(info: value.toString());
                    if (value == "Balance"){
                      value = "c_balance";
                    } else {
                      value = "p_balance";
                    }

                    GetStorage().write("wallet", value);
                  },
                ),
              ],
            ),




            _buttonWidget(context)
          ],
        ),
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.marginSizeVertical),
      child: PrimaryButton(
        title: Strings.submit,
        onPressed: () {
          // debugPrint("hello");
          if (controller.address.text == "" || (GetStorage().read("wallet") ?? "") == ""){
            CustomSnackBar.error("Enter Address or Wallet");
          } else {
            GetStorage().write("address", controller.address.text);
            Get.toNamed(Routes.moneyOutPreviewScreen);
          }
          // Get.toNamed(Routes.moneyOutPreviewScreen);
          // if (formKey.currentState!.validate()) {
          //   if (controller.listImagePath.isNotEmpty) {
          //
          //   } else {
          //     CustomSnackBar.error(Strings.imagePathRequired);
          //   }
          // }
        },
      ),
    );
  }
}
