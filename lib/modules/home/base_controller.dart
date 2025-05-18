import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sales/shared/constants/colors.dart';
import 'package:sales/shared/utils/common_widget.dart';
import 'package:sales/shared/utils/size_config.dart';

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

  Widget internetConnection() {
    final sw = SizeConfig().screenWidth;
    final sh = SizeConfig().screenHeight;
    return isConnectedToInternet.value == false
        ? Container(
            width: sw,
            height: sw * .18,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Colors.grey[300] ?? ColorConstants.white, // Border color
                width: 1, // Border width
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 20.0,
                  spreadRadius: 4.0,
                  offset: Offset(
                    -10.0,
                    10.0,
                  ),
                ),
              ],
            ),
            margin: EdgeInsets.only(
              top: sh / 20,
              left: 10.0,
              right: 10.0,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 40, // Diameter lingkaran
                          height: 40,
                          decoration: BoxDecoration(
                            color: isConnectedToInternet.value == false
                                ? Colors.grey[400]
                                : Colors.green, // Warna latar lingkaran
                            shape: BoxShape.circle, // Membuat bentuk lingkaran
                          ),
                          child: isConnectedToInternet.value == false
                              ? Icon(
                                  Icons.wifi_off,
                                  size: 25.0, // Ukuran ikon
                                  color: Colors.white, // Warna ikon
                                )
                              : Icon(
                                  Icons.wifi,
                                  size: 25.0, // Ukuran ikon
                                  color: Colors.white,
                                ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            isConnectedToInternet.value == false
                                ? CommonWidget.subtitleText(
                                    text: "Internet Terputus",
                                    color: ColorConstants.black,
                                    fontWeight: FontWeight.bold)
                                : CommonWidget.subtitleText(
                                    text: "Internet Tersambung",
                                    color: ColorConstants.black,
                                    fontWeight: FontWeight.bold),
                            isConnectedToInternet.value == false
                                ? CommonWidget.subtitleText(
                                    text: "Segera periksa jaringan internet mu",
                                    color: ColorConstants.black)
                                : CommonWidget.subtitleText(
                                    text: "Kamu Terkoneksi dengan internet",
                                    color: ColorConstants.black),
                          ],
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => closeWidget(),
                    child: Expanded(
                      flex: 1,
                      child: Container(
                          width: 30, // Diameter lingkaran
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.close,
                            size: 20.0, // Ukuran ikon
                            color: Colors.white, // Warna ikon
                          )),
                    ),
                  ),
                ],
              ),
            ),
          )
        : SizedBox();
  }

  void closeWidget() {
    isConnectedToInternetWidget.value = false;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
