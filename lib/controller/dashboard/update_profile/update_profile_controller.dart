import '../../../../utils/basic_screen_imports.dart';
import '../../../backend/model/common/common_success_model.dart';
import '../../../backend/model/profile/profile_model.dart';
import '../../../backend/services/api_services.dart';
import '../../../routes/routes.dart';
import '../../../widgets/image_picker/profile_image_view.dart';

class UpdateProfileController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final addressController = TextEditingController();
  final zipController = TextEditingController();

  final imageController = Get.put(InputImageController());

  RxString selectedCountryCode = Strings.numCode.obs;
  RxString selectedCountry = ''.obs;
  RxString selectedCountry2 = Strings.selectCountry.obs;

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  late ProfileModel _profileModel;

  ProfileModel get profileModel => _profileModel;

  Future<ProfileModel> getProfile() async {
    _isLoading.value = true;
    update();
    await ApiServices.profileApi().then((value) {
      _profileModel = value!;
      final data = _profileModel.data.userInfo;
      firstNameController.text = data.firstname;
      lastNameController.text = data.lastname;
      addressController.text = data.address;
      cityController.text = data.city;
      stateController.text = data.state;
      zipController.text = data.postalCode;
      if (data.mobileCode != null) {
        selectedCountryCode.value = data.mobileCode;
      }
      if (data.mobile != null) {
        phoneNumberController.text = data.mobile;
      }
      selectedCountry.value = data.country;


      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _profileModel;
  }

  final _isUpdateLoading = false.obs;

  bool get isUpdateLoading => _isUpdateLoading.value;
  late CommonSuccessModel _profileUpdateModel;

  CommonSuccessModel get profileUpdateModel => _profileUpdateModel;

  // --------------------------- Api function ----------------------------------
  // Profile update process without image
  Future<CommonSuccessModel> profileUpdateWithOutImageProcess() async {
    _isUpdateLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'firstname': firstNameController.text,
      'lastname': lastNameController.text,
      'country': selectedCountry.value,
      'mobile_code': selectedCountryCode.value,
      'mobile': phoneNumberController.text,
      'state': stateController.text,
      'postal_code': zipController.text,
      'address': addressController.text,
      'city': cityController.text,
    };

    await ApiServices.updateProfileWithoutImageApi(body: inputBody)
        .then((value) {
      _profileUpdateModel = value!;
      Get.offAllNamed(Routes.dashboardScreen);
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isUpdateLoading.value = false;
    update();
    return _profileUpdateModel;
  }

  // Profile update process with image
  Future<CommonSuccessModel> profileUpdateWithImageProcess() async {
    _isUpdateLoading.value = true;
    update();

    Map<String, String> inputBody = {
      'firstname': firstNameController.text,
      'lastname': lastNameController.text,
      'country': selectedCountry.value,
      'mobile_code': selectedCountryCode.value,
      'mobile': phoneNumberController.text,
      'state': stateController.text,
      'postal_code': zipController.text,
      'address': addressController.text,
      'city': cityController.text,
    };

    await ApiServices.updateProfileWithImageApi(
      body: inputBody,
      filepath: imageController.imagePath.value,
    ).then((value) {
      _profileUpdateModel = value!;
      Get.offAllNamed(Routes.dashboardScreen);

      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isUpdateLoading.value = false;
    update();
    return _profileUpdateModel;
  }
}
