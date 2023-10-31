import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crypinvest/language/english.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/custom_color.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/size.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  late ConnectivityResult connectivityResult;
  late StreamSubscription<ConnectivityResult> _streamSubscription;

  @override
  void onInit() async {
    super.onInit();
    _initConnectivity();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _initConnectivity() async {
    connectivityResult = await _connectivity.checkConnectivity();
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (kDebugMode) print("STATUS : $connectivityResult");

    if (connectivityResult == ConnectivityResult.none) {
      Get.dialog(
          barrierDismissible: false,
          barrierColor: Get.isDarkMode
              ? CustomColor.primaryBGDarkColor
              : CustomColor.primaryBGLightColor,
          WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: Column(
                  mainAxisAlignment: mainCenter,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: Dimensions.paddingSize * 1.5),
                      child: const Text(
                        Strings.pleaseConnectInternet,
                        style: TextStyle(
                          color: CustomColor.primaryLightColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    // addVerticalSpace(Dimensions.heightSize),
                    Icon(
                      Icons.wifi_off,
                      color: CustomColor.primaryLightColor,
                      size: Dimensions.iconSizeLarge * 1.5,
                    ),
                  ],
                )),
          ));
    } else {
      if (Get.isDialogOpen ?? true) {
        Get.back();
      }
    }
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
  }
}
