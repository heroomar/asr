import '../../../../utils/basic_screen_imports.dart';
import '../../../backend/backend_utils/custom_snackbar.dart';
import '../../../backend/model/categories/add_money/add_money_information_model.dart';
import '../../../backend/model/categories/add_money/coingate_model.dart';
import '../../../backend/model/categories/add_money/paypal_insert_model.dart';
import '../../../backend/services/api_services.dart';
import '../../../cryptoPart/contract/contract_function.dart';
import '../../../cryptoPart/contract/contract_service.dart';
 import '../../../cryptoPart/wallet_services/helpers/wallet_connect_helper_v2.dart';
import '../../../routes/routes.dart';
import '../../../cryptoPart/pages/CryptoPage.dart';

String? chainName;
String? walletAddress;

class AddMoneyController extends GetxController {
  final amountTextController = TextEditingController();

  RxString baseCurrency = "".obs;
  RxString paymentURl = "".obs;
  RxString appBarName = "".obs;
  RxString selectedCurrencyAlias = "".obs;
  RxString selectedCurrencyName = "Select Method".obs;
  RxString selectedCurrencyType = "".obs;
  RxString selectedGatewaySlug = "".obs;
  RxString currencyCode = "".obs;

  RxString gatewayTrx = "".obs;

  RxString isAutomaticGateway = "".obs;
  List<Currency> currencyList = [];
  List<String> baseCurrencyList = [];
  RxInt selectedCurrencyId = 0.obs;
  RxString currencyCodeForCharge = "".obs;
  RxDouble limitMin = 0.0.obs;
  RxDouble limitMax = 0.0.obs;
  RxDouble percentCharge = 0.0.obs;
  RxDouble rate = 0.0.obs;
  RxDouble paymentRate = 0.0.obs;
  RxDouble percentsCharge = 0.0.obs;
  RxDouble fixesCharge = 0.0.obs;
  RxDouble fees = 0.0.obs;
  RxDouble payable = 0.0.obs;
  RxString currencyCode2 = "".obs;
  RxDouble amount = 0.0.obs;
  RxDouble totalCharge = 0.0.obs;

  final depositMethod = TextEditingController();

  final cardNumberController = TextEditingController();
  final cardExpiryController = TextEditingController();
  final cardCVCController = TextEditingController();

  final cardHolderNameController = TextEditingController();
  final cardExpiryDateController = TextEditingController();
  final cardCvvController = TextEditingController();


  WalletConnectHelperV2? walletConnectHelper ;

  @override
  void onInit() {
    getAddMoneyPaymentGatewayData();
    amountTextController.text = '0.00';

    walletConnectHelper = WalletConnectHelperV2();
    super.onInit();
  }

  // api loading process indicator variable
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  late AddMoneyPaymentGatewayModel _addMoneyPaymentGatewayModel;

  AddMoneyPaymentGatewayModel get addMoneyPaymentGatewayModel =>
      _addMoneyPaymentGatewayModel;

  // --------------------------- Api function ----------------------------------
  // get addMoneyPaymentGateway data function
  Future<AddMoneyPaymentGatewayModel> getAddMoneyPaymentGatewayData() async {
    _isLoading.value = true;
    update();

    await ApiServices.addMoneyPaymentGatewayAPi().then((value) {
      _addMoneyPaymentGatewayModel = value!;

      currencyCode.value = _addMoneyPaymentGatewayModel
          .data.paymentGateways.first.currencies.first.currencyCode;

      for (var gateways in _addMoneyPaymentGatewayModel.data.paymentGateways) {
        for (var currency in gateways.currencies) {
          currencyList.add(
            Currency(
              id: currency.id,
              paymentGatewayId: currency.paymentGatewayId,
              name:
                  currency.name == 'Paypal USD' ? 'Paypal ASR' : currency.name,
              alias: currency.alias,
              currencyCode: currency.currencyCode,
              currencySymbol: currency.currencySymbol,
              minLimit: currency.minLimit,
              maxLimit: currency.maxLimit,
              percentCharge: currency.percentCharge,
              fixedCharge: currency.fixedCharge,
              rate: currency.rate,
              createdAt: currency.createdAt,
              updatedAt: currency.updatedAt,
              image: currency.image,
            ),
          );
        }
      }

      Currency currency = _addMoneyPaymentGatewayModel
          .data.paymentGateways.first.currencies.first;
      PaymentGateway gateway =
          _addMoneyPaymentGatewayModel.data.paymentGateways.first;

      selectedCurrencyAlias.value = currency.alias;
      selectedGatewaySlug.value = gateway.name;
      selectedCurrencyId.value = currency.id;
      selectedCurrencyName.value =
          currency.name == 'Paypal USD' ? 'Paypal ASR' : currency.name;
      currencyCodeForCharge.value = currency.currencyCode;
      isAutomaticGateway.value =
          _addMoneyPaymentGatewayModel.data.paymentGateways.first.type;

      currencyCode2.value = _addMoneyPaymentGatewayModel
          .data.paymentGateways.first.currencies.first.currencyCode;
      //calculate
      limitMin.value = double.parse(currency.minLimit);
      limitMax.value = double.parse(currency.maxLimit);
      fixesCharge.value = double.parse(currency.fixedCharge);
      percentCharge.value = double.parse(currency.percentCharge);
      rate.value = double.parse(currency.rate);
      // paymentRate.value = double.parse(g);

      //Base Currency
      baseCurrency.value = _addMoneyPaymentGatewayModel
          .data.paymentGateways.first.currencies.first.currencyCode;
      baseCurrencyList.add(baseCurrency.value);

      _isLoading.value = false;
      update();
      update();
    }).catchError((onError) {
      log.e(onError);
      _isLoading.value = false;
      update();
    });

    return _addMoneyPaymentGatewayModel;
  }

  // ---------------------------- AddMoneyPaypalInsertModel --------------------
//!paypal
  final _isInsertLoading = false.obs;

  bool get isInsertLoading => _isInsertLoading.value;

  late AddMoneyPaypalInsertModel _addMoneyInsertPaypalModel;

  AddMoneyPaypalInsertModel get addMoneyInsertPaypalModel =>
      _addMoneyInsertPaypalModel;

  // --------------------------- Api function ----------------------------------
  // add money paypal
  Future<AddMoneyPaypalInsertModel> addMoneyPaypalInsertProcess() async {
    _isInsertLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'amount': amountTextController.text,
      'currency': selectedCurrencyType.value,
    };

    await ApiServices.paypalInsertApi(body: inputBody).then((value) {
      _addMoneyInsertPaypalModel = value!;

      final data = addMoneyInsertPaypalModel.data.redirectLinks;
      for (int i = 0; i < data.length; i++) {
        if (data[i].rel.contains('approve')) {
          paymentURl.value = data[i].href;
        }
      }
      appBarName.value = Strings.paypal;

      Get.toNamed(Routes.paypalWebPaymentScreen);
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isInsertLoading.value = false;
    update();
    return _addMoneyInsertPaypalModel;
  }

//! coin gate
  late CoinGateModel _coinGateModel;

  CoinGateModel get coinGateModel => _coinGateModel;

  // add money coin gate
  Future<CoinGateModel> coinGateProcess() async {
    _isInsertLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'amount': amountTextController.text,
      'currency': selectedCurrencyType.value,
    };

    await ApiServices.coinGateInsertApi(body: inputBody).then((value) {
      _coinGateModel = value!;

      paymentURl.value = coinGateModel.data.redirectUrl;
      appBarName.value = Strings.coinGate;
      Get.toNamed(Routes.paypalWebPaymentScreen);
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isInsertLoading.value = false;
    update();
    return _coinGateModel;
  }




//addMoney button
  //TODO:Create send Crypto Money
  goToAddMoneyPreviewScreen() async {
    if (amountTextController.text.isNotEmpty)
    {
      print("walletAddressw $walletAddress");
      print("select more tha 1");
      if (walletAddress != null) {
        await ContractFunctions()
            .sendErc20Token(double.parse(amountTextController.text),walletConnectHelper);
      } else {
        print("2222222 at wallet connet direct");
         walletConnectHelper!.onWalletConnect().then((value) async {
          if (value != null) {
            chainName = walletConnectHelper!.chain.chainId.split(':')[0];
            walletAddress = value;
          } else {
            print("wallet connect null now");
          }
        });
      }
    } else {
      print("Enpity value of token");
      CustomSnackBar.error(Strings.pleaseFillOutTheField);
    }
  }

  goToAddMoneyCongratulationScreen() {
    Get.toNamed(Routes.addMoneyCongratulationScreen);
  }

//! input fields

  List<String> totalAmount = [];

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
            amountTextController.text = totalAmount.join('');
          } else {
            return;
          }
        }
      },
      onTap: () {
        if (index == 11) {
          if (totalAmount.isNotEmpty) {
            totalAmount.removeLast();
            amountTextController.text = totalAmount.join('');
          } else {
            return;
          }
        } else {
          if (totalAmount.contains('.') && index == 9) {
            return;
          } else {
            totalAmount.add(keyboardItemList[index]);
            amountTextController.text = totalAmount.join('');
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
