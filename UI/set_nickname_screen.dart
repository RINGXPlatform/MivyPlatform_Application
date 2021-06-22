import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ring_mobile/common_widgets/common.dart';
import 'package:ring_mobile/common_widgets/widgets.dart';
import 'package:ring_mobile/res/colors.dart';

class SetNicknameScreen extends StatefulWidget {
  @override
  _SetNicknameScreenState createState() => _SetNicknameScreenState();
}

class _SetNicknameScreenState extends State<SetNicknameScreen> {
  var displayWidth = 0.0;

  final formKey = GlobalKey<FormState>();

  TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
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
        title: textRegular("닉네임 변경",
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
                      textRegular("닉네임",
                          color: const Color(0xff292929),
                          style: const TextStyle(
                              color: const Color(0xff292929),
                              fontWeight: FontWeight.w400,
                              fontFamily: "NotoSansCJKkr",
                              fontStyle: FontStyle.normal,
                              fontSize: 13.0)),
                      sizeHeight(8),
                      textFormField(context, controller, "닉네임을 입력해주세요", TextInputType.name,
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
                      sizeHeight(16),
                      Container(
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
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
