import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ring_mobile/common_widgets/common.dart';
import 'package:ring_mobile/common_widgets/common_widgets.dart';
import 'package:ring_mobile/common_widgets/widgets.dart';
import 'package:ring_mobile/contants/route.dart';
import 'package:ring_mobile/res/colors.dart';
import 'package:ring_mobile/res/image.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var displayWidth = 0.0;

  ImageProvider logo = AssetImage(IMG_SPLASH_BG);

  TextEditingController emailController;

  int selected = 0;

  @override
  void initState() {
    emailController = TextEditingController();
    super.initState();
  }

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
        title: textRegular("로그인",
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
        padding: EdgeInsets.only(left: 32.0, right: 32.0),
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
            textFormField(context, emailController, "이메일을 입력해주세요", TextInputType.name,
                size: 14.0, prefixIcon: Icon(Icons.email_outlined, color: const Color(0xff9f9f9f))),
            sizeHeight(12.0),
            textFormField(context, emailController, "비밀번호를 입력해주세요", TextInputType.name,
                size: 14.0, prefixIcon: Icon(Icons.lock_outlined, color: const Color(0xff9f9f9f))),
            sizeHeight(22.0),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(APP_ROUTE_LANDING_SCREEN);
              },
              child: Opacity(
                opacity: 0.80,
                child: Container(
                  width: displayWidth,
                  padding: EdgeInsets.all(16.0),
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
            ),
            sizeHeight(22.0),
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = selected == 0 ? 1 : 0;
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      radioIcon(selected == 1, size: 22.0),
                      sizeBox(12),
                      textRegular("자동로그인",
                          color: const Color(0xff393939),
                          style: TextStyle(
                              color: const Color(0xff393939),
                              fontWeight: FontWeight.w400,
                              fontFamily: "NotoSans",
                              fontStyle: FontStyle.normal,
                              fontSize: Theme.of(context).textTheme.bodyText2.fontSize))
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushNamed(APP_ROUTE_FORGOT_PASSWORD_SCREEN);
                  },
                  child: textRegular("비밀번호 찾기",
                      style: const TextStyle(
                          color: const Color(0xff444444),
                          fontWeight: FontWeight.w400,
                          fontFamily: "NotoSansCJKkr",
                          fontStyle: FontStyle.normal,
                          fontSize: 14.0),
                      textAlign: TextAlign.right),
                ),
              ],
            ),
            Spacer(
              flex: 2,
            ),
            GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed(APP_ROUTE_SIGN_UP_OPTIONS);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  textRegular("아직 회원이 아니신가요?",
                      color: const Color(0xff444444),
                      style: TextStyle(
                          color: const Color(0xff444444),
                          fontWeight: FontWeight.w400,
                          fontFamily: "NotoSansCJKkr",
                          fontStyle: FontStyle.normal,
                          fontSize: 14.0),
                      textAlign: TextAlign.right),
                  sizeBox(12),
                  textRegular("회원가입",
                      color: const Color(0xff2274f4),
                      style: const TextStyle(
                          color: const Color(0xff2274f4),
                          fontWeight: FontWeight.w400,
                          fontFamily: "NotoSansCJKkr",
                          fontStyle: FontStyle.normal,
                          fontSize: 14.0),
                      textAlign: TextAlign.right)
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
