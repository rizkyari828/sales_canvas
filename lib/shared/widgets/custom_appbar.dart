import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales/shared/utils/network_checker.dart';

class CustomAppBarWithNetwork extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final RxString networkStatus;

  const CustomAppBarWithNetwork({
    required this.title,
    required this.networkStatus,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      elevation: 0.0,
      title: Text(
        title,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: NetworkChecker.networkMeter(networkStatus),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
