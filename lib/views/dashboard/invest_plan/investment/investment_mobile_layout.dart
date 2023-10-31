// ignore_for_file: unrelated_type_equality_checks
import 'package:crypinvest/backend/backend_utils/custom_loading_api.dart';
import 'package:crypinvest/backend/local_storage/local_storage.dart';
import 'package:crypinvest/widgets/gradient_container/gradient_container.dart';
import '../../../../backend/backend_utils/custom_snackbar.dart';
import '../../../../controller/dashboard/investment/investment_controller.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/appbar/custom_app_bar.dart';
import '../../../../widgets/inputs/check_box_widget.dart';
import '../../../../widgets/text_labels/title_heading5_widget.dart';

class InvestmentMobileLayout extends StatelessWidget {
  InvestmentMobileLayout({super.key});

  final inputFormKey = GlobalKey<FormState>();

  final Color borderColor = Get.isDarkMode
      ? CustomColor.greyBlackColor.withOpacity(.15)
      : CustomColor.greyBlackColor.withOpacity(.15);
  final controller = Get.put(InvestmentController());
  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Scaffold(
        appBar: CustomAppBar(
          title: Strings.investment.tr,
          titleClr: CustomColor.primaryDarkColor,
          bgClr: CustomColor.transparentColor,
          elevation: 0.0,
          onTap: () => Get.back(),
        ),
        body: _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize * .6),
      children: [
        _planWidget(context),
        _inputWidget(context),
        _privacyPolicyWidget(context),
        _buttonWidget(context),
      ],
    );
  }

  _planWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.paddingSize * 0.8),
      decoration: ShapeDecoration(
        color: CustomColor.primaryLightColor.withOpacity(0.1),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius * 1.5)),
      ),
      child: Column(
        mainAxisAlignment: mainCenter,
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.4,
                child: TitleHeading1Widget(
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                  text: controller.slug.value.toUpperCase(),
                  fontSize: Dimensions.headingTextSize3 * 2,
                  textAlign: TextAlign.center,
                  color: CustomColor.greyBlackColor,
                ),
              ),
              horizontalSpace(Dimensions.widthSize * 0.7),
              Container(
                height: Dimensions.heightSize * 2.6,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 2,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: CustomColor.primaryLightColor,
                    ),
                  ),
                ),
              ),
              horizontalSpace(Dimensions.widthSize * 0.7),
              Column(
                children: [
                  TitleHeading1Widget(
                    text: "${controller.profitReturn.value} ${Strings.days}",
                    color: CustomColor.primaryLightColor,
                    textAlign: TextAlign.center,
                  ),
                  TitleHeading5Widget(
                    text: Strings.duration,
                    color: CustomColor.primaryLightColor,
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            ],
          ),
          verticalSpace(Dimensions.heightSize * 2),
          Row(
            mainAxisAlignment: mainSpaceBet,
            children: [
              Column(
                children: [
                  TitleHeading2Widget(
                    text: controller.minInvestOffer.value == 0.00
                        ? "${LocalStorage.getCurrencySymbol()}${double.parse(controller.minInvestOffer.value).toStringAsFixed(2)}"
                        : "${LocalStorage.getCurrencySymbol()}${double.parse(controller.minProfit.value).toStringAsFixed(2)}",
                    color: CustomColor.greyBlackColor,
                    opacity: 0.6,
                  ),
                  TitleHeading5Widget(
                    text: Strings.minimumProfit,
                    color: CustomColor.greyBlackColor,
                    opacity: 0.6,
                  ),
                ],
              ),
              Column(
                children: [
                  TitleHeading2Widget(
                    text:
                        "${LocalStorage.getCurrencySymbol()}${double.parse(controller.maxInvest.value).toStringAsFixed(2)}",
                    color: CustomColor.greyBlackColor,
                    opacity: 0.6,
                  ),
                  TitleHeading5Widget(
                    text: Strings.maximumInvest,
                    color: CustomColor.greyBlackColor,
                    opacity: 0.6,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  _inputWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.marginSizeVertical),
      child: Form(
        key: inputFormKey,
        child: PrimaryTextInputWidget(
          controller: controller.amountController,
          labelText: Strings.investmentAmount.tr,
          hintText: Strings.enterInvestmentAmount.tr,
          borderColor: borderColor,
          keyboardType: TextInputType.number,
          suffixIcon: Container(
            decoration: BoxDecoration(
              color: Get.isDarkMode
                  ? CustomColor.primaryDarkColor
                  : CustomColor.primaryLightColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius * 0.5),
                topRight: Radius.circular(Dimensions.radius * 0.5),
              ),
            ),
            width: Dimensions.widthSize * 8,
            child: Center(
              child: TitleHeading2Widget(
                text: LocalStorage.getBaseCurrency()!,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _privacyPolicyWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: Dimensions.paddingSize * .5, left: Dimensions.paddingSize * .10),
      child: Row(
        crossAxisAlignment: crossStart,
        children: [
          CheckBoxWidget(
            isChecked: controller.isSelected,
            onChecked: (value) {
              controller.isSelected.value = value;
            },
            color: CustomColor.primaryLightColor,
            fontSize: Dimensions.headingTextSize5,
            title: Strings.terms,
          ),
        ],
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: Dimensions.marginSizeVertical * 4,
        bottom: Dimensions.marginSizeVertical,
      ),
      child: Obx(
        () => controller.isPurchaseLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
                title: Strings.proceed,
                onPressed: () {
                  if (inputFormKey.currentState!.validate()) {
                    controller.isSelected.value == false
                        ? controller.investPurchaseProcess()
                        : CustomSnackBar.error(Strings.acceptTerms);
                  }
                },
              ),
      ),
    );
  }
}
