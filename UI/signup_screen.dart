import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ring_mobile/common_widgets/common.dart';
import 'package:ring_mobile/common_widgets/common_widgets.dart';
import 'package:ring_mobile/common_widgets/widgets.dart';
import 'package:ring_mobile/contants/route.dart';
import 'package:ring_mobile/res/colors.dart';
import 'package:ring_mobile/res/image.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var displayWidth = 0.0;

  ImageProvider logo = AssetImage(IMG_SPLASH_BG);
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController;

  int selected_payment = 0;
  int selected_services = 1;
  int selected_main = 0;

  bool servicesExpanded = true;
  bool paymentExpanded = false;

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
      extendBodyBehindAppBar: false,
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
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(left: 24, top: 16, right: 24, bottom: 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight, minWidth: viewportConstraints.maxWidth),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sizeHeight(12),
                      Wrap(
                        children: [
                          textRegular("이메일",
                              color: const Color(0xff292929),
                              style: const TextStyle(
                                  color: const Color(0xff292929),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "NotoSansCJKkr",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 13.0)),
                          sizeBox(8.0),
                          textRegular("중복된 이메일이 있습니다",
                              color: const Color(0xff2274f4),
                              style: const TextStyle(
                                  color: const Color(0xff2274f4),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "NotoSansCJKkr",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 13.0)),
                        ],
                      ),
                      sizeHeight(8),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: textFormField(context, emailController, "이메일을 입력해주세요", TextInputType.name,
                                size: 14.0, prefixIcon: Icon(Icons.email_outlined, color: const Color(0xff9f9f9f))),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(APP_ROUTE_REGISRATION_COMPLETE_SCREEN);
                            },
                            child: Container(
                              padding: EdgeInsets.all(18.0),
                              margin: EdgeInsets.only(left: 4.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)), color: const Color(0xff2274f4)),
                              child: textRegular("중복확인",
                                  style: const TextStyle(
                                      color: const Color(0xffffffff),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "NotoSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0),
                                  textAlign: TextAlign.center),
                            ),
                          )
                        ],
                      ),
                      sizeHeight(22),
                      Wrap(
                        children: [
                          textRegular("비밀번호",
                              color: const Color(0xff292929),
                              style: const TextStyle(
                                  color: const Color(0xff292929),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "NotoSansCJKkr",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 13.0)),
                          sizeBox(8.0),
                          textRegular("비밀번호를 다시 한 번 확인해주세요",
                              color: const Color(0xff2274f4),
                              style: const TextStyle(
                                  color: const Color(0xff2274f4),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "NotoSansCJKkr",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 13.0)),
                        ],
                      ),
                      sizeHeight(8),
                      textFormField(context, emailController, "비밀번호를 입력해주세요", TextInputType.name,
                          size: 14.0, prefixIcon: Icon(Icons.lock_outlined, color: const Color(0xff9f9f9f))),
                      sizeHeight(8),
                      textFormField(context, emailController, "비밀번호를 입력해주세요", TextInputType.name,
                          size: 14.0, prefixIcon: Icon(Icons.lock_outlined, color: const Color(0xff9f9f9f))),
                      sizeHeight(18),
                      textRegular("닉네임",
                          color: const Color(0xff292929),
                          style: const TextStyle(
                              color: const Color(0xff292929),
                              fontWeight: FontWeight.w400,
                              fontFamily: "NotoSansCJKkr",
                              fontStyle: FontStyle.normal,
                              fontSize: 13.0)),
                      sizeHeight(8),
                      textFormField(context, emailController, "닉네임을 입력해주세요", TextInputType.name,
                          size: 14.0, prefixIcon: Icon(Icons.person_outlined, color: const Color(0xff9f9f9f))),
                      sizeHeight(24),
                      textRegular("이용 약관",
                          color: const Color(0xff292929),
                          style: const TextStyle(
                              color: const Color(0xff292929),
                              fontWeight: FontWeight.w400,
                              fontFamily: "NotoSansCJKkr",
                              fontStyle: FontStyle.normal,
                              fontSize: 13.0)),
                      sizeHeight(22),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selected_main == 0) {
                              selected_main = 1;
                              selected_services = 1;
                              selected_payment = 1;
                            } else {
                              selected_main = 0;
                              selected_payment = 0;
                              selected_services = 0;
                            }
                            ;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              radioIcon(selected_main == 1, size: 22.0),
                              sizeBoxV(size: 12),
                              textRegular("Agree to our Terms and Conditions",
                                  color: const Color(0xff393939),
                                  style: TextStyle(
                                      color: const Color(0xff393939),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "NotoSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: Theme.of(context).textTheme.bodyText2.fontSize)),
                            ],
                          ),
                        ),
                      ),
                      sizeHeight(8),
                      Visibility(
                        visible: paymentExpanded ? false : true,
                        child: Opacity(
                          opacity: 0.3944847470238095,
                          child: Container(
                              width: 359,
                              height: 2,
                              decoration: BoxDecoration(border: Border.all(color: const Color(0x51979797), width: 1))),
                        ),
                      ),
                      ExpansionTile(
                        maintainState: true,
                        onExpansionChanged: (val){
                          setState(() {
                            paymentExpanded = val;
                          });
                        },
                        title: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selected_payment = selected_payment == 0 ? 1 : 0;
                                    });
                                    checkGroup();
                                  },
                                  child: radioIcon(selected_payment == 1, size: 22.0)),
                              sizeBoxV(size: 12),
                              textRegular("Agree to Use of Payment feature",
                                  color: const Color(0xff393939),
                                  style: TextStyle(
                                      color: const Color(0xff393939),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "NotoSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: Theme.of(context).textTheme.bodyText2.fontSize)),
                            ],
                          ),
                        ),
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0.0),
                            child: ListTile(
                              title: textRegular(
                                  "Consent to Use Location InformationConsent to Use Location InformationConsent to Use Location InformationConsent to Use Location InformationConsent to Use Location InformationConsent to Use Location InformationConsent to Use Location InformationConsent to Use Location InformationConsent to Use Location InformationConsent to Use Location InformationConsent to Use Location InformationConsent to Use Location Information",
                                  color: const Color(0xff4d4d4d),
                                  style: const TextStyle(
                                      color: const Color(0xff4d4d4d),
                                      fontWeight: FontWeight.w300,
                                      fontFamily: "NotoSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12.0)),
                            ),
                          )
                        ],
                      ),
                      Visibility(
                        visible: servicesExpanded ? false : (paymentExpanded? false : true),
                          child: Opacity(
                        opacity: 0.3944847470238095,
                        child: Container(
                            width: 359,
                            height: 2,
                            decoration: BoxDecoration(border: Border.all(color: const Color(0x51979797), width: 1))),
                      )),
                      ExpansionTile(
                        onExpansionChanged: (val){
                          setState(() {
                            servicesExpanded = val;
                          });
                        },
                        initiallyExpanded: true,
                        maintainState: true,
                        title: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selected_services = selected_services == 0 ? 1 : 0;
                                    });
                                    checkGroup();
                                  },
                                  child: radioIcon(selected_services == 1, size: 22.0)),
                              sizeBoxV(size: 12),
                              textRegular("Agree to Services",
                                  color: const Color(0xff393939),
                                  style: TextStyle(
                                      color: const Color(0xff393939),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "NotoSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: Theme.of(context).textTheme.bodyText2.fontSize)),
                            ],
                          ),
                        ),
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0.0),
                            child: ListTile(
                              title: textRegular(
                                  "Consent to Use Location InformationConsent to Use Location InformationConsent to Use Location InformationConsent to Use Location InformationConsent to Use Location InformationConsent to Use Location InformationConsent to Use Location InformationConsent to Use Location InformationConsent to Use Location InformationConsent to Use Location InformationConsent to Use Location InformationConsent to Use Location Information",
                                  color: const Color(0xff4d4d4d),
                                  style: const TextStyle(
                                      color: const Color(0xff4d4d4d),
                                      fontWeight: FontWeight.w300,
                                      fontFamily: "NotoSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12.0)),
                            ),
                          )
                        ],
                      ),
                      sizeHeight(8),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(APP_ROUTE_REGISRATION_COMPLETE_SCREEN);
              },
              child: Container(
                width: displayWidth,
                padding: EdgeInsets.all(16.0),
                margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 38.0),
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: const Color(0xff2274f4)),
                child: textRegular("완료",
                    style: const TextStyle(
                        color: const Color(0xffffffff),
                        fontWeight: FontWeight.w400,
                        fontFamily: "NotoSans",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0),
                    textAlign: TextAlign.center),
              ),
            )
          ],
        ),
      ),
    );
  }

  void checkGroup() {
    (selected_payment == 1 && selected_services == 1) ? selected_main = 1 : selected_main = 0;
  }
}
