import 'package:sales/shared/constants/colors.dart';
import 'package:sales/shared/utils/network_checker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar {
  static AppBar appBar(textLabel, networkMeter) {
    return AppBar(
      iconTheme:
          IconThemeData(color: ColorConstants.black //change your color here
              ),
      centerTitle: false,
      title: Text(
        textLabel ?? '',
        style: TextStyle(
          color: ColorConstants.black,
          fontWeight: FontWeight.w600,
          fontSize: 20,
          fontFamily: 'Poppins',
        ),
      ),
      backgroundColor: ColorConstants.lightScaffoldBackgroundColor,
      elevation: 0.0,
      actions: [
        Obx(() => Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: NetworkChecker.networkMeter(
              networkMeter ?? '',
            )))
      ],
    );
  }
}
