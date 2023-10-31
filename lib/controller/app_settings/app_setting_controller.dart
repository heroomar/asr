import '../../backend/local_storage/local_storage.dart';
import '../../backend/model/auth/basic_setting_model.dart';
import '../../backend/services/api_endpoint.dart';
import '../../backend/services/api_services.dart';
import '../../utils/basic_screen_imports.dart';

class AppSettingsController extends GetxController {
  RxString splashImagePath = ''.obs;
  RxString languageMethod = "".obs;
  List<Language> languageList = [];
  @override
  void onInit() {
    getAppSettingsData();
    super.onInit();
  }

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  late BasicSettingModel _appSettingsModel;

  BasicSettingModel get appSettingsModel => _appSettingsModel;

  Future<BasicSettingModel> getAppSettingsData() async {
    _isLoading.value = true;
    update();
    await ApiServices.basicSettingApi().then((value) {
      _appSettingsModel = value!;
      saveInfo();
      //dropdown
      languageMethod.value = appSettingsModel.data.languages.first.code;
      LocalStorage.saveCurrencySymbol(
          symbol: appSettingsModel.data.baseCur.symbol);
      for (var language in _appSettingsModel.data.languages) {
        languageList.add(
          Language(
            id: language.id,
            name: language.name,
            code: language.code,
            status: language.status,
          ),
        );
      }

      update();
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
      _isLoading.value = false;
    });
    _isLoading.value = false;
    update();
    return _appSettingsModel;
  }

  void saveInfo() {
    //splash image save
    var imageSplash = _appSettingsModel.data.splashScreen.image;
    var imagePath = _appSettingsModel.data.appImagePaths.pathLocation;
    LocalStorage.saveSplashScreenImage(
        image: "${ApiEndpoint.mainDomain}/$imagePath/$imageSplash");

    //onboard
    //onboard image,title,subtile
    var imageOnboard = _appSettingsModel.data.onboardScreens.first.image;
    var onboardText = _appSettingsModel.data.onboardScreens.first;
    LocalStorage.saveOnboardScreenImage(
        image: "${ApiEndpoint.mainDomain}/$imagePath/$imageOnboard");
    LocalStorage.saveOnBoardTitle(title: onboardText.title);
    LocalStorage.saveOnBoardSubTitle(subTitle: onboardText.subTitle);

    //logo
    var appSiteLogo = _appSettingsModel.data.basicSettings.siteFav;
    var appLogo = _appSettingsModel.data.basicSettings.siteLogo;
    var appImagePath = _appSettingsModel.data.imagePaths.pathLocation;
    LocalStorage.saveAppLogo(
        image: "${ApiEndpoint.mainDomain}/$appImagePath/$appSiteLogo");
    LocalStorage.saveAppSiteLogo(
        image: "${ApiEndpoint.mainDomain}/$appImagePath/$appLogo");

    //url link
    var data = _appSettingsModel.data.webLinks;
    LocalStorage.savePrivacyPolicyLink(
        link: 'https://asrcoin.io/link/privacy-policy');
    LocalStorage.saveAboutUsLink(link: 'https://asrcoin.io/about');
    LocalStorage.saveContactUs(link: 'https://asrcoin.io/contact');

    //get currency
    var currency = _appSettingsModel.data.baseCur.code;
    LocalStorage.saveBaseCurrency(currency: 'ASR');
  }
}
