import 'package:flutter/material.dart';

class InputStyle {
  static InputDecoration textFieldStyle({String hint, String icon}) {
    return InputDecoration(
      contentPadding:
          const EdgeInsets.only(right: 0.0, left: 26.0, top: 0, bottom: 0),
      prefixIcon: Padding(
        padding:
            const EdgeInsets.only(right: 14.0, left: 12.0, top: 0, bottom: 0),
        child: SizedBox(
            width: 10,
            height: 10,
            child: icon != null
                ? Image.asset(
                    icon,
                    fit: BoxFit.scaleDown,
                    color: Color.fromRGBO(255, 255, 255, 0.9),
                  )
                : null),
      ),
      fillColor: Color.fromRGBO(255, 255, 255, 0.05),
      filled: true,
      hintText: hint,
      hintStyle: TextStyle(
          color: Color.fromRGBO(255, 255, 255, 0.9),
          fontSize: 20.0,
          fontWeight: FontWeight.w600),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
              width: 1.0, color: Color.fromRGBO(255, 255, 255, 0.1))),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
              width: 1.0, color: Color.fromRGBO(255, 255, 255, 0.1))),
    );
  }

  static InputDecoration textFieldLightStyle({
    String hint,
    String icon,
  }) {
    return InputDecoration(
      contentPadding:
          const EdgeInsets.only(right: 0.0, left: 26.0, top: 0, bottom: 0),
      prefixIcon: Padding(
        padding:
            const EdgeInsets.only(right: 14.0, left: 12.0, top: 0, bottom: 0),
        child: SizedBox(
            width: 10,
            height: 10,
            child: icon != null
                ? Image.asset(
                    icon,
                    fit: BoxFit.scaleDown,
                    // color: Color.fromRGBO(0, 0, 0, 0.2),
                  )
                : null),
      ),
      fillColor: Color.fromRGBO(0, 0, 0, 0.05),
      filled: true,
      hintText: hint,
      hintStyle: TextStyle(
          color: Colors.grey.shade500,
          fontSize: 20.0,
          fontWeight: FontWeight.w600),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide:
              BorderSide(width: 1.0, color: Color.fromRGBO(0, 0, 0, 0.1))),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide:
              BorderSide(width: 1.0, color: Color.fromRGBO(0, 0, 0, 0.1))),
    );
  }
}
