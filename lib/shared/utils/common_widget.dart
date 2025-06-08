import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sales/shared/shared.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CommonWidget {
  static AppBar appBar(
      {String title = "",
      bool backIcon = true,
      bool centerTextAlign = false,
      void Function()? callback,
      bool actionIcon = false,
      VoidCallback? onPressedActionIcon}) {
    return AppBar(
      iconTheme:
          IconThemeData(color: ColorConstants.black //change your color here
              ),
      // toolbarHeight: 50,
      automaticallyImplyLeading: backIcon,
      centerTitle: centerTextAlign,
      title: Text(
        title,
        style: TextStyle(
          color: ColorConstants.black,
          fontWeight: FontWeight.w600,
          fontSize: 20,
          fontFamily: 'Poppins',
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      actions: [
        actionIcon == true
            ? IconButton(
                onPressed: onPressedActionIcon,
                tooltip: 'Tambah CnC',
                icon: Icon(Icons.add_box_rounded, size: 20),
              )
            : Container(),
      ],
    );
  }

  static SizedBox rowHeight({double height = 16}) {
    return SizedBox(height: height);
  }

  static SizedBox rowWidth({double width = 30}) {
    return SizedBox(width: width);
  }

  static Text bigText(
      {String text = "",
      Color color = ColorConstants.black,
      TextAlign align = TextAlign.start}) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 33,
          fontFamily: 'Poppins'),
    );
  }

  static Text headText(
      {String text = "",
      Color color = ColorConstants.black,
      TextAlign align = TextAlign.start}) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 23,
          fontFamily: 'Poppins'),
    );
  }

  static Text minHeadText({
    String text = "",
    Color color = ColorConstants.black,
    TextAlign align = TextAlign.start,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
          color: color,
          fontWeight: fontWeight,
          fontSize: 18,
          fontFamily: 'Poppins'),
    );
  }

  static Text subtitleText(
      {String text = "",
      Color color = ColorConstants.black,
      FontWeight fontWeight = FontWeight.normal,
      textAlign = TextAlign.start}) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          color: color,
          fontWeight: fontWeight,
          fontSize: 13,
          letterSpacing: 0.15,
          fontFamily: 'Poppins'),
    );
  }

  static Text subtitlePlusText(
      {String text = "",
      Color color = ColorConstants.black,
      FontWeight fontWeight = FontWeight.normal,
      textAlign = TextAlign.start}) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          color: color,
          fontWeight: fontWeight,
          fontSize: 15,
          letterSpacing: 0.15,
          fontFamily: 'Poppins'),
    );
  }

  static Text minSubtitleText(
      {String text = "",
      Color color = ColorConstants.black,
      FontWeight fontWeight = FontWeight.normal}) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontWeight: fontWeight,
          fontSize: 12,
          letterSpacing: 0.15,
          fontFamily: 'Poppins'),
    );
  }

  static Text bodyText({String text = "", Color color = ColorConstants.black}) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontWeight: FontWeight.normal,
          fontSize: 14,
          letterSpacing: 0.5,
          fontFamily: 'Poppins'),
    );
  }

  static Text captionText(
      {String text = "", Color color = ColorConstants.black}) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontWeight: FontWeight.normal,
          fontSize: 10,
          letterSpacing: 0.4,
          fontFamily: 'Poppins'),
    );
  }

  static Text bodyMultilineText({String text = "", Color color = ColorConstants.black}) {
    return Text(
      text,
      maxLines: 2,
      style: TextStyle(
          color: color,
          fontWeight: FontWeight.normal,
          fontSize: 14,
          letterSpacing: 0.4,
          fontFamily: 'Poppins'),
    );
  }

  static Text captionMultilineText(
      {String text = "",
      Color color = ColorConstants.black,
      TextAlign textAlign = TextAlign.start}) {
    return Text(
      text,
      maxLines: 2,
      textAlign: textAlign,
      style: TextStyle(
          color: color,
          fontWeight: FontWeight.normal,
          fontSize: 10,
          letterSpacing: 0.4,
          fontFamily: 'Poppins'),
    );
  }

  static Row labelExpanded(
      {String label = "",
      value = "",
      Color color = ColorConstants.black,
      fontWeight2 = FontWeight.w600,
      fontSize = 14.0}) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: TextStyle(
                color: color,
                fontWeight: FontWeight.normal,
                fontSize: fontSize,
                letterSpacing: 0.5,
                fontFamily: 'Poppins'),
          ),
        ),
        Expanded(
          child: Text(value,
              style: TextStyle(
                  color: color,
                  fontWeight: fontWeight2,
                  fontSize: fontSize,
                  letterSpacing: 0.5,
                  fontFamily: 'Poppins')),
        ),
      ],
    );
  }

  static Row labelIconExpanded(
      {Icon icon = const Icon(
        Icons.person,
        size: 30,
        color: Colors.orangeAccent,
      ),
      text = "",
      Color color = ColorConstants.black,
      fontWeight2 = FontWeight.w600,
      fontSize = 14.0,
      isSubtitle = true}) {
    return Row(
      children: <Widget>[
        icon,
        SizedBox(
          width: 10,
        ),
        Expanded(
            child: isSubtitle
                ? minHeadText(text: text, color: color, fontWeight: fontWeight2)
                : captionText(text: text, color: color)),
      ],
    );
  }

  static Row labelRowIcon({icon, widget}) {
    return Row(
      children: [
        Icon(
          icon,
          color: ColorConstants.mainColor,
          size: 13,
        ),
        SizedBox(width: 5.0),
        widget,
      ],
    );
  }

  static Row widgetExpanded(
      {Widget? left, Widget? right, Color color = ColorConstants.black}) {
    return Row(
      children: <Widget>[
        Expanded(
          child: left ?? Container(),
        ),
        SizedBox(width: 20),
        Expanded(
          child: right ?? Container(),
        ),
      ],
    );
  }

  static void toast(String error) async {
    await Fluttertoast.showToast(
      msg: error,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  static void errorSnackBar(String error) async {
    Get.snackbar(
      "Informasi",
      error,
      icon: Icon(Icons.warning_rounded, color: Colors.white),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      borderRadius: 20,
      margin: EdgeInsets.all(15),
      colorText: Colors.white,
      duration: Duration(seconds: 4),
      isDismissible: true,
      //dismissDirection: SnackDismissDirection.HORIZONTAL,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  static Widget cardWithShadow(child) {
    final sw = SizeConfig().screenWidth;
    return Container(
      width: sw,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 2.0, color: ColorConstants.borderColor),
        // boxShadow: [
        //   BoxShadow(
        //     color: CommonWidget.setOpacity(Colors.black, 0.3),
        //     blurRadius: 20.0,
        //     spreadRadius: 4.0,
        //     offset: Offset(
        //       -10.0,
        //       10.0,
        //     ),
        //   ),
        // ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: child,
      ),
    );
  }

  static String convertStatus(status) {
    switch (status) {
      case '1':
        return 'Prospek';
      case '2':
        return 'Order';
      case '3':
        return 'Booking';
      case '4':
        return 'Cancle';
      case '5':
        return 'Reject';
      case '6':
        return 'TBC';
      default:
        return '';
    }
  }

  static Color setOpacity(Color color, double opacity) {
    return color.withAlpha((opacity * 255).round());
  }

  static Widget progressLiniar(
      int current, int total, double percentage, context) {
    return Column(
      children: [
        LinearPercentIndicator(
          width: MediaQuery.of(context).size.width - 50,
          animation: true,
          lineHeight: 20.0,
          animationDuration: 2000,
          percent: percentage,
          center: CommonWidget.minSubtitleText(
              text: '${current} / ${total}', color: ColorConstants.white),
          barRadius: Radius.circular(10),
          progressColor: percentage < 0.25
              ? Colors.red
              : percentage < 0.5
                  ? Colors.orange
                  : percentage < 0.75
                      ? Colors.amber
                      : percentage < 1.0
                          ? Colors.blue
                          : Colors.green,
        ),
        SizedBox(height: 20.0),
        Divider(
          color: ColorConstants.borderColor,
        ),
        SizedBox(height: 20.0),
      ],
    );
  }
}
