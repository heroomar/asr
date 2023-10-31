import 'package:crypinvest/backend/model/dashbaord/dashboard_model.dart';
import 'package:crypinvest/utils/basic_widget_imports.dart';
import '../../../backend/services/api_services.dart';
import '../../backend/local_storage/local_storage.dart';
import '../../backend/services/api_endpoint.dart';


class DashboardController extends GetxController {
  List<Statistic> addMoneyData = [];
  List<Statistic> moneyOutData = [];
  @override
  void onInit() {
    getDashboardData();
    super.onInit();
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late DashboardModel _dashboardModel;
  DashboardModel get dashboardModel => _dashboardModel;

  Future<DashboardModel> getDashboardData() async {
    _isLoading.value = true;
    update();



    await ApiServices.dashboardAPi().then((value) {
      _dashboardModel = value!;

      for (var element in _dashboardModel.data.chartData.addMoneyStatistics) {
        addMoneyData.add(
          Statistic(
            timestamp: element.timestamp,
            value: element.value,
          ),
        );
      }
      for (var element in _dashboardModel.data.chartData.moneyOutStatistics) {
        moneyOutData.add(
          Statistic(
            timestamp: element.timestamp,
            value: element.value,
          ),
        );
      }
      _getLocalStorage();
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
      _isLoading.value = false;
    });

    _isLoading.value = false;
    update();
    return _dashboardModel;
  }

  void _getLocalStorage() {
    var data = _dashboardModel.data.userInfo;

    var image = data.image;
    var userImage = "";

    LocalStorage.saveEmail(email: data.email.toString());

    LocalStorage.saveUsername(userName: data.username.toString());

    if (image == null) {
      userImage =
          "${ApiEndpoint.mainDomain}/${_dashboardModel.data.profileImagePaths.defaultImage}";

      LocalStorage.saveImage(image: userImage);
    } else {
      userImage =
          "${ApiEndpoint.mainDomain}/${_dashboardModel.data.profileImagePaths.pathLocation}/$image";
      LocalStorage.saveImage(image: userImage);
    }
  }
}
