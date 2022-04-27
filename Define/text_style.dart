import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonStyle {

  static TextStyle getAppFont({Color color,
    double fontSize,
    FontWeight fontWeight,
    FontStyle fontStyle,
    TextDecoration decoration,
    double letterSpacing}) {
    return GoogleFonts.poppins(
      textStyle: TextStyle(
          color: color,
          letterSpacing: letterSpacing == null ? 0.3 : letterSpacing,
          decoration: decoration != null ? decoration : TextDecoration.none),
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle == null ? FontStyle.normal : fontStyle,
    );
  }

  static TextStyle getNotoSans({Color color,
    double fontSize,
    FontWeight fontWeight,
    FontStyle fontStyle,
    TextDecoration decoration,
    double letterSpacing}) {
    return GoogleFonts.notoSans(
      textStyle: TextStyle(
          color: color,
          letterSpacing: letterSpacing == null ? 0.3 : letterSpacing,
          decoration: decoration != null ? decoration : TextDecoration.none),
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle == null ? FontStyle.normal : fontStyle,
    );
  }

  static getNotoSansCJKkr(
      {Color color, FontWeight fontWeight, double letterSpacing, String fontFamily, FontStyle fontStyle, double fontSize, TextDecoration decoration}) {

    return GoogleFonts.notoSansKR(
      textStyle: TextStyle(
        color: color,
        letterSpacing: letterSpacing == null ? 0.3 : letterSpacing,
        decoration: decoration != null ? decoration : TextDecoration.none,
        fontSize: fontSize,
          fontWeight: fontWeight,
        fontStyle: fontStyle == null ? FontStyle.normal : fontStyle,
      )
    );
  }
}
