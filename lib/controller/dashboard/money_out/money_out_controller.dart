
import 'package:crypinvest/backend/backend_utils/custom_snackbar.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../backend/model/categories/withdraw/withdraw_info_model.dart';
import '../../../backend/services/api_services.dart';
import '../../../routes/routes.dart';

class MoneyOutController extends GetxController {
  final moneyOutAmountTextController = TextEditingController();

  RxString selectedCurrencyAlias = "".obs;
  RxString selectedCurrencyName = "".obs;
  RxString selectedCurrencyType = "".obs;
  RxString selectedGatewaySlug = "".obs;
  RxString currencyCode = "".obs;
  RxString gatewayTrx = "".obs;
  RxInt selectedCurrencyId = 0.obs;
  RxDouble limitMin = 0.0.obs;
  RxDouble limitMax = 0.0.obs;
  RxDouble percentCharge = 0.0.obs;
  RxDouble percentsCharge = 0.0.obs;
  RxDouble rate = 0.0.obs;
  RxDouble fixesCharge = 0.0.obs;
  RxDouble fees = 0.0.obs;
  RxDouble payable = 0.0.obs;
  RxString currencyCode2 = "".obs;
  RxDouble amount = 0.0.obs;
  RxDouble totalCharge = 0.0.obs;
  RxDouble willGet = 0.0.obs;
  //dynamic dropdown
  RxString paymentGateway = "".obs;
  RxString dropdownName = "".obs;
  RxString dropdownValue = "".obs;

  List<PaymentGateway> currencyList = [];
  List<String> baseCurrencyList = [];
  List<String> totalAmount = [];
  //dropdown
  List<String> dropdownList = <String>[].obs;
  RxString selectType = "".obs;
  List<TextEditingController> inputFieldControllers = [];
  RxList inputFields = [].obs;
  RxBool hasFile = false.obs;

  @override
  void dispose() {
    moneyOutAmountTextController.dispose();

    super.dispose();
  }

  @override
  void onInit() {
    getMoneyOutData();
    moneyOutAmountTextController.text = '0.0';
    super.onInit();
  }

// get wallet
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  late WithdrawInfoModel _withdrawInfoModel;

  WithdrawInfoModel get withdrawInfoModel => _withdrawInfoModel;

  Future<WithdrawInfoModel> getMoneyOutData() async {
    _isLoading.value = true;
    update();
    await ApiServices.withdrawInfoApi().then((value) {
      _withdrawInfoModel = value!;

      currencyCode.value = _withdrawInfoModel
          .data.paymentGateways.first.currencies.first.currencyCode;
      selectedCurrencyName.value =
          _withdrawInfoModel.data.paymentGateways.first.name;
      for (var gateways in _withdrawInfoModel.data.paymentGateways) {
        currencyList.add(
          PaymentGateway(
            id: gateways.id,
            name: gateways.name,
            alias: gateways.alias,
            type: gateways.name,
            currencies: gateways.currencies,
            status: gateways.status,
          ),
        );
      }

      PaymentGateway gateways = _withdrawInfoModel.data.paymentGateways.first;
      CurrencyElement currency =
          _withdrawInfoModel.data.paymentGateways.first.currencies.first;
      selectedCurrencyAlias.value = currency.alias;
      selectedCurrencyType.value = gateways.type;
      paymentGateway.value = gateways.alias;
      currencyCode.value = currency.currencyCode;
      selectedCurrencyId.value = currency.id;
      selectedCurrencyName.value = gateways.name;
      percentCharge.value = double.parse(currency.percentCharge);
      limitMin.value = double.parse(currency.minLimit);
      limitMax.value = double.parse(currency.maxLimit);
      currencyCode2.value = currency.currencyCode;
      rate.value = double.parse(currency.rate);

      dropdownName.value = _withdrawInfoModel.data.balanceType.types.first.name;
      dropdownValue.value =
          _withdrawInfoModel.data.balanceType.types.first.value;
      _isLoading.value = false;

      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _withdrawInfoModel;
  }

  goToMoneyOutPreviewScreen() {
    Get.toNamed(Routes.moneyOutPreviewScreen);
  }

  void gotoManualScreen() {
    if (moneyOutAmountTextController.text.isNotEmpty) {
      amount.value = double.parse(moneyOutAmountTextController.text);

      percentsCharge.value = (((amount.value * rate.value) / 100) *
          percentCharge.value /
          rate.value);

      totalCharge.value = fixesCharge.value + percentsCharge.value;
      willGet.value = amount.value + totalCharge.value;
      payable.value = amount.value * rate.value;

      if (limitMin.value <= amount.value && limitMax.value >= amount.value) {
        Get.toNamed(Routes.moneyOutManualPaymentScreen);
      } else {
        CustomSnackBar.error(Strings.pleaseFollowTheLimit);
      }
    } else {
      CustomSnackBar.error(Strings.pleaseFillOutTheField);
    }
  }

  goToMoneyOutCongratulationScreen() {
    Get.toNamed(Routes.moneyOutCongratulationScreen);
  }

//
  RxString selectItem = ''.obs;
  List<String> keyboardItemList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '.',
    '0',
    '<'
  ];

  inputItem(int index) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onLongPress: () {
        if (index == 11) {
          if (totalAmount.isNotEmpty) {
            totalAmount.clear();
            moneyOutAmountTextController.text = totalAmount.join('');
          } else {
            return;
          }
        }
      },
      onTap: () {
        if (index == 11) {
          if (totalAmount.isNotEmpty) {
            totalAmount.removeLast();
            moneyOutAmountTextController.text = totalAmount.join('');
          } else {
            return;
          }
        } else {
          if (totalAmount.contains('.') && index == 9) {
            return;
          } else {
            totalAmount.add(keyboardItemList[index]);
            moneyOutAmountTextController.text = totalAmount.join('');
            debugPrint(totalAmount.join(''));
          }
        }
      },
      child: Center(
        child: CustomTitleHeadingWidget(
          text: keyboardItemList[index],
          style: Get.isDarkMode
              ? CustomStyle.lightHeading2TextStyle.copyWith(
                  fontSize: Dimensions.headingTextSize3 * 2,
                )
              : CustomStyle.darkHeading2TextStyle.copyWith(
                  color: CustomColor.primaryLightColor,
                  fontSize: Dimensions.headingTextSize3 * 2,
                ),
        ),
      ),
    );
  }
}
