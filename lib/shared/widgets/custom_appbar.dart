import 'package:sales/shared/constants/colors.dart';
import 'package:sales/shared/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  final String type;
  final bool backButton;
  final Icon? icon;
  final String? textLabel;
  final String? textSubtitle;
  final VoidCallback? onPressedIcon;

  CustomAppBar({
    this.type = "small",
    this.backButton = false,
    this.icon,
    required this.textLabel,
    this.textSubtitle,
    this.onPressedIcon,
  });

  @override
  Widget build(BuildContext context) {
    final sw = SizeConfig().screenWidth;
    final sh = SizeConfig().screenHeight;
    return Stack(children: [
      Container(
        width: MediaQuery.of(context).size.height,
        height: type == "large"
            ? sh / 5
            : type == "medium"
                ? sh / 6
                : sh / 7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
          // borderRadius: BorderRadius.circular(15),
          color: ColorConstants.mainColor,
        ),
      ),
      Container(
        height: type == "large"
            ? sh / 5
            : type == "medium"
                ? sh / 12
                : sh / 15,
        margin: EdgeInsets.only(
          top: sh / 20,
          left: sw / 20,
          right: sw / 15,
        ),
        child: Row(
          children: [
            backButton
                ? IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back_rounded, size: 25),
                  )
                : SizedBox(),
            type == "medium"
                ? Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          textLabel ?? "",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Text(
                          textSubtitle ?? "",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      textLabel ?? "",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
            icon != null
                ? Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child:
                            IconButton(onPressed: onPressedIcon, icon: icon!)))
                : SizedBox(),
          ],
        ),
      ),
    ]);
  }
}

class CustomHeaderHome extends StatelessWidget {
  final String? textLabel;
  final VoidCallback? onPressedIcon;

  CustomHeaderHome({
    required this.textLabel,
    this.onPressedIcon,
  });

  @override
  Widget build(BuildContext context) {
    final sw = SizeConfig().screenWidth;
    final sh = SizeConfig().screenHeight;
    return Stack(children: [
      Container(
        width: MediaQuery.of(context).size.height,
        height: sh / 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
          // borderRadius: BorderRadius.circular(15),
          color: ColorConstants.mainColor,
        ),
      ),
      Container(
        margin: EdgeInsets.only(
          top: sh / 15,
          left: sw / 20,
          right: sw / 15,
        ),
        child: ListTile(
          leading: Container(
            height: 100,
            child: ElevatedButton(
              onPressed: () {},
              child: Icon(Icons.person_rounded, color: Colors.grey, size: 50),
              style: ElevatedButton.styleFrom(
                elevation: 0.1, backgroundColor: Colors.white,
                shape: CircleBorder(),
              ),
            ),
          ),
          title: Text(
            textLabel ?? "",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 28,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
    ]);
  }
}

class CustomContinuesAppBar extends StatelessWidget {
  final String type;
  final bool backButton;
  final Icon? icon;
  final String? textLabel;
  final String? textSubtitle;
  final VoidCallback? onPressedIcon;

  CustomContinuesAppBar({
    this.type = "small",
    this.backButton = false,
    this.icon,
    required this.textLabel,
    this.textSubtitle,
    this.onPressedIcon,
  });

  @override
  Widget build(BuildContext context) {
    final sw = SizeConfig().screenWidth;
    final sh = SizeConfig().screenHeight;
    return Stack(children: [
      Container(
        width: MediaQuery.of(context).size.height,
        height: sh * .09,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
          // borderRadius: BorderRadius.circular(15),
          color: ColorConstants.mainColor,
        ),
      ),
      Container(
        height: sh / 12,
        margin: EdgeInsets.only(
          // top: sh * .05,
          left: sw * .02,
          right: sw / 15,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textSubtitle ?? "",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: type == "large" ? 24 : 14,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ]);
  }
}
