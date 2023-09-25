import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../routes/app_routes.dart';

class SplashController extends GetxController {
  late RxBool isConnected = false.obs;
  late StreamSubscription<ConnectivityResult> _streamSubscription;

  @override
  void onInit() async {
    super.onInit();
    initializeConnectivity();
    checkConnectivityStream();
  }

  void checkConnectivityStream() async {
    _streamSubscription = Connectivity().onConnectivityChanged.listen(
      (status) async {
        switch (status) {
          case ConnectivityResult.ethernet:
          case ConnectivityResult.mobile:
          case ConnectivityResult.wifi:
            if (!isConnected.value) {
              isConnected.value = true;
              if (WidgetsFlutterBinding.ensureInitialized()
                  .firstFrameRasterized) Get.back();
            }
            break;
          default:
            isConnected.value = false;
            if (WidgetsFlutterBinding.ensureInitialized()
                .firstFrameRasterized) {
              // Get.toNamed(AppRoutes.OFFLINE);
            }
            break;
        }
      },
    );
  }

  Future<void> initializeConnectivity() async {
    ConnectivityResult connectionStatus =
        await Connectivity().checkConnectivity();

    switch (connectionStatus) {
      case ConnectivityResult.ethernet:
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        isConnected = true.obs;
        break;
      default:
        isConnected = false.obs;
        break;
    }
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
}
