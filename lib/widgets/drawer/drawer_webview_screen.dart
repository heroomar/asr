// ignore_for_file: must_be_immutable

import 'package:crypinvest/backend/backend_utils/custom_loading_api.dart';
import 'package:crypinvest/widgets/gradient_container/gradient_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import '../../routes/routes.dart';
import '../../utils/custom_color.dart';
import '../../widgets/appbar/back_button.dart';
import '../../widgets/text_labels/title_heading2_widget.dart';

class WebPaymentScreen extends StatelessWidget {
  WebPaymentScreen({super.key, required this.title, required this.url});

  final String title, url;

  late InAppWebViewController webViewController;
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(Routes.dashboardScreen);
        return false;
      },
      child: GradientContainer(
        child: Scaffold(
          backgroundColor: CustomColor.transparentColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: AppBar(
              leading: BackButtonWidget(onTap: () => Get.back()),
              elevation: 0,
              backgroundColor: CustomColor.transparentColor,
              centerTitle: false,
              title: TitleHeading2Widget(
                text: title,
                color: CustomColor.primaryDarkColor,
              ),
              actions: [
                IconButton(
                    onPressed: () => Get.offAllNamed(Routes.dashboardScreen),
                    icon: Icon(
                      Icons.home,
                      color: Get.isDarkMode
                          ? CustomColor.primaryLightColor
                          : CustomColor.primaryLightColor,
                    ))
              ],
            ),
          ),
          body: _bodyWidget(context),
        ),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    String paymentUrl = url;

    return Stack(
      children: [
        InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(paymentUrl)),
          onWebViewCreated: (controller) {
            webViewController = controller;
            controller.addJavaScriptHandler(
              handlerName: 'jsHandler',
              callback: (args) {
                // Handle JavaScript messages from WebView
              },
            );
          },
          onLoadStart: (controller, url) {
            isLoading.value = true;
          },
          onLoadStop: (controller, url) {
            isLoading.value = false;
          },
          // ... other callbacks ...
        ),
        ValueListenableBuilder<bool>(
          valueListenable: isLoading,
          builder: (context, isLoading, _) {
            return isLoading
                ? const Center(child: CustomLoadingAPI())
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
