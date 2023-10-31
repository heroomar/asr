import 'package:crypinvest/utils/basic_widget_imports.dart';

import '../../../backend/model/categories/invest_plane/my_investment_model.dart';
import '../../../backend/services/api_services.dart';

class MyInvestmentPlaneController extends GetxController{
  
  @override
  void onInit() {
    getMyInvestData();
    super.onInit();
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late MyInvestmentModel _myInvestmentModel;
  MyInvestmentModel get myInvestmentModel => _myInvestmentModel;

  Future<MyInvestmentModel> getMyInvestData() async {
    _isLoading.value = true;
    update();

    await ApiServices.myInvestmentApi().then((value) {
      _myInvestmentModel = value!;
      update();

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
      _isLoading.value = false;
    });

    _isLoading.value = false;
    update();
    return _myInvestmentModel;
  }
}