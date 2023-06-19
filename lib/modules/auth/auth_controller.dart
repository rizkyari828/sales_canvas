import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sales/api/api.dart';
import 'package:sales/models/models.dart';
import 'package:sales/routes/app_pages.dart';
import 'package:sales/shared/shared.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final ApiRepository apiRepository;
  AuthController({required this.apiRepository});

  // final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();
  bool registerTermsChecked = false;

  final formKey = GlobalKey<FormState>();
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  RxBool isObscured = true.obs;
  // bool get isObscured => _isObscured;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void login(BuildContext context) async {
    AppFocus.unfocus(context);
    if (formKey.currentState!.validate()) {
      final res = await apiRepository.login(
        loginEmailController.text,
        loginPasswordController.text,
        LoginRequest(
          username: loginEmailController.text,
          password: loginPasswordController.text,
        ),
      );

      print(res);

      // print("Bearer " + res!.token.toString());

      final prefs = Get.find<SharedPreferences>();
      prefs.clear();
      if (res?.error == false) {
        if (res?.data?.first.token != '' || res?.data?.first.token != null) {
          prefs.setString(StorageConstants.token, res?.data?.first.token ?? '');
          prefs.setString(StorageConstants.name, res?.data?.first.nama ?? '');
          prefs.setString(StorageConstants.userId,
              res?.data?.first.userId.toString() ?? "");
          prefs.setString(StorageConstants.idPegawai,
              res?.data?.first.idPegawai.toString() ?? "");
          prefs.setString(StorageConstants.username,
              res?.data?.first.username.toString() ?? "");
          prefs.setString(
              StorageConstants.profilePhoto, res?.data?.first.foto ?? "");
          prefs.setString(StorageConstants.groupId,
              res?.data?.first.groupUser.toString() ?? "");
          Get.toNamed(Routes.HOME);
        }
      }
    }

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    messaging.getToken().then((value) {
      print("token FCM Home $value");
      submitToken(value);
    });
  }

  void submitToken(token) async {
    // final res = await apiRepository
    //     .updateFcmProfile(UpdateFcmProfileRequest(fcmToken: token));
    // if (res!.error == false) {
    //   print('Token updated');
    // } else {
    //   print('Token update failed');
    // }
    // listType.addAll(res?.data ?? []);
  }

  void register(BuildContext context) async {
    AppFocus.unfocus(context);
    // if (registerFormKey.currentState!.validate()) {
    //   if (!registerTermsChecked) {
    //     CommonWidget.toast('Please check the terms first.');
    //     return;
    //   }

    //   final res = await apiRepository.register(
    //     RegisterRequest(
    //       email: registerEmailController.text,
    //       password: registerPasswordController.text,
    //     ),
    //   );

    //   final prefs = Get.find<SharedPreferences>();
    //   if (res!.token.isNotEmpty) {
    //     prefs.setString(StorageConstants.token, res.token);
    //     print('Go to Home screen');
    //   }
    // }
  }

  void toggleVisibility() => isObscured.value == true
      ? isObscured.value = false
      : isObscured.value = true;

  @override
  void onClose() {
    super.onClose();

    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();

    loginEmailController.dispose();
    loginPasswordController.dispose();
  }
}
