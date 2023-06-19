import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_connect/http/src/request/request.dart';

FutureOr<Request> requestInterceptor(request) async {
  // var prefs = Get.find<SharedPreferences>();
  // final token = prefs.getString('token') ?? "";

  request.headers['X-Requested-With'] = 'XMLHttpRequest';
  // request.headers['Authorization'] = 'Bearer $token';

  EasyLoading.show(status: 'loading..');
  return request;
}
