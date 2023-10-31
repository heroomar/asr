import 'package:crypinvest/backend/backend_utils/custom_loading_api.dart';
import 'package:crypinvest/widgets/gradient_container/gradient_container.dart';
import '../../../../controller/dashboard/add_money/add_money_controller.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/appbar/custom_app_bar.dart';
import '../../../../widgets/inputs/add_money_widget.dart';

class AddMoneyScreenMobile extends StatelessWidget {
  AddMoneyScreenMobile({super.key});
  final controller = Get.put(AddMoneyController());
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Scaffold(
        appBar: CustomAppBar(
          title: Strings.addMoney.tr,
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
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [

        AddMoneyWidget(
          // isLoading: controller.isLoading.obs,

          buttonText: Strings.addMoney,
          onTap: () => controller.goToAddMoneyPreviewScreen(),
        ),
      ],
    );
  }
}
