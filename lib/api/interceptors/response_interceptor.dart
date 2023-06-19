import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sales/models/models.dart';
import 'package:sales/routes/routes.dart';
import 'package:sales/shared/shared.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:shared_preferences/shared_preferences.dart';

FutureOr<dynamic> responseInterceptor(
    Request request, Response response) async {
  print(request.url);
  print(response.body);

  if (response.statusCode == 200) {
    final message = ErrorResponse.fromJson(response.body);
    if (message.error == true) {
      EasyLoading.showError(message.message ?? '');
      EasyLoading.dismiss();
      return;
    }
  } else {
    print(response.statusCode);
    handleErrorStatus(response);
    // return;
  }
  EasyLoading.dismiss();
  return response;
}

void handleErrorStatus(Response response) {
  final message = ErrorResponse.fromJson(response.body);
  if (message.error == true) {
    EasyLoading.showError(message.message ?? '');
    EasyLoading.dismiss();
    return;
  } else if (response.statusCode == 400) {
    final message = ErrorResponse.fromJson(response.body);
    CommonWidget.errorSnackBar(message.message ?? '');
    EasyLoading.dismiss();
    return;
  } else if (response.statusCode == 401) {
    final message = ErrorResponse.fromJson(response.body);
    CommonWidget.errorSnackBar(message.message ?? '');
    EasyLoading.dismiss();
    if (message.message == 'Unauthenticated.') {
      var storage = Get.find<SharedPreferences>();
      storage.clear();
      Get.offAllNamed(Routes.LOGIN);
    }
    return;
  } else if (response.statusCode == 404) {
    final message = ErrorResponse.fromJson(response.body);
    if (message.message == 'Data rating belum tersedia') {
    } else {
      CommonWidget.errorSnackBar(message.message ?? '');
    }
    EasyLoading.dismiss();
    return;
  } else if (response.statusCode == 403) {
    final message = ErrorResponse.fromJson(response.body);
    if (message.message == 'Hanya client yg bisa memberika rating') {
    } else {
      CommonWidget.errorSnackBar(message.message ?? '');
    }
    EasyLoading.dismiss();
    return;
  } else if (response.statusCode == 422) {
    final message = ErrorResponse.fromJson(response.body);
    CommonWidget.errorSnackBar(message.message ?? '');
    EasyLoading.dismiss();
    return;
  } else {
    EasyLoading.showError('Error occured. Please try again later');
    EasyLoading.dismiss();
    return;
  }
}
