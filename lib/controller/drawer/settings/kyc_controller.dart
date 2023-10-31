import '../../../backend/model/authorization/kyc/kyc_model.dart';
import '../../../backend/model/common/common_success_model.dart';
import '../../../backend/services/api_services.dart';
import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/dropdown/kyc_dropdown.dart';
import '../../../widgets/image_picker/kyc_image_picker_widget.dart';

class UpdateKycController extends GetxController {
  List<TextEditingController> inputFieldControllers = [];
  List<String> listImagePath = [];
  List<String> listFieldName = [];
  String translatedFieldName = '';

  RxList inputFields = [].obs;
  RxList inputFileFields = [].obs;
  RxBool hasFile = false.obs;

  @override
  void onInit() {
    getKycData();
    super.onInit();
  }

  List<String> dropdownList = <String>[].obs;

  //creating bank name and code dropdowns
  RxString selectType = "".obs;

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  late KycModel _kycModelData;

  KycModel get kycModelData => _kycModelData;

  Future<KycModel> getKycData() async {
    inputFields.clear();
    inputFieldControllers.clear();
    _isLoading.value = true;
    update();

    // calling  from api service
    await ApiServices.getKycAPi().then((value) {
      _kycModelData = value!;

      final data = _kycModelData.data.inputFields;

      for (int item = 0; item < data.length; item++) {
        // make the dynamic controller
        var textEditingController = TextEditingController();
        inputFieldControllers.add(textEditingController);

        // make dynamic input widget
        if (data[item].type.contains('file')) {
          hasFile.value = true;
          inputFileFields.add(
            Column(
              crossAxisAlignment: crossStart,
              children: [
                TitleHeading4Widget(
                  text: data[item].label,
                  textAlign: TextAlign.left,
                  color: CustomColor.greyBlackColor,
                  fontSize: Dimensions.headingTextSize3,
                  fontWeight: FontWeight.w600,
                ),
                verticalSpace(Dimensions.heightSize),
                UpdateKycImageWidget(
                  labelName: data[item].label,
                  fieldName: data[item].name,
                ),
              ],
            ),
          );
        } else if (data[item].type.contains('text') ||
            data[item].type.contains('textarea')) {
          inputFields.add(
            Column(
              children: [
                verticalSpace(Dimensions.heightSize),
                PrimaryTextInputWidget(
                  controller: inputFieldControllers[item],
                  hintText: data[item].label,
                  labelText: data[item].label,
                ),
              ],
            ),
          );
        } // make dynamic input widget
        else if (data[item].type.contains('select')) {
          hasFile.value = true;
          selectType.value = data[item].validation.options.first.toString();
          inputFieldControllers[item].text = selectType.value;
          dropdownList = data[item].validation.options;
          inputFields.add(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Dimensions.marginBetweenInputTitleAndBox,
                ),
                CustomTitleHeadingWidget(
                  text: data[item].label,
                  style: CustomStyle.darkHeading4TextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    color: CustomColor.greyBlackColor,
                  ),
                ),
                SizedBox(
                  height: Dimensions.marginBetweenInputTitleAndBox,
                ),
                KycDynamicDropDown(
                  selectMethod: selectType,
                  itemsList: dropdownList,
                  onChanged: (value) {
                    selectType.value = value!;
                    inputFieldControllers[item].text = selectType.value;
                    debugPrint(selectType.value);
                  },
                ),
              ],
            ),
          );
        }
      }

      _isLoading.value = false;
      update();
    }).catchError(
      (onError) {
        log.e(onError);
      },
    );
    update();
    return _kycModelData;
  }

  final _isUpdateLoading = false.obs;

  bool get isUpdateLoading => _isUpdateLoading.value;

  late CommonSuccessModel _kycUpdateModel;

  CommonSuccessModel get kycUpdateModel => _kycUpdateModel;

  // Profile update process with image
  Future<CommonSuccessModel> kycSubmitProcess() async {
    _isUpdateLoading.value = true;
    update();

    Map<String, String> inputBody = {};
    final data = kycModelData.data.inputFields;

    for (int i = 0; i < data.length; i += 1) {
      if (data[i].type != 'file') {
        inputBody[data[i].name] = inputFieldControllers[i].text;
      }
    }

    await ApiServices.updateKYCApi(
            body: inputBody, fieldList: listFieldName, pathList: listImagePath)
        .then((value) {
      _kycUpdateModel = value!;
      Get.offAllNamed(Routes.dashboardScreen);
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isUpdateLoading.value = false;
    update();
    return _kycUpdateModel;
  }

  void gotoNavigation(BuildContext context) {
    Get.offAllNamed(Routes.dashboardScreen);
  }

  updateImageData(String fieldName, String imagePath) {
    if (listFieldName.contains(fieldName)) {
      int itemIndex = listFieldName.indexOf(fieldName);
      listImagePath[itemIndex] = imagePath;
    } else {
      listFieldName.add(fieldName);
      listImagePath.add(imagePath);
    }
    update();
  }

  String? getImagePath(String fieldName) {
    if (listFieldName.contains(fieldName)) {
      int itemIndex = listFieldName.indexOf(fieldName);
      return listImagePath[itemIndex];
    }
    return null;
  }
}
