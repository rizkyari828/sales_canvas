import 'dart:io';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class BaseController extends GetxController {
  BaseController();

  RxBool isConnectedToInternet = true.obs;
  RxBool isConnectedToInternetWidget = false.obs;

  @override
  void onInit() async {
    super.onInit();

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _handleCheckConnectivity(result);
    });
  }

  void _handleCheckConnectivity(ConnectivityResult result) async {
    try {
      if (result == ConnectivityResult.none) {
        isConnectedToInternet.value = false;
        isConnectedToInternetWidget.value = true;
      } else {
        final connection = await InternetAddress.lookup('google.com');
        if (connection.isNotEmpty && connection[0].rawAddress.isNotEmpty) {
          isConnectedToInternet.value = true;
          isConnectedToInternetWidget.value = true;
        }
      }
    } on SocketException catch (_) {
      isConnectedToInternet.value = false;
      isConnectedToInternetWidget.value = true;
    }
  }

  void closeWidget() {
    isConnectedToInternetWidget.value = false;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
