import 'package:flutter/material.dart';

import 'constant.dart';

class CustomTextStyle {
  /// Custom Text black
  static var customTextStyle = TextStyle(
    color: Colors.black,
    fontFamily: AppConstants.FONT_FAMILY_GOTIK,
    fontSize: 17.0,
    fontWeight: FontWeight.w800,
  );

  /// Custom Text for Header title
  static var subHeaderCustomStyle = TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.w700,
      fontFamily: AppConstants.FONT_FAMILY_GOTIK,
      fontSize: 16.0);

  /// Custom Text for Detail title
  static var detailText = TextStyle(
      fontFamily: "Gotik",
      color: Colors.black54,
      letterSpacing: 0.3,
      wordSpacing: 0.5);
}