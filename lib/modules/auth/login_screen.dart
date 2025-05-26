import 'package:flutter/material.dart';
import 'package:sales/shared/shared.dart';
import 'package:sales/shared/widgets/button.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class LoginScreen extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          alignment: Alignment.center,
          // decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 200)),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: MediaQuery.of(context).size.height * .30,
                      width: MediaQuery.of(context).size.width * .70,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .25),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 35.0),
                  child: _buildForms(context),
                ),
                CommonWidget.rowHeight(),
                // Container(
                //     child: Align(
                //         alignment: Alignment.bottomCenter,
                //         child: Container(child: helpLabel))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final helpLabel = Container(
    alignment: Alignment.center,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          child: Text(
            "02619277700",
            style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
          ),
          onTap: () {},
        ),
        Text(
          "  |  ",
          style: TextStyle(color: Colors.white),
        ),
        InkWell(
          child: Text(
            "Contact Support",
            style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
          ),
          onTap: () {},
        )
      ],
    ),
  );

  Widget _buildForms(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonWidget.rowHeight(height: 32),
            InputField(
              prefixIcon: Icon(
                Icons.person,
                size: 30,
              ),
              controller: controller.loginEmailController,
              keyboardType: TextInputType.text,
              placeholder: 'Username',
              validator: (value) {
                // if (!Regex.isEmail(value!)) {
                //   return 'username format error.';
                // }

                // if (value.isEmpty) {
                //   return 'Email is required.';
                // }
                return null;
              },
            ),
            CommonWidget.rowHeight(),
            Obx(() => InputField(
                  textObscured: controller.isObscured.value,
                  isPassword: true,
                  onVisibilityPressed: () {
                    controller.toggleVisibility();
                  },
                  prefixIcon: Icon(
                    Icons.vpn_key_rounded,
                    size: 30,
                  ),
                  controller: controller.loginPasswordController,
                  keyboardType: TextInputType.emailAddress,
                  placeholder: 'Password',
                  password: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password is required.';
                    }
                    if (value.length < 4) {
                      return 'Password should be more then 6 characters';
                    }

                    return null;
                  },
                )),
            //  CommonWidget.captionText(
            //           text: "Password is required"),
            // CommonWidget.rowHeight(),
            // TextButton(
            //   onPressed: () {
            //     // Navigator.of(context).push(new MaterialPageRoute(
            //     //     builder: (BuildContext context) => LupaPassword()));
            //   },
            //   child: CommonWidget.subtitleText(
            //       text: "Lupa Password?", color: Colors.white),
            // ),
            CommonWidget.rowHeight(),
            CustomButton(
              buttonText: 'LOGIN',
              width: MediaQuery.of(context).size.width,
              onPressed: () {
                controller.login(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
