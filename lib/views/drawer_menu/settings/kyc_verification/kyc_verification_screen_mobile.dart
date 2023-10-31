import 'package:crypinvest/extensions/context_ext.dart';
import 'package:crypinvest/widgets/gradient_container/gradient_container.dart';

import '../../../../backend/backend_utils/custom_loading_api.dart';
import '../../../../controller/dashboard/update_profile/update_profile_controller.dart';
import '../../../../controller/drawer/settings/kyc_controller.dart';
import '../../../../utils/basic_widget_imports.dart';
import '../../../../widgets/appbar/custom_app_bar.dart';
import '../../../../widgets/buttons/primary_button.dart';

class KYCVerificationScreenMobile extends StatelessWidget {
  KYCVerificationScreenMobile({super.key});

  final controller = Get.put(UpdateKycController());
  final controllerProfile = Get.put(UpdateProfileController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Scaffold(
        appBar: CustomAppBar(
          title: Strings.kycVerification.tr,
          titleClr: CustomColor.primaryDarkColor,
          bgClr: CustomColor.transparentColor,
          elevation: 0.0,
          onTap: () => Get.back(),
        ),
        body: Obx(
          () => controller.isLoading
              ? const CustomLoadingAPI()
              : _bodyWidget(context),
        ),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    var status = controller.kycModelData.data.status;
    var text = controller.kycModelData.message.success.first;
    return Padding(
      padding: EdgeInsets.all(Dimensions.paddingSize * 0.5),
      child: Column(children: [
        status == 2
            ? Container(
                decoration: BoxDecoration(
                    color: CustomColor.primaryLightColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius)),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSize,
                    horizontal: Dimensions.paddingSize * 1.5),
                child: TitleHeading4Widget(
                  text: text,
                  color: CustomColor.greyBlackColor,
                ),
              )
            : status == 1
                ? Container(
                    decoration: BoxDecoration(
                        color: CustomColor.primaryLightColor,
                        borderRadius: BorderRadius.circular(Dimensions.radius)),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSize,
                        horizontal: Dimensions.paddingSize * 1.5),
                    child: TitleHeading4Widget(
                      text: text,
                      color: CustomColor.greyBlackColor,
                    ),
                  )
                : Visibility(
                    visible: controller.inputFileFields.isNotEmpty,
                    child: SizedBox(
                      height: context.h * 0.21,
                      child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of columns in the grid
                            crossAxisSpacing: 10.0, // Spacing between columns
                            mainAxisSpacing: 10.0, // Spacing between rows
                          ),
                          itemCount: controller.inputFileFields.length,
                          // Number of items in the grid
                          itemBuilder: (BuildContext context, int index) {
                            return controller.inputFileFields[index];
                          }),
                    ),
                  ),
        Obx(() {
          return Form(
            key: formKey,
            child: Column(
              children: [
                ...controller.inputFields.map((element) {
                  return element;
                }).toList(),
              ],
            ),
          );
        }),
        _buttonWidget(context),
      ]),
    );
  }

  _buttonWidget(BuildContext context) {
    var status = controller.kycModelData.data.status;
    return status == 0 || status == 3
        ? Container(
            margin: EdgeInsets.only(
              top: Dimensions.marginSizeVertical * 2,
            ),
            child: Obx(
              () => controller.isUpdateLoading
                  ? const CustomLoadingAPI()
                  : PrimaryButton(
                      title: Strings.updateKYC.tr,
                      onPressed: (() {
                        if (formKey.currentState!.validate()) {
                          controller.kycSubmitProcess();
                        }
                      })),
            ),
          )
        : Container();
  }
}
