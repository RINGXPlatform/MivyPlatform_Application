import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ring_mobile/common_widgets/common.dart';
import 'package:ring_mobile/common_widgets/common_widgets.dart';
import 'package:ring_mobile/common_widgets/widgets.dart';
import 'package:ring_mobile/contants/route.dart';
import 'package:ring_mobile/res/colors.dart';
import 'package:ring_mobile/res/image.dart';

class SignUpOptionsScreen extends StatefulWidget {
  @override
  _SignUpOptionsScreenState createState() => _SignUpOptionsScreenState();
}

class _SignUpOptionsScreenState extends State<SignUpOptionsScreen> {
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
        title: textRegular("회원가입",
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
            textRegular("안녕하세요",
                style: const TextStyle(
                    color: const Color(0xff232323),
                    fontWeight: FontWeight.w300,
                    fontFamily: "AppleSDGothicNeo",
                    fontStyle: FontStyle.normal,
                    fontSize: 27.0),
                textAlign: TextAlign.center),
            textRegular("환영합니다!",
                style: const TextStyle(
                    color: const Color(0xff232323),
                    fontWeight: FontWeight.w700,
                    fontFamily: "AppleSDGothicNeo",
                    fontStyle: FontStyle.normal,
                    fontSize: 27.0),
                textAlign: TextAlign.center),
            sizeHeight(8.0),
            textRegular("어떤 방식으로 회원 가입을\n진행하시겠어요?",
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
            GestureDetector(
              onTap: () {},
              child: Container(
                width: displayWidth,
                padding: EdgeInsets.all(12.0),
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 38.0),
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: const Color(0xfffde200)),
                child: Row(
                  children: [
                    Spacer(),
                    SvgPicture.asset(IMG_TALK),
                    sizeBox(16.0),
                    textRegular("카카오로 로그인",
                        color: const Color(0xff3d1e20),
                        style: const TextStyle(
                            color: const Color(0xff3d1e20),
                            fontWeight: FontWeight.w400,
                            fontFamily: "AppleSDGothicNeo",
                            fontStyle: FontStyle.normal,
                            fontSize: 14.0),
                        textAlign: TextAlign.center),
                    Spacer(),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: displayWidth,
                padding: EdgeInsets.all(12.0),
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 38.0),
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: const Color(0xff1eb900)),
                child: Row(
                  children: [
                    Spacer(),
                    SvgPicture.asset(IMG_NAVER),
                    sizeBox(16.0),
                    textRegular("네이버로 로그인",
                        color: const Color(0xffffffff),
                        style: const TextStyle(
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w400,
                            fontFamily: "AppleSDGothicNeo",
                            fontStyle: FontStyle.normal,
                            fontSize: 14.0),
                        textAlign: TextAlign.center),
                    Spacer(),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: displayWidth,
                padding: EdgeInsets.all(12.0),
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 38.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: const Color(0xffe8e8e8), width: 1),
                ),
                child: Row(
                  children: [
                    Spacer(),
                    sizeBox(28.0),
                    SvgPicture.asset(IMG_GOOGLE),
                    sizeBox(16.0),
                    textRegular("구글 아이디로 로그인",
                        color: const Color(0x8a000000),
                        style: const TextStyle(
                            color: const Color(0x8a000000),
                            fontWeight: FontWeight.w400,
                            fontFamily: "AppleSDGothicNeo",
                            fontStyle: FontStyle.normal,
                            fontSize: 14.0),
                        textAlign: TextAlign.center),
                    Spacer(),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(APP_ROUTE_SIGNUP_SCREEN);
              },
              child: Opacity(
                opacity: 0.73,
                child: Container(
                  width: displayWidth,
                  padding: EdgeInsets.all(12.0),
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 38.0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: const Color(0xff2274f4)),
                  child: Row(
                    children: [
                      Spacer(),
                      Icon(
                        Icons.email_outlined,
                        color: COLOR_WHITE,
                      ),
                      sizeBox(16.0),
                      textRegular("이메일로 로그인",
                          color: const Color(0xffffffff),
                          style: const TextStyle(
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w400,
                              fontFamily: "AppleSDGothicNeo",
                              fontStyle: FontStyle.normal,
                              fontSize: 14.0),
                          textAlign: TextAlign.center),
                      Spacer(),
                    ],
                  ),
                ),
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
