import 'package:crypinvest/utils/basic_screen_imports.dart';
import '../../../backend/model/categories/invest_plane/invest_plane_model.dart';
import '../../../backend/model/common/common_success_model.dart';
import '../../../backend/services/api_services.dart';
import '../../../routes/routes.dart';
import '../../../views/congratulation/congratulation_screen.dart';

class InvestmentController extends GetxController {
  final amountController = TextEditingController();
  RxBool isSelected = true.obs;

  RxString slug = "".obs;
  RxString maxInvest = "".obs;
  RxString minProfit = "".obs;
  RxString minInvestOffer = "".obs;
  RxString profitReturn = "".obs;

  @override
  void onInit() {
    getMyInvestData();
    super.onInit();
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late InvestPlaneModel _investPlaneModel;
  InvestPlaneModel get investPlaneModel => _investPlaneModel;

  Future<InvestPlaneModel> getMyInvestData() async {
    _isLoading.value = true;
    update();

    await ApiServices.investPlaneApi().then((value) {
      _investPlaneModel = value!;
      update();

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
      _isLoading.value = false;
    });

    _isLoading.value = false;
    update();
    return _investPlaneModel;
  }

//!todo purchase plan submit
  final _isPurchaseLoading = false.obs;

  bool get isPurchaseLoading => _isPurchaseLoading.value;
  late CommonSuccessModel _purchasePlan;

  CommonSuccessModel get purchasePlan => _purchasePlan;

  Future<CommonSuccessModel> investPurchaseProcess() async {
    _isPurchaseLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'invest_amount': amountController.text,
    };
    await ApiServices.planPurchaseAPi(body: inputBody,).then((value) {
      _purchasePlan = value!;
      _gotoCongratulation(purchasePlan);
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isPurchaseLoading.value = false;
    update();
    return _purchasePlan;
  }

  void _gotoCongratulation(purchasePlan) {
    Get.to(
      () => const CongratulationScreen(
        route: Routes.myInvestScreen,
        subTitle: Strings.myInvestCongratulation,
      ),
    );
  }
}
