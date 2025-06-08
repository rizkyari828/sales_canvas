import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_connect/http/src/request/request.dart';

FutureOr<Request?> requestInterceptor(Request request) async {
  // Tambahkan header dasar
  request.headers['X-Requested-With'] = 'XMLHttpRequest';
  // var prefs = Get.find<SharedPreferences>();
  // final token = prefs.getString('token') ?? "";
  // request.headers['Authorization'] = 'Bearer $token';

  // Cek koneksi internet
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
