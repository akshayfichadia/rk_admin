import 'package:flutter/material.dart';
import 'hex_colors.dart';

Color greenButtonColor = HexColor("1ABC9C");
Color lightGreenColor = HexColor("F5FFFD");

Color greybackColor = HexColor("313131");
Color greylightColor = HexColor("757575");

Color bottombarColor = HexColor("505050");
Color lightBackColor = HexColor("A0A0A0");

InputDecoration drpdownFieldDecoration(
        {String? hintText, Widget? suffixIcon}) =>
    InputDecoration(
      counterText: "",
      contentPadding: EdgeInsets.zero,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: greybackColor),
        borderRadius: BorderRadius.circular(15.0),
      ),
      hintStyle: TextStyle(color: Colors.grey, fontFamily: "futur"),
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: greybackColor),
        borderRadius: BorderRadius.circular(15.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: greybackColor),
        borderRadius: BorderRadius.circular(15.0),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: greybackColor),
        borderRadius: BorderRadius.circular(15.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: greybackColor),
        borderRadius: BorderRadius.circular(15.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: greybackColor),
        borderRadius: BorderRadius.circular(15.0),
      ),
      fillColor: Colors.white,
      hintText: hintText,
      suffixIcon: Padding(
        padding: const EdgeInsets.all(7.0),
        child: suffixIcon,
      ),
      // prefixIcon: Padding(
      //   padding: const EdgeInsets.all(7.0),
      //   child: inkWell,
      // ),
      // prefixIconColor: Colors.grey
    );
