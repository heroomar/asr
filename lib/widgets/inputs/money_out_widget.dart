import 'dart:io';
import 'package:crypinvest/backend/local_storage/local_storage.dart';
import 'package:flutter/services.dart';
import '../../../../controller/dashboard/money_out/money_out_controller.dart';
import '../../../../widgets/text_labels/title_heading5_widget.dart';
import '../../backend/model/categories/withdraw/withdraw_info_model.dart';
import '../../custom_assets/assets.gen.dart';
import '../../utils/basic_screen_imports.dart';

class MoneyOutWidget extends StatelessWidget {
  MoneyOutWidget({
    Key? key,
    required this.buttonText,
    required this.onTap,
    // required this.isLoading,
  }) : super(key: key);
  final String buttonText;
  final VoidCallback onTap;
  // final RxBool isLoading;
  final moneyOutController = Get.put((MoneyOutController()));
  @override
  Widget build(BuildContext context) {
    return _bodyWidget(context);
  }

  _bodyWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _moneyOutInputFieldWidget(context),
        _moneyOutLimitWidget(context),
        ///
        // _walletWidget(context),
        _customNumKeyBoardWidget(context),
        _buttonWidget(context),
      ],
    );
  }

  _moneyOutInputFieldWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: Dimensions.marginSizeHorizontal * 0.5,
        left: Dimensions.marginSizeHorizontal * 0.5,
        top: Dimensions.marginSizeVertical * 4,
      ),
      alignment: Alignment.topCenter,
      height: Dimensions.inputBoxHeight,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: Dimensions.widthSize * 0.7),
                Expanded(
                  child: TextFormField(
                    textDirection: TextDirection.rtl,
                    style: Get.isDarkMode
                        ? CustomStyle.lightHeading2TextStyle.copyWith(
                            fontSize: Dimensions.headingTextSize3 * 2,
                          )
                        : CustomStyle.darkHeading2TextStyle.copyWith(
                            color: CustomColor.primaryLightColor,
                            fontSize: Dimensions.headingTextSize3 * 2,
                          ),
                    readOnly: true,
                    controller: moneyOutController.moneyOutAmountTextController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'(^-?\d*\.?\d*)')),
                      LengthLimitingTextInputFormatter(
                        6,
                      ), //max length of 12 characters
                    ],
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return null;
                      } else {
                        return Strings.pleaseFillOutTheField;
                      }
                    },
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                SizedBox(
                  width: Dimensions.widthSize * 0.5,
                ),
              ],
            ),
          ),
          _currencyDropDownWidget(context),
        ],
      ),
    );
  }

  _customNumKeyBoardWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.marginSizeVertical * .25),
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 3 / 1.7,
        shrinkWrap: true,
        children: List.generate(
          moneyOutController.keyboardItemList.length,
          (index) {
            return moneyOutController.inputItem(index);
          },
        ),
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: Dimensions.marginSizeHorizontal * 0.8,
        right: Dimensions.marginSizeHorizontal * 0.8,
        top: Platform.isAndroid ? Dimensions.marginSizeVertical * 1.7 : 0.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: PrimaryButton(
              title: buttonText,
              onPressed: onTap,
              borderColor: Theme.of(context).primaryColor,
              buttonColor: CustomColor.primaryLightColor,
            ),
          ),
        ],
      ),
    );
  }

  _currencyDropDownWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      height: Dimensions.buttonHeight * 0.62,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
          horizontal: Dimensions.marginSizeHorizontal * 0.1,
          vertical: Dimensions.marginSizeVertical * 0.2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius * 3),
          color: CustomColor.primaryLightColor),
      child: Row(
        mainAxisAlignment: mainCenter,
        children: [
          TitleHeading3Widget(
            text: "ASR",
            color: CustomColor.whiteColor,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  _moneyOutLimitWidget(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisAlignment: mainCenter,
        children: [
          TitleHeading5Widget(
            textAlign: TextAlign.center,
            text:
                "${Strings.limit} ${moneyOutController.limitMin.value.toStringAsFixed(2)} ${LocalStorage.getBaseCurrency()!} - ${moneyOutController.limitMax.value.toStringAsFixed(2)} ${LocalStorage.getBaseCurrency()!}",
            color: CustomColor.transparentColor,
          ),
          // verticalSpace(Dimensions.heightSize * 0.5),
          TitleHeading5Widget(
            textAlign: TextAlign.center,
            text:
                "${Strings.rate} ${1.00} ${LocalStorage.getBaseCurrency()} - ${moneyOutController.rate} ${LocalStorage.getBaseCurrency()}",
            color: CustomColor.transparentColor,
          ),
        ],
      ),
    );
  }

  _walletWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: Dimensions.marginSizeVertical * 1.3,
          horizontal: Dimensions.marginSizeHorizontal * .5),
      child: Row(
        mainAxisAlignment: mainCenter,
        children: [
          _walletTypeDropdownWidget(context),
          horizontalSpace(Dimensions.widthSize * 0.6),
          _walletDropDownWidget(context),
        ],
      ),
    );
  }

  _walletTypeDropdownWidget(BuildContext context) {
    return Container(
      height: Dimensions.buttonHeight * 0.70,
      width: MediaQuery.of(context).size.width * 0.45,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSize * .1,
          vertical: Dimensions.paddingSize * 0.2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius * 3),
          color: CustomColor.primaryLightColor),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton(
            underline: Container(),
            hint: Row(
              children: [
                Obx(
                  () => SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: TitleHeading4Widget(
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                      text: moneyOutController.dropdownName.value.isEmpty
                          ? Strings.noWallet
                          : moneyOutController.dropdownName.value,
                      fontSize: Dimensions.headingTextSize3,
                      color: CustomColor.whiteColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            isExpanded: false,
            borderRadius: BorderRadius.circular(Dimensions.radius),
            icon: const Icon(
              Icons.arrow_drop_down_rounded,
              color: CustomColor.whiteColor,
            ),
            items: moneyOutController.withdrawInfoModel.data.balanceType.types
                .map<DropdownMenuItem<Type>>(
              (value) {
                return DropdownMenuItem<Type>(
                  value: value,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 40.h,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image:
                                      AssetImage(Assets.clipart.paypal.path))),
                        ),
                        // SizedBox(
                        //   width: Dimensions.widthSize * .75,
                        // ),
                        Text(
                          value.name,
                          style: TextStyle(
                            color: CustomColor.whiteColor,
                            fontSize: Dimensions.headingTextSize5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ).toList(),
            dropdownColor: CustomColor.primaryLightColor,
            onChanged: (value) {
              moneyOutController.dropdownName.value = value!.name;
              moneyOutController.dropdownValue.value = value.value;
            },
          ),
        ],
      ),
    );
  }

  _walletDropDownWidget(BuildContext context) {
    return Obx(
      () => Container(
        height: Dimensions.buttonHeight * 0.70,
        width: MediaQuery.of(context).size.width * 0.45,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSize * .1,
            vertical: Dimensions.paddingSize * 0.2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius * 3),
            color: CustomColor.primaryLightColor),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton(
              underline: Container(),
              hint: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: TitleHeading4Widget(
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                      text: moneyOutController.selectedCurrencyName.value,
                      fontSize: Dimensions.headingTextSize3,
                      color: CustomColor.whiteColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              isExpanded: false,
              borderRadius: BorderRadius.circular(Dimensions.radius),
              icon: const Icon(
                Icons.arrow_drop_down_rounded,
                color: CustomColor.whiteColor,
              ),
              items: moneyOutController.currencyList
                  .map<DropdownMenuItem<PaymentGateway>>(
                (value) {
                  return DropdownMenuItem<PaymentGateway>(
                    value: value,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 40.h,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(
                                        Assets.clipart.paypal.path))),
                          ),
                          // SizedBox(
                          //   width: Dimensions.widthSize * .75,
                          // ),
                          Text(
                            value.name,
                            style: TextStyle(
                              color: CustomColor.whiteColor,
                              fontSize: Dimensions.headingTextSize5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ).toList(),
              dropdownColor: CustomColor.primaryLightColor,
              onChanged: (value) {
                moneyOutController.selectedCurrencyName.value = value!.name;
                moneyOutController.currencyCode2.value =
                    value.currencies.first.currencyCode;
                moneyOutController.rate.value =
                    double.parse(value.currencies.first.rate);

                moneyOutController.percentCharge.value =
                    double.parse(value.currencies.first.percentCharge);

                moneyOutController.fixesCharge.value =
                    double.parse(value.currencies.first.fixedCharge);

                moneyOutController.limitMin.value =
                    double.parse(value.currencies.first.minLimit);
                moneyOutController.limitMax.value =
                    double.parse(value.currencies.first.maxLimit);
              },
            ),
          ],
        ),
      ),
    );
  }
}
