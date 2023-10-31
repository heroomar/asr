import 'package:crypinvest/backend/backend_utils/custom_loading_api.dart';
import 'package:crypinvest/widgets/gradient_container/gradient_container.dart';
import '../../../../controller/dashboard/money_out/money_out_controller.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/appbar/custom_app_bar.dart';
import '../../../../widgets/inputs/money_out_widget.dart';

class MoneyOutScreenMobile extends StatelessWidget {
  MoneyOutScreenMobile({super.key});
  final controller = Get.put((MoneyOutController()));



  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Scaffold(
        appBar: CustomAppBar(
          title: Strings.moneyOut.tr,
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
        MoneyOutWidget(
          // isLoading: controller.isLoading.obs,
          buttonText: Strings.moneyOut.tr,
          onTap: () => controller.gotoManualScreen(),
        ),
      ],
    );
  }
}
