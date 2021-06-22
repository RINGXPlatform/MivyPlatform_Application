import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ring_mobile/common_widgets/common.dart';
import 'package:ring_mobile/common_widgets/common_widgets.dart';
import 'package:ring_mobile/common_widgets/widgets.dart';
import 'package:ring_mobile/contants/route.dart';
import 'package:ring_mobile/res/colors.dart';
import 'package:ring_mobile/res/image.dart';

class RegistrationCompleteScreen extends StatefulWidget {
  @override
  _RegistrationCompleteScreenState createState() => _RegistrationCompleteScreenState();
}

class _RegistrationCompleteScreenState extends State<RegistrationCompleteScreen> {
  var displayWidth = 0.0;

  ImageProvider logo = AssetImage(IMG_SPLASH_BG);

  @override
  void didChangeDependencies() {
    precacheImage(logo, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: COLOR_TRANSPARENT,
        centerTitle: true,
        title: textRegular("회원가입완료",
            color: const Color(0xff383838),
            style: TextStyle(
                color: const Color(0xff383838),
                fontWeight: FontWeight.w400,
                fontFamily: "NotoSans",
                fontStyle: FontStyle.normal,
                fontSize: 16.0),
            textAlign: TextAlign.center),
        leading: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(pi),
          child: Icon(Icons.arrow_forward_ios_outlined, size: displayWidth * 0.06, color: Color(0xFF2274f4)),
        ),
      ),
      body: Container(
        width: displayWidth,
        /*decoration: BoxDecoration(
            image: DecorationImage(
          image: logo,
          fit: BoxFit.fill,
        )),*/
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Spacer(
              flex: 2,
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
                    color: const Color(0xff707070),
                    fontWeight: FontWeight.w400,
                    fontFamily: "AppleSDGothicNeo",
                    fontStyle: FontStyle.normal,
                    fontSize: 16.0),
                textAlign: TextAlign.center),
            Spacer(
              flex: 1,
            ),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  style: const TextStyle(
                      color: const Color(0xff2274f4),
                      fontWeight: FontWeight.w700,
                      fontFamily: "AppleSDGothicNeo",
                      fontStyle: FontStyle.normal,
                      fontSize: 27.0),
                  text: "닉네임 님, "),
              TextSpan(
                  style: const TextStyle(
                      color: const Color(0xff232323),
                      fontWeight: FontWeight.w700,
                      fontFamily: "AppleSDGothicNeo",
                      fontStyle: FontStyle.normal,
                      fontSize: 27.0),
                  text: "안녕하세요!")
            ])),
            sizeHeight(8.0),
            Text("마이비의 회원이 되심을 감사드립니다.",
                style: const TextStyle(
                    color: const Color(0xff333333),
                    fontWeight: FontWeight.w300,
                    fontFamily: "AppleSDGothicNeo",
                    fontStyle: FontStyle.normal,
                    fontSize: 13.0)),
            sizeHeight(16.0),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed(APP_ROUTE_LOGIN_OPTIONS_SCREEN);
              },
              child: Container(
                width: displayWidth,
                padding: EdgeInsets.all(16.0),
                margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 38.0),
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: const Color(0xff2274f4)),
                child: textRegular("로그인",
                    style: const TextStyle(
                        color: const Color(0xffffffff),
                        fontWeight: FontWeight.w400,
                        fontFamily: "NotoSans",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0),
                    textAlign: TextAlign.center),
              ),
            ),
            Spacer(
              flex: 1,
            )
          ],
        ),
      ),
    );
  }
}
