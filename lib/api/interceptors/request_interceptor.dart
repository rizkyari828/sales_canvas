import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:detect_fake_location/detect_fake_location.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

FutureOr<Request?> requestInterceptor(Request request) async {
  // Tambahkan header dasar
  request.headers['X-Requested-With'] = 'XMLHttpRequest';
  // var prefs = Get.find<SharedPreferences>();
  // final token = prefs.getString('token') ?? "";
  // request.headers['Authorization'] = 'Bearer $token';

  bool isFakeLocation = false;
  try {
    isFakeLocation = await DetectFakeLocation().detectFakeLocation();
  } catch (e) {
    isFakeLocation = false;
  }
  if (isFakeLocation) {
    Future.delayed(Duration.zero, () {
      Get.dialog(
        AlertDialog(
          title: Text("Fake Location Terdeteksi"),
          content: Text("Matikan aplikasi lokasi palsu untuk melanjutkan."),
          actions: [
            TextButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: Text("Keluar"),
            ),
          ],
        ),
        barrierDismissible: false,
      );
    });
    return null;
  }

  var result = await Connectivity().checkConnectivity();
  if (result == ConnectivityResult.none) {
    Future.delayed(Duration.zero, () {
      EasyLoading.showError("Tidak ada koneksi internet");
    });
    return null; // Batalkan request
  } else {
    try {
      final connection = await InternetAddress.lookup('google.com');
      if (connection.isNotEmpty && connection[0].rawAddress.isNotEmpty) {
        // Internet OK
        EasyLoading.show(status: 'loading..');
        return request;
      } else {
        Future.delayed(Duration.zero, () {
          EasyLoading.showError("Tidak ada koneksi internet");
        });
        return null; // Batalkan request
      }
    } catch (e) {
      Future.delayed(Duration.zero, () {
        EasyLoading.showError("Tidak ada koneksi internet");
      });
      return null; // Batalkan request
    }
  }
}
