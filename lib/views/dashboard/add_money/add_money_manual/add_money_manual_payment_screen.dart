import 'package:crypinvest/backend/backend_utils/custom_loading_api.dart';
import 'package:crypinvest/backend/backend_utils/custom_snackbar.dart';
import 'package:crypinvest/controller/dashboard/add_money/add_money_manual_controller.dart';
import 'package:crypinvest/routes/routes.dart';
import 'package:crypinvest/widgets/gradient_container/gradient_container.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/appbar/custom_app_bar.dart';

class AddMoneyManualPaymentScreen extends StatelessWidget {
  AddMoneyManualPaymentScreen({super.key});

  final controller = Get.put(AddMoneyManualController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Scaffold(
        appBar: CustomAppBar(
          title: Strings.evidenceNote.tr,
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
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSize * 0.7,
        vertical: Dimensions.paddingSize * 0.7,
      ),
      child: Form(
        key: formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            ...controller.inputFields.map((element) {
              return element;
            }).toList(),
            _buttonWidget(context)
          ],
        ),
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.marginSizeVertical),
      child: PrimaryButton(
        title: Strings.submit,
        onPressed: () {
          if (formKey.currentState!.validate()) {
            if (controller.listImagePath.isNotEmpty) {
              Get.toNamed(Routes.addMoneyPreviewScreen);
            } else {
              CustomSnackBar.error(Strings.imagePathRequired);
            }
          }
        },
      ),
    );
  }
}
