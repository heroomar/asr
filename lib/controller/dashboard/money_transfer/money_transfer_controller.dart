import 'package:crypinvest/backend/local_storage/local_storage.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../backend/model/categories/money_transfer/money_transfer_wallet_model.dart';
import '../../../backend/model/common/common_success_model.dart';
import '../../../backend/services/api_services.dart';

class MoneyTransferController extends GetxController {
  final receiverEmailAddressController = TextEditingController();
  final sendingAmountController = TextEditingController();
  RxString currencyCode = "".obs;
  RxDouble fees = 0.0.obs;
  RxDouble amount = 0.0.obs;

  @override
  void onInit() {
    getTransferMoney();

    super.onInit();
  }

// get wallet
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  late MoneyTransferWallet _moneyTransferWallet;

  MoneyTransferWallet get moneyTransferWallet => _moneyTransferWallet;

  Future<MoneyTransferWallet> getTransferMoney() async {
    _isLoading.value = true;
    update();
    await ApiServices.transferMoneyWalletApi().then((value) {
      _moneyTransferWallet = value!;
      currencyCode.value =
          moneyTransferWallet.data.userWallets.first.currency.code;
      LocalStorage.saveAppLogo(
          image: moneyTransferWallet.data.userWallets.first.currency.code);
     
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _moneyTransferWallet;
  }

//!todo transfer submit
  final _isUpdateLoading = false.obs;

  bool get isUpdateLoading => _isUpdateLoading.value;
  late CommonSuccessModel _transferSubmit;

  CommonSuccessModel get transferSubmit => _transferSubmit;

  Future<CommonSuccessModel> transferProcess() async {
    _isUpdateLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'sender_amount': amount.value.toString(),
      'receiver': receiverEmailAddressController.text,
    };
    await ApiServices.transferMoneySubmitApi(body: inputBody).then((value) {
      _transferSubmit = value!;

      _goToMoneyTransferCongratulationScreen();
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isUpdateLoading.value = false;
    update();
    return _transferSubmit;
  }

  goToMoneyTransferPreviewScreen() {
       amount.value =
        double.parse(sendingAmountController.text);
    double rate = double.parse(
        moneyTransferWallet.data.userWallets.first.currency.rate);

    //convert percent Charge  to double
    double percentCharge = amount.toDouble() /
        100 *
        double.parse(moneyTransferWallet.data.charges.percentCharge);
    //convert fixed Charge  to double
    double fixedCharge = rate *
        double.parse(moneyTransferWallet.data.charges.fixedCharge);
//fees here calculation
    fees.value = percentCharge + fixedCharge;
    Get.toNamed(Routes.moneyTransferPreviewScreen);
  }

  _goToMoneyTransferCongratulationScreen() {
    Get.toNamed(Routes.moneyTransferCongratulationScreen);
  }
  

}
