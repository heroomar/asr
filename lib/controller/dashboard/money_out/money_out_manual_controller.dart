import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

import '../../../backend/model/categories/withdraw/dynamic_input_withdraw_model.dart';
import '../../../backend/model/common/common_success_model.dart';
import '../../../backend/services/api_services.dart';
import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/dropdown/kyc_dropdown.dart';
import '../../../widgets/inputs/manual_input_field.dart';
import '../../../widgets/money_out/money_out_image_widget.dart';
import 'money_out_controller.dart';

class MoneyOutManualController extends GetxController {
  final controller = Get.put(MoneyOutController());
  final address = TextEditingController();

  RxString selectedWalletCode = Strings.numCode.obs;
  RxString selectedWallet = ''.obs;
  RxString selectedWallet2 = Strings.selectCountry.obs;



  List<TextEditingController> inputFieldControllers = [];
  List<String> listImagePath = [];
  List<String> listFieldName = [];
  RxList inputFields = [].obs;
  List<String> dropdownList = <String>[].obs;
  RxString selectType = "".obs;
  RxList inputFileFields = [].obs;
  RxBool hasFile = false.obs;

//! manual
  @override
  void onInit() {
    withdrawDynamicApi();
    super.onInit();
  }

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;
  late DynamicInputWithdrawModel _dynamicInputWithdrawModel;

  DynamicInputWithdrawModel get dynamicInputWithdrawModel =>
      _dynamicInputWithdrawModel;

  Future<DynamicInputWithdrawModel> withdrawDynamicApi() async {
    inputFields.clear();
    inputFieldControllers.clear();
    _isLoading.value = true;
    update();

    // calling  from api service
    await ApiServices.withdrawDynamicApi(controller.selectedCurrencyAlias.value)
        .then((value) {

      _dynamicInputWithdrawModel = value!;

      final data = _dynamicInputWithdrawModel.data.inputFields;

      for (int item = 0; item < data.length; item++) {
        // make the dynamic controller
        var textEditingController = TextEditingController();
        inputFieldControllers.add(textEditingController);

        // make dynamic input widget
        if (data[item].type.contains('file')) {
          hasFile.value = true;
          inputFields.add(
            Column(
              crossAxisAlignment: crossStart,
              children: [
                Text(
                  data[item].label,
                  style: CustomStyle.darkHeading4TextStyle.copyWith(
                    fontWeight: FontWeight.w500,
                    color: CustomColor.greyBlackColor,
                  ),
                ),
                verticalSpace(Dimensions.heightSize),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ManualImageWidget(
                    labelName: data[item].label,
                    fieldName: data[item].name,
                  ),
                ),
              ],
            ),
          );
        } else if (data[item].type.contains('text')) {
          inputFields.add(
            Column(
              children: [
                PrimaryInputWidget(
                  customPadding: EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSize * 0.6,
                      vertical: Dimensions.paddingSize * 0.6),
                  controller: inputFieldControllers[item],
                  label: data[item].label,
                  hintText: data[item].label,
                  isValidator: data[item].required,
                  isFilled: true,
                  autoFocus: true,
                  fillColor: CustomColor.primaryLightColor.withOpacity(.15),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(
                      int.parse(data[item].validation.max.toString()),
                    ),
                  ],
                ),
                verticalSpace(Dimensions.heightSize),
              ],
            ),
          );
        } // make dynamic input widget
        else if (data[item].type.contains('select')) {
          hasFile.value = true;
          selectType.value = data[item].validation.options.first.toString();
          inputFieldControllers[item].text = selectType.value;
          // dropdownList = data[item].validation.options;
          inputFields.add(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Dimensions.marginBetweenInputTitleAndBox,
                ),
                CustomTitleHeadingWidget(
                  text: data[item].label,
                  style: CustomStyle.darkHeading4TextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    color: CustomColor.primaryLightColor,
                  ),
                ),
                SizedBox(
                  height: Dimensions.marginBetweenInputTitleAndBox,
                ),
                KycDynamicDropDown(
                  selectMethod: selectType,
                  itemsList: dropdownList,
                  onChanged: (value) {
                    selectType.value = value!;
                    inputFieldControllers[item].text = selectType.value;
                    debugPrint(selectType.value);
                  },
                ),
              ],
            ),
          );
        }
      }

      _isLoading.value = false;
      update();
    }).catchError(
      (onError) {
        log.e(onError);
      },
    );
    update();
    return _dynamicInputWithdrawModel;
  }

//manual controller
  final _isUpdateLoading = false.obs;

  bool get isUpdateLoading => _isUpdateLoading.value;

  late CommonSuccessModel _kycUpdateModel;

  CommonSuccessModel get kycUpdateModel => _kycUpdateModel;

  // Profile update process with image
  Future<CommonSuccessModel> moneyOutSubmitProcess() async {
    _isUpdateLoading.value = true;
    update();

    Map<String, String> inputBody = {
      'address' : GetStorage().read("address"),
      'amount': controller.moneyOutAmountTextController.text,
      'payment_gateway': controller.paymentGateway.value,
      'wallet_type': GetStorage().read("wallet"),
    };
    debugPrint(inputBody.toString());

    final data = _dynamicInputWithdrawModel.data.inputFields;

    for (int i = 0; i < data.length; i += 1) {
      if (data[i].type != 'file') {
        inputBody[data[i].name] = inputFieldControllers[i].text;
      }
    }

    await ApiServices.withdrawSubmitApi(
            body: inputBody, fieldList: listFieldName, pathList: listImagePath)
        .then((value) {
      _kycUpdateModel = value!;
      Get.offAllNamed(Routes.moneyOutCongratulationScreen);
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isUpdateLoading.value = false;
    update();
    return _kycUpdateModel;
  }

  updateImageData(String fieldName, String imagePath) {
    if (listFieldName.contains(fieldName)) {
      int itemIndex = listFieldName.indexOf(fieldName);
      listImagePath[itemIndex] = imagePath;
    } else {
      listFieldName.add(fieldName);
      listImagePath.add(imagePath);
    }
    update();
  }

  String? getImagePath(String fieldName) {
    if (listFieldName.contains(fieldName)) {
      int itemIndex = listFieldName.indexOf(fieldName);
      return listImagePath[itemIndex];
    }
    return null;
  }
}
