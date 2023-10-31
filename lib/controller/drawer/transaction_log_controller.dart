import '../../../../utils/basic_screen_imports.dart';
import '../../backend/model/drawer/transaction_log_model.dart';
import '../../backend/services/api_services.dart';

class TransactionLogController extends GetxController{
  
  @override
  void onInit() {
    getTransactionData();
    super.onInit();
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late TransactionModel _transactionModel;
  TransactionModel get transactionModel => _transactionModel;

  Future<TransactionModel> getTransactionData() async {
    _isLoading.value = true;
    update();

    await ApiServices.transactionApi().then((value) {
      _transactionModel = value!;
      update();

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
      _isLoading.value = false;
    });

    _isLoading.value = false;
    update();
    return _transactionModel;
  }
}