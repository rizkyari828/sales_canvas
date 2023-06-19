import 'package:sales/shared/shared.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/logo.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: ColorConstants.mainColor,
        body: Center(
          child: Image.asset(
            'assets/images/logo.png',
            height: MediaQuery.of(context).size.height * .30,
            width: MediaQuery.of(context).size.width * .70,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
