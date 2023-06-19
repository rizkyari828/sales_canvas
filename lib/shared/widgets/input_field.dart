import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:sales/shared/constants/colors.dart';
import 'package:sales/shared/constants/common.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String labelText;
  final String placeholder;
  final bool? isPassword;
  final Color color;
  final double fontSize;
  final bool password;
  final String? Function(String?)? validator;
  final Widget? prefixIcon, suffixIcon;
  final bool? isError;
  final bool? textObscured;
  final Function()? onVisibilityPressed;

  InputField({
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.labelText = '',
    this.placeholder = '',
    this.color = Colors.white,
    this.fontSize = CommonConstants.bodyText,
    this.password = false,
    this.validator,
    this.prefixIcon = const Icon(Icons.person),
    this.suffixIcon = const Icon(
      Icons.error_outline,
      size: 30,
      color: Color.fromRGBO(255, 0, 0, 1.0),
    ),
    this.isPassword = false,
    this.isError = false,
    this.textObscured = true,
    this.onVisibilityPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorConstants.backgroundTextField,
      elevation: 0.1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffix: isError ?? false
              ? Icon(
                  Icons.error_outline,
                  size: 25,
                  color: Color.fromRGBO(255, 0, 0, 1.0),
                )
              : null,
          suffixIcon: _suffixIcon(),
          focusedBorder: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: new BorderSide(
                  color: isError ?? false ? Colors.red : color, width: 1.0)),
          enabledBorder: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: new BorderSide(
                  color: isError ?? false ? Colors.red : color, width: 1.0)),
          hintText: this.placeholder,
          hintStyle: TextStyle(
            fontSize: fontSize,
            // color: color,
            fontWeight: FontWeight.normal,
          ),
          // floatingLabelBehavior: FloatingLabelBehavior.always,
          // labelStyle: TextStyle(
          //   fontSize: fontSize - 2,
          //   color: color,
          //   height: 0.2,
          //   fontWeight: FontWeight.normal,
          // ),
        ),
        controller: this.controller,
        style: TextStyle(
          // color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.normal,
        ),
        keyboardType: this.keyboardType,
        obscureText: _showPassword(),
        autocorrect: false,
        validator: this.validator,
      ),
    );
  }

  Widget? _suffixIcon() {
    if (isPassword ?? false) {
      return IconButton(
        onPressed: isPassword ?? false ? onVisibilityPressed : null,
        icon: textObscured ?? false
            ? Icon(
                Icons.visibility_off,
              )
            : Icon(
                Icons.visibility,
              ),
      );
    }
    return isError ?? false ? suffixIcon : null;
  }

  bool _showPassword() {
    if (isPassword ?? false) {
      return textObscured ?? false;
    }
    return false;
  }
}

class InputInputField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String labelText;
  final String placeholder;
  final Color color;
  final double fontSize;
  final bool password;
  final String? Function(String?)? validator;
  final bool? isSuffixIcon;
  final Widget? suffixIcon;
  final bool? isError;
  final bool? textObscured;
  final Function()? onSuffixPressed;
  final VoidCallback? onChanged;
  final isDisabled;

  InputInputField({
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.labelText = '',
    this.placeholder = '',
    this.color = Colors.white,
    this.fontSize = CommonConstants.bodyText,
    this.password = false,
    this.validator,
    this.isSuffixIcon = false,
    this.isError = false,
    this.textObscured = true,
    this.onSuffixPressed,
    this.suffixIcon,
    this.onChanged,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: TextField(
          readOnly: isDisabled,
          enableInteractiveSelection: isDisabled,
          keyboardType: this.keyboardType,
          autocorrect: false,
          controller: this.controller,
          onChanged: (text) {
            onChanged;
          },
          decoration: InputDecoration(
            labelStyle: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                letterSpacing: 0.5,
                color: Colors.black87,
                fontFamily: 'Poppins'),
            prefixStyle: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.normal,
                fontSize: 14,
                letterSpacing: 0.5,
                fontFamily: 'Poppins'),
            suffixStyle: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.normal,
                fontSize: 14,
                letterSpacing: 0.5,
                fontFamily: 'Poppins'),
            labelText: labelText,
            hintText: placeholder,
            filled: true,
            fillColor: isDisabled ? Colors.grey[200] : Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                color: ColorConstants.mainColor,
              ),
            ),
            suffixIcon: _suffixIcon(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                color: ColorConstants.mainColor,
              ),
            ),
          )),
    );
  }

  Widget? _suffixIcon() {
    if (isSuffixIcon ?? false) {
      return IconButton(
        onPressed: isSuffixIcon ?? false ? onSuffixPressed : null,
        icon: suffixIcon ?? Icon(Icons.add),
      );
    }
    return isError ?? false ? suffixIcon : null;
  }
}

class TextAreaField extends StatelessWidget {
  final TextEditingController controller;
  final isDisabled;

  TextAreaField({required this.controller, this.isDisabled = false});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0.1,
        color: isDisabled ? Colors.grey[200] : Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(color: ColorConstants.mainColor, width: 1)),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            readOnly: isDisabled,
            enableInteractiveSelection: isDisabled,
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.normal,
                fontSize: 14,
                letterSpacing: 0.5,
                fontFamily: 'Poppins'),
            controller: controller,
            maxLines: 8,
            decoration: InputDecoration.collapsed(
              hintText: "Enter your text here",
              hintStyle: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  letterSpacing: 0.5,
                  fontFamily: 'Poppins'),
              filled: true,
              fillColor: isDisabled ? Colors.grey[200] : Colors.white,
              focusColor: isDisabled ? Colors.grey[200] : Colors.white,
            ),
          ),
        ));
  }
}

class CustomDropDownSearch extends StatelessWidget {
  var listItem;
  final String labelText;
  final onChanged;
  final bool enabled;
  final selectedItem;

  CustomDropDownSearch({
    required this.listItem,
    this.labelText = '',
    this.onChanged,
    this.enabled = true,
    // ignore: avoid_init_to_null
    this.selectedItem = null,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height / 11,
      child: DropdownSearch<dynamic>(
        dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
          labelStyle: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
              letterSpacing: 0.5,
              color: Colors.black87,
              fontFamily: 'Poppins'),
          prefixStyle: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.normal,
              fontSize: 14,
              letterSpacing: 0.5,
              fontFamily: 'Poppins'),
          suffixStyle: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.normal,
              fontSize: 14,
              letterSpacing: 0.5,
              fontFamily: 'Poppins'),
          labelText: labelText,
          filled: true,
          fillColor: enabled ? Colors.white : Colors.grey[200],
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              color: ColorConstants.mainColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              color: ColorConstants.mainColor,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              color: ColorConstants.mainColor,
            ),
          ),
        )),
        enabled: enabled,
        selectedItem: selectedItem,
        items: listItem,
        onChanged: onChanged,
        // showSearchBox: true,
      ),
    );
  }
}
