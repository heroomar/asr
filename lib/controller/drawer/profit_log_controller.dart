
import '../../../../utils/basic_screen_imports.dart';
import '../../backend/model/drawer/profit_log_model.dart';
import '../../backend/services/api_services.dart';

class ProfitLogController extends GetxController {
  @override
  void onInit() {
    getProfitLogData();
    super.onInit();
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late ProfitLogModel _profitLogModel;
  ProfitLogModel get profitLogModel => _profitLogModel;

  Future<ProfitLogModel> getProfitLogData() async {
    _isLoading.value = true;
    update();

    await ApiServices.profitLogApi().then((value) {
      _profitLogModel = value!;
      update();

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
      _isLoading.value = false;
    });

    _isLoading.value = false;
    update();
    return _profitLogModel;
  }
}
