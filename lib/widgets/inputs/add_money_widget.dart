import 'dart:io';
import 'package:crypinvest/backend/local_storage/local_storage.dart';
import 'package:flutter/services.dart';
import '../../../../controller/dashboard/add_money/add_money_controller.dart';
import '../../../../widgets/text_labels/title_heading5_widget.dart';
import '../../backend/model/categories/add_money/add_money_information_model.dart';
import '../../custom_assets/assets.gen.dart';
import '../../utils/basic_screen_imports.dart';

class AddMoneyWidget extends StatelessWidget {
  AddMoneyWidget({
    Key? key,
    required this.buttonText,
    required this.onTap,
    // required this.isLoading,
  }) : super(key: key);
  final String buttonText;
  final VoidCallback onTap;
  // final RxBool isLoading;
  final controller = Get.put((AddMoneyController()));

  @override
  Widget build(BuildContext context) {
    return _bodyWidget(context);
  }

  _bodyWidget(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.center,


        children: [
          _inputFieldWidget(context),
          _limitWidget(context),
          // _walletDropDownWidget(context),
          _customNumKeyBoardWidget(context),
          Padding(
            padding: const EdgeInsets.only(right: 18.0,left: 18,top: 10),
            child:  Center(child: Column(
              children: [
                Text("Please confirm your metamask is open and you are at correct network 'Binance Net' ",style: TextStyle(color: Colors.redAccent,fontSize: 16),textAlign: TextAlign.center,),

              ],
            )),
          ),
          _buttonWidget(context)
        ],
      ),
    );
  }

  _inputFieldWidget(BuildContext context) {
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
                    controller: controller.amountTextController,
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
                SizedBox(width: Dimensions.widthSize * 0.5),
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
          controller.keyboardItemList.length,
          (index) {
            return controller.inputItem(index);
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

          TitleHeading2Widget(
            text: "ASR",
            color: CustomColor.whiteColor,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  _limitWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: mainCenter,
      children: [
        TitleHeading5Widget(
          textAlign: TextAlign.center,
          text:
              "${Strings.limit} ${controller.limitMin.value.toStringAsFixed(2)} ${LocalStorage.getBaseCurrency()!} - ${controller.limitMax.value.toStringAsFixed(2)} ${LocalStorage.getBaseCurrency()!} ",
          color: Colors.transparent,
        ),
        // verticalSpace(Dimensions.heightSize * 0.5),
        TitleHeading5Widget(
          color: Colors.transparent,
          textAlign: TextAlign.center,
          text:
              "${Strings.rate} ${1.00} ${LocalStorage.getBaseCurrency()} - ${double.parse(controller.rate.toStringAsFixed(2))} ${LocalStorage.getBaseCurrency()!}",
        ),
      ],
    );
  }

  _walletDropDownWidget(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: Dimensions.marginSizeVertical * 1.3),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: Dimensions.buttonHeight * 0.70,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSize * .5,
                vertical: Dimensions.paddingSize * 0.2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius * 3),
                color: CustomColor.primaryLightColor),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton(
                  menuMaxHeight: 500.h,
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                  underline: Container(),
                  hint: Row(
                    children: [
                      // ClipRRect(
                      //   borderRadius:
                      //       BorderRadius.circular(Dimensions.radius * 1.2),
                      //   child: CircleAvatar(
                      //     radius: 18,
                      //     backgroundColor:
                      //         CustomColor.whiteColor.withOpacity(0.9),
                      //     child: CustomImageWidget(
                      //       path: Assets.clipart.paypal.path,
                      //       height: Dimensions.heightSize * 2,
                      //       width: Dimensions.widthSize * 1.8,
                      //     ),
                      //   ),
                      // ),
                      SizedBox(width: Dimensions.widthSize * 0.5),
                      Obx(
                        () => SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.34,
                          child: TitleHeading4Widget(
                            maxLines: 1,
                            textOverflow: TextOverflow.ellipsis,
                            text: controller.selectedCurrencyName.value,
                            fontSize: Dimensions.headingTextSize2,
                            color: CustomColor.whiteColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down_rounded,
                    color: CustomColor.whiteColor,
                  ),
                  items:
                      controller.currencyList.map<DropdownMenuItem<Currency>>(
                    (value) {
                      return DropdownMenuItem<Currency>(
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
                              SizedBox(width: Dimensions.widthSize * 1),
                              Text(
                                value.name,
                                style: TextStyle(
                                  color: CustomColor.whiteColor,
                                  fontSize: Dimensions.headingTextSize4,
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
                    controller.selectedCurrencyName.value = value!.name;
                    controller.selectedCurrencyType.value = value.alias;
                    LocalStorage.saveAlias(alias: value.alias);
                    controller.currencyCode2.value = value.currencyCode;
                    controller.rate.value = double.parse(value.rate);

                    controller.percentCharge.value =
                        (double.parse(value.percentCharge));

                    controller.fixesCharge.value =
                        double.parse(value.fixedCharge);

                    controller.limitMin.value = double.parse(value.minLimit);
                    controller.limitMax.value = double.parse(value.maxLimit);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
