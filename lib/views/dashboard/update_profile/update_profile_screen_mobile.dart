import 'package:crypinvest/widgets/gradient_container/gradient_container.dart';

import '../../../../controller/dashboard/update_profile/update_profile_controller.dart';
import '../../../backend/backend_utils/custom_loading_api.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/appbar/custom_app_bar.dart';
import '../../../widgets/dropdown/country_dropdown.dart';
import '../../../widgets/image_picker/profile_image_view.dart';
import 'package:iconsax/iconsax.dart';

class UpdateProfileScreenMobile extends StatelessWidget {
  UpdateProfileScreenMobile({super.key});

  final updateProfileFormKey = GlobalKey<FormState>();
  final controller = Get.put(UpdateProfileController());

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Scaffold(
        appBar: CustomAppBar(
          title: Strings.profile.tr,
          titleClr: CustomColor.primaryDarkColor,
          bgClr: CustomColor.transparentColor,
          elevation: 0.0,
          onTap: () => Get.back(),
        ),
        backgroundColor: CustomColor.transparentColor,
        body: Obx(
          () => controller.isLoading
              ? const CustomLoadingAPI()
              : _bodyWidget(context),
        ),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSize,
        vertical: Dimensions.paddingSize,
      ),
      physics: const BouncingScrollPhysics(),
      children: [
        _userImageWidget(context),
        _inputWidget(context),
        _buttonWidget(context),
      ],
    );
  }

  _userImageWidget(BuildContext context) {
    return Center(child: ImagePickerWidget());
  }

  _inputWidget(BuildContext context) {
    return Form(
      key: updateProfileFormKey,
      child: Padding(
        padding: EdgeInsets.only(top: Dimensions.paddingSize),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: PrimaryTextInputWidget(
                    keyboardType: TextInputType.emailAddress,
                    hintText: Strings.cornel.tr,
                    controller: controller.firstNameController,
                    borderColor: Get.isDarkMode
                        ? CustomColor.greyBlackColor.withOpacity(.15)
                        : CustomColor.greyBlackColor.withOpacity(.15),
                    color: Get.isDarkMode
                        ? CustomColor.greyBlackColor.withOpacity(.1)
                        : CustomColor.greyBlackColor.withOpacity(.1),
                    labelText: Strings.firstName,
                  ),
                ),
                horizontalSpace(Dimensions.paddingSize),
                Expanded(
                  flex: 1,
                  child: PrimaryTextInputWidget(
                    keyboardType: TextInputType.emailAddress,
                    hintText: Strings.arichart.tr,
                    controller: controller.lastNameController,
                    borderColor: Get.isDarkMode
                        ? CustomColor.greyBlackColor.withOpacity(.15)
                        : CustomColor.greyBlackColor.withOpacity(.15),
                    color: Get.isDarkMode
                        ? CustomColor.greyBlackColor.withOpacity(.1)
                        : CustomColor.greyBlackColor.withOpacity(.1),
                    labelText: Strings.lastName,
                  ),
                ),
              ],
            ),
            verticalSpace(Dimensions.paddingSize),
            PrimaryTextInputWidget(
              prefix: TitleHeading3Widget(
                padding: EdgeInsets.only(right: Dimensions.paddingSize * 0.2),
                text: controller.selectedCountryCode.value,
                color: CustomColor.primaryLightColor,
              ),
              keyboardType: TextInputType.number,
              hintText: Strings.dummyPhoneNumber.tr,
              controller: controller.phoneNumberController,
              borderColor: Get.isDarkMode
                  ? CustomColor.greyBlackColor.withOpacity(.15)
                  : CustomColor.greyBlackColor.withOpacity(.15),
              color: Get.isDarkMode
                  ? CustomColor.greyBlackColor.withOpacity(.1)
                  : CustomColor.greyBlackColor.withOpacity(.1),
              labelText: Strings.phoneNumber.tr,
            ),
            verticalSpace(Dimensions.heightSize * 1.2),
            Column(
              crossAxisAlignment: crossStart,
              children: [
                TitleHeading4Widget(
                  text: Strings.country,
                  color: CustomColor.greyBlackColor,
                  fontSize: Dimensions.headingTextSize3,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.left,
                  padding:
                      EdgeInsets.only(bottom: Dimensions.paddingSize * .25),
                ),
                CountryDropdownInputWidget(
                  selectMethod: controller.selectedCountry.isEmpty
                      ? controller.selectedCountry2
                      : controller.selectedCountry,
                  itemsList: controller.profileModel.data.countries,
                  hintText: Strings.selectCountry,
                  labelText: Strings.country,
                  iconData: Iconsax.global,
                  size: Dimensions.heightSize * 2,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  onChanged: (value) {
                    controller.selectedCountry.value = value!.name;
                    controller.selectedCountryCode.value = value.mobileCode;
                    printInfo(info: controller.selectedCountry.value);
                  },
                ),
              ],
            ),
            verticalSpace(Dimensions.heightSize * 1.5),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: PrimaryTextInputWidget(
                    hintText: Strings.enterCity.tr,
                    controller: controller.cityController,
                    borderColor: Get.isDarkMode
                        ? CustomColor.greyBlackColor.withOpacity(.15)
                        : CustomColor.greyBlackColor.withOpacity(.15),
                    color: Get.isDarkMode
                        ? CustomColor.greyBlackColor.withOpacity(.1)
                        : CustomColor.greyBlackColor.withOpacity(.1),
                    labelText: Strings.city,
                  ),
                ),
                horizontalSpace(Dimensions.paddingSize),
                Expanded(
                  flex: 1,
                  child: PrimaryTextInputWidget(
                    hintText: Strings.enterState.tr,
                    controller: controller.stateController,
                    borderColor: Get.isDarkMode
                        ? CustomColor.greyBlackColor.withOpacity(.15)
                        : CustomColor.greyBlackColor.withOpacity(.15),
                    color: Get.isDarkMode
                        ? CustomColor.greyBlackColor.withOpacity(.1)
                        : CustomColor.greyBlackColor.withOpacity(.1),
                    labelText: Strings.state,
                  ),
                ),
              ],
            ),
            verticalSpace(Dimensions.paddingSize),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: PrimaryTextInputWidget(
                    hintText: Strings.enterAddress.tr,
                    controller: controller.addressController,
                    borderColor: Get.isDarkMode
                        ? CustomColor.greyBlackColor.withOpacity(.15)
                        : CustomColor.greyBlackColor.withOpacity(.15),
                    color: Get.isDarkMode
                        ? CustomColor.greyBlackColor.withOpacity(.1)
                        : CustomColor.greyBlackColor.withOpacity(.1),
                    labelText: Strings.address,
                  ),
                ),
                horizontalSpace(Dimensions.paddingSize),
                Expanded(
                  flex: 1,
                  child: PrimaryTextInputWidget(
                    keyboardType: TextInputType.number,
                    hintText: Strings.enterZipCode.tr,
                    controller: controller.zipController,
                    borderColor: Get.isDarkMode
                        ? CustomColor.greyBlackColor.withOpacity(.15)
                        : CustomColor.greyBlackColor.withOpacity(.15),
                    color: Get.isDarkMode
                        ? CustomColor.greyBlackColor.withOpacity(.1)
                        : CustomColor.greyBlackColor.withOpacity(.1),
                    labelText: Strings.zipCode,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.paddingSize),
      child: Obx(
        () => controller.isUpdateLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
                title: Strings.updateProfile.tr,
                onPressed: () {
                  if (updateProfileFormKey.currentState!.validate()) {
                    if (controller.imageController.isImagePathSet.value) {
                      controller.profileUpdateWithImageProcess();
                    } else {
                      controller.profileUpdateWithOutImageProcess();
                    }
                  }
                },
                borderColor: Get.isDarkMode
                    ? CustomColor.primaryDarkColor
                    : CustomColor.primaryLightColor,
                buttonColor: Get.isDarkMode
                    ? CustomColor.primaryDarkColor
                    : CustomColor.primaryLightColor,
              ),
      ),
    );
  }
}
