import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ring_mobile/common_widgets/common.dart';
import 'package:ring_mobile/common_widgets/common_widgets.dart';
import 'package:ring_mobile/common_widgets/widgets.dart';
import 'package:ring_mobile/res/colors.dart';
import 'package:ring_mobile/res/image.dart';

class TermsConditionScreen extends StatefulWidget {
  final Map<String, dynamic> arguments;

  TermsConditionScreen(this.arguments);

  @override
  _TermsConditionScreenState createState() => _TermsConditionScreenState();
}

class _TermsConditionScreenState extends State<TermsConditionScreen> {
  var map = {
    "kakao": {"image": IMG_TALK, "title": "카카오로그인", "color": Color(0xfffae202)},
    "naver": {"image": IMG_NAVER, "title": "네이버로 로그인", "color": Color(0xff1eb900)},
    "google": {"image": IMG_GOOGLE, "title": "구글로 로그인", "color": Color(0xffffffff)},
  };
  var displayWidth = 0.0;

  bool serviceCheck = false;
  bool termsCheck = false;
  bool infoCheck = false;
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    displayWidth = MediaQuery.of(context).size.width;

    Widget cardTerms = Card(
      color: const Color(0xffffffff),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), side: BorderSide(color: const Color(0x7e979797), width: 1)),
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(2)),
                              border: Border.all(color: const Color(0x7e979797), width: 1),
                              color: const Color(0xffffffff)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: getSvg(IMG_ICON_TRANSPARENT, width: displayWidth / 10, height: displayWidth / 10),
                          ),
                        ),
                        sizeBox(16.0),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textMedium("MIVY Platform",
                                color: const Color(0xff393939),
                                style: const TextStyle(
                                    color: const Color(0xff393939),
                                    fontWeight: FontWeight.w800,
                                    fontFamily: "AppleSDGothicNeo",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 15.0)),
                            sizeBox(8.0),
                            textRegular("Fun&fun Life Style",
                                color: const Color(0xff393939),
                                style: const TextStyle(
                                    color: const Color(0xff393939),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "AppleSDGothicNeo",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12.0))
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  sizeHeight(12.0),
                  Opacity(
                    opacity: 0.4,
                    child: Container(
                        height: 2, decoration: BoxDecoration(border: Border.all(color: const Color(0x3b3b3b3b), width: 1))),
                  ),
                  sizeHeight(12.0),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selected == 0) {
                          selected = 1;
                          serviceCheck = true;
                          termsCheck = true;
                          infoCheck = true;
                        } else {
                          selected = 0;
                          serviceCheck = false;
                          termsCheck = false;
                          infoCheck = false;
                        }
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                          radioButton(selected == 1, size: 22.0 , color : Color(0xffcccccc)),
                          sizeBox(12),
                          textRegular("약관 전체 동의",
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
                  ),
                  sizeHeight(12.0),
                  Opacity(
                    opacity: 0.4,
                    child: Container(
                        height: 2, decoration: BoxDecoration(border: Border.all(color: const Color(0x3b3b3b3b), width: 1))),
                  ),
                ],
              ),
            ),
            ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: CheckboxListTile(
                    value: serviceCheck,
                    onChanged: (value) {
                      setState(() {
                        serviceCheck = value;
                      });
                      checkGroup();
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    title: textRegular("서비스 이용동의",
                        color: const Color(0xff393939),
                        style: const TextStyle(
                            color: const Color(0xff393939),
                            fontWeight: FontWeight.w400,
                            fontFamily: "AppleSDGothicNeo",
                            fontStyle: FontStyle.normal,
                            fontSize: 13.0)),
                    checkColor: const Color(0xffffffff),
                    activeColor: const Color(0xff2274f4),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: CheckboxListTile(
                    value: termsCheck,
                    onChanged: (value) {
                      setState(() {
                        termsCheck = value;
                      });
                      checkGroup();
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    title: textRegular("개인정보 약관 동의 ",
                        color: const Color(0xff393939),
                        style: const TextStyle(
                            color: const Color(0xff393939),
                            fontWeight: FontWeight.w400,
                            fontFamily: "AppleSDGothicNeo",
                            fontStyle: FontStyle.normal,
                            fontSize: 13.0)),
                    checkColor: const Color(0xffffffff),
                    activeColor: const Color(0xff2274f4),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: CheckboxListTile(
                    value: infoCheck,
                    onChanged: (value) {
                      setState(() {
                        infoCheck = value;
                      });
                      checkGroup();
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    title: textRegular("마케팅 정보 동의",
                        color: const Color(0xff393939),
                        style: const TextStyle(
                            color: const Color(0xff393939),
                            fontWeight: FontWeight.w400,
                            fontFamily: "AppleSDGothicNeo",
                            fontStyle: FontStyle.normal,
                            fontSize: 13.0)),
                    checkColor: const Color(0xffffffff),
                    activeColor: const Color(0xff2274f4),
                  ),
                ),
              ],
            ),
            Opacity(
              opacity: 0.4,
              child:
                  Container(height: 2, decoration: BoxDecoration(border: Border.all(color: const Color(0x7e979797), width: 1))),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
                  border: Border.all(color: Colors.transparent, width: 1),
                  color: const Color(0xfff6f2f3)),
              height: 60,
              width: displayWidth,
              child: Center(
                child: textMedium("동의 후 계속하기",
                    color: const Color(0xff454545),
                    style: const TextStyle(
                        color: const Color(0xff454545),
                        fontWeight: FontWeight.w700,
                        fontFamily: "NotoSansCJKkr",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0),
                    textAlign: TextAlign.center),
              ),
            )
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: map[widget.arguments["key"]]["color"],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: COLOR_TRANSPARENT,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(
              flex: 2,
            ),
            SvgPicture.asset(
              map[widget.arguments["key"]]["image"],
              width: 24,
            ),
            sizeBox(16.0),
            textRegular("카카오로 로그인",
                color: widget.arguments["key"] == "naver" ? Color(0xffffffff) :Color(0xff3d1e20) ,
                style: TextStyle(
                    color: widget.arguments["key"] == "naver" ? Color(0xffffffff) :Color(0xff3d1e20),
                    fontWeight: FontWeight.w400,
                    fontFamily: "AppleSDGothicNeo",
                    fontStyle: FontStyle.normal,
                    fontSize: Theme.of(context).textTheme.bodyText2.fontSize),
                textAlign: TextAlign.center),
            sizeBox(16.0),
            Spacer(
              flex: 1,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: textRegular("닫기",
                  color: widget.arguments["key"] == "naver" ? Color(0xffffffff) : Color(0xff5c5c5c),
                  style: TextStyle(
                      color: widget.arguments["key"] == "naver" ? Color(0xffffffff) : Color(0xff5c5c5c),
                      fontWeight: FontWeight.w400,
                      fontFamily: "AppleSDGothicNeo",
                      fontStyle: FontStyle.normal,
                      fontSize: 14.0)),
            ),
            sizeBox(16.0),
          ],
        ),
      ),
      body: Container(
        width: displayWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Spacer(), cardTerms, Spacer(flex: 2)],
        ),
      ),
    );
  }

  void checkGroup() {
    if (serviceCheck && termsCheck && infoCheck) {
      setState(() {
        selected = 1;
      });
    } else {
      setState(() {
        selected = 0;
      });
    }
  }
}
