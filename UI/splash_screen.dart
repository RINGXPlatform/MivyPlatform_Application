import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ring_mobile/common_widgets/common.dart';
import 'package:ring_mobile/common_widgets/common_widgets.dart';
import 'package:ring_mobile/common_widgets/widgets.dart';
import 'package:ring_mobile/contants/route.dart';
import 'package:ring_mobile/data/app_preferences.dart';
import 'package:ring_mobile/res/image.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ImageProvider logo = AssetImage(IMG_SPLASH_BG);

  @override
  void initState() {
    super.initState();
    startTime();
  }

  var displayWidth = 0.0;

  @override
  void didChangeDependencies() {
    precacheImage(logo, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: displayWidth,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: logo,
          fit: BoxFit.fill,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Spacer(
              flex: 1,
            ),
            getSvg(IMG_ICON_TRANSPARENT, width: displayWidth / 4, height: displayWidth / 4),
            sizeHeight(20.0),
            textBold("MIVY",
                alignment: TextAlign.center,
                style: TextStyle(
                    color: const Color(0xff112d7b),
                    fontWeight: FontWeight.w900,
                    fontFamily: "Arial",
                    fontStyle: FontStyle.normal,
                    fontSize: 30.0)),
            sizeHeight(8.0),
            textRegular("세상의 모든 포인트를 한 곳에!",
                style: const TextStyle(
                    color: const Color(0xff3264f0),
                    fontWeight: FontWeight.w400,
                    fontFamily: "AppleSDGothicNeo",
                    fontStyle: FontStyle.normal,
                    fontSize: 16.0),
                textAlign: TextAlign.center),
            Spacer(
              flex: 2,
            )
          ],
        ),
      ),
    );
  }

  void navigateToScreen() {
    Navigator.of(context).pushReplacementNamed(APP_ROUTE_LOGIN_OPTIONS_SCREEN);
  }

  startTime() {
    var _duration = Duration(seconds: 3);
    return Timer(_duration, navigateToScreen);
  }
}
