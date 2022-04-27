import 'package:flutter/material.dart';

/// basic colors
const kTeal50 = Color(0xFFE0F2F1);
const kTeal100 = Color(0xFF3FC1BE);

const kDefaultBackgroundAvatar = '3FC1BE';
const kDefaultTextColorAvatar = 'EEEEEE';
const kDefaultAdminBackgroundAvatar = 'EEEEEE';
const kDefaultAdminTextColorAvatar = '3FC1BE';

const kTeal400 = Color(0xFF26A69A);
const kGrey900 = Color(0xFF263238);
const kGrey600 = Color(0xFF546E7A);
const kGrey200 = Color(0xFFEEEEEE);
const kGrey400 = Color(0xFF90a4ae);
const kErrorRed = Color(0xFFe74c3c);
const kSurfaceWhite = Color(0xFFFFFBFA);
const kBackgroundWhite = Colors.white;

/// color for theme
const kLightPrimary = Color(0xfffcfcff);
const kLightAccent = Color(0xFF546E7A);
const kDarkAccent = Color(0xffF4F5F5);

const kLightBG = Color(0xffF1F2F3);
const kDarkBG = Color(0xff121212);
const kDarkBgLight = Color(0xff1E1E1E);
const kBadgeColor = Colors.red;

const kProductTitleStyleLarge =
const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

const kTextField = InputDecoration(
  hintText: 'Enter your value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(3.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(3.0)),
  ),
);

IconThemeData _customIconTheme(IconThemeData original) {
  return original.copyWith(color: kGrey900);
}

ThemeData buildLightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: kColorScheme,
    buttonColor: kTeal400,
    cardColor: Colors.white,
    textSelectionColor: kTeal100,
    errorColor: kErrorRed,
    buttonTheme: const ButtonThemeData(
      colorScheme: kColorScheme,
      textTheme: ButtonTextTheme.normal,
    ),
    primaryColorLight: kLightBG,
    primaryIconTheme: _customIconTheme(base.iconTheme),
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildTextTheme(base.accentTextTheme),
    iconTheme: _customIconTheme(base.iconTheme),
    hintColor: Colors.black26,
    backgroundColor: Colors.white,
    primaryColor: kLightPrimary,
    accentColor: kLightAccent,
    cursorColor: kLightAccent,
    scaffoldBackgroundColor: kLightBG,
    appBarTheme: AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
        title: TextStyle(
          color: kDarkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
      iconTheme: IconThemeData(
        color: kLightAccent,
      ),
    ),
  );
}

TextTheme _buildTextTheme(TextTheme base) {
  return base
      .copyWith(
    headline: base.headline
        .copyWith(fontWeight: FontWeight.w500, color: Colors.red),
    title: base.title.copyWith(fontSize: 18.0),
    caption: base.caption.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
    ),
    body2: base.body2.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 16.0,
    ),
    button: base.button.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
    ),
  )
      .apply(
    fontFamily: 'Raleway',
    displayColor: kGrey900,
    bodyColor: kGrey900,
  )
      .copyWith(headline: base.headline.copyWith(fontFamily: 'Roboto'));
}

const ColorScheme kColorScheme = ColorScheme(
  primary: kTeal100,
  primaryVariant: kGrey900,
  secondary: kTeal50,
  secondaryVariant: kGrey900,
  surface: kSurfaceWhite,
  background: kBackgroundWhite,
  error: kErrorRed,
  onPrimary: kGrey900,
  onSecondary: kGrey900,
  onSurface: kGrey900,
  onBackground: kGrey900,
  onError: kSurfaceWhite,
  brightness: Brightness.light,
);

ThemeData buildDarkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    cardColor: kDarkBgLight,
    brightness: Brightness.dark,
    backgroundColor: kDarkBG,
    primaryColor: kDarkBG,
    primaryColorLight: kDarkBgLight,
    accentColor: kDarkAccent,
    scaffoldBackgroundColor: kDarkBG,
    cursorColor: kDarkAccent,
    appBarTheme: AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
        title: TextStyle(
          color: kDarkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
      iconTheme: IconThemeData(
        color: kDarkAccent,
      ),
    ),
  );
}

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: kTeal400, width: 2.0),
  ),
);

const kSendButtonTextStyle = TextStyle(
  color: kTeal400,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);
