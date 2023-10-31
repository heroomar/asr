import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../../../routes/routes.dart';
import '../../backend/backend_utils/custom_loading_api.dart';
import '../../controller/dashboard/add_money/add_money_controller.dart';
import '../../utils/basic_screen_imports.dart';
import '../../views/congratulation/congratulation_screen.dart';
import '../appbar/back_button.dart';

class PaypalWebPaymentScreen extends StatelessWidget {
  PaypalWebPaymentScreen({super.key});
  final controller = Get.put(AddMoneyController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(Routes.dashboardScreen);
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: AppBar(
            leading: BackButtonWidget(
              onTap: () {
                Get.offAllNamed(Routes.dashboardScreen);
              },
            ),
            elevation: 0,
            centerTitle: false,
            title: TitleHeading2Widget(text: controller.appBarName.value),
            actions: [
              IconButton(
                onPressed: () {
                  Get.offAllNamed(Routes.dashboardScreen);
                },
                icon: Icon(
                  Icons.home,
                  color: Get.isDarkMode
                      ? CustomColor.primaryLightColor
                      : CustomColor.primaryLightColor,
                ),
              )
            ],
          ),
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
    return InAppWebView(
      initialUrlRequest: URLRequest(
        url: Uri.parse(controller.paymentURl.value),
      ),
      onWebViewCreated: (InAppWebViewController controller) {},
      onProgressChanged: (InAppWebViewController controller, int progress) {},
      onLoadStop: (controller, url) {
        // Handle page load stop, e.g., hide loading indicator

        if (url.toString().contains('success/response')) {
          Get.to(
            () => const CongratulationScreen(
              route: Routes.dashboardScreen,
              subTitle: Strings.addMoneyCongratulationSubtitle,
            ),
          );
        }
      },
    );
  }
}
