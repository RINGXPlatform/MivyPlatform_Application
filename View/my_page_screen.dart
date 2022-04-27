import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ring_mobile/common_widgets/common.dart';
import 'package:ring_mobile/common_widgets/common_widgets.dart';
import 'package:ring_mobile/common_widgets/widgets.dart';
import 'package:ring_mobile/contants/route.dart';
import 'package:ring_mobile/res/image.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  List _dList = [
    {"title": "고객센터", "logo": IMG_HEADPHONES},
    {"title": "자주 묻는 질문", "logo": IMG_MESSAGE},
    {"title": "이용약관", "logo": IMG_BOOKS}
  ];
  double displayWidth;

  @override
  Widget build(BuildContext context) {
    displayWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Column(
      children: <Widget>[
        Container(
          height: 240,
          child: Stack(
            overflow: Overflow.visible,
            children: [
              Positioned.fill(
                  child: DrawerHeader(
                    child: Container(
                      margin: EdgeInsets.only(left: 16, top: 16, right: 16),
                      alignment: Alignment.topLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          circleImage(AssetImage(IMG_USER), size: 100),
                          sizeBox(8),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              textMedium("호피폴라",
                                  color: const Color(0xff393939),
                                  style: TextStyle(
                                      color: const Color(0xff393939),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "NotoSansCJKkr",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16.0)),
                              textRegular("SS@gmail.com",
                                  color: Color(0xff393939),
                                  style: TextStyle(
                                      color: const Color(0xff393939),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "NotoSansCJKkr",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 13.0))
                            ],
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).pushNamed(APP_ROUTE_SET_NICKNAME_SCREEN);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [const Color(0xff3264f0), const Color(0xff0391fa)]),
                                    borderRadius: BorderRadius.all(Radius.circular(4))),
                                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                                child: textMedium("설정",
                                    color: Color(0xffffffff),
                                    style: const TextStyle(
                                        color: Color(0xffffffff),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "NotoSansCJKkr",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14.0),
                                    textAlign: TextAlign.center)),
                          )
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xfff4f9ff),
                    ),
                  )),
              AlignPositioned(
                  dy: 15,
                  alignment: Alignment.bottomCenter,
                  childWidth: displayWidth,
                  childHeight: 65,
                  child: Container(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    margin: EdgeInsets.only(left: 24.0, right: 24.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        border: Border.all(color: const Color(0xffdddddd), width: 1),
                        color: const Color(0xffffffff)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        textRegular("나의 콩 마일리지",
                            color: const Color(0xff393939),
                            style: TextStyle(
                                color: const Color(0xff393939),
                                fontWeight: FontWeight.w300,
                                fontFamily: "NotoSansCJKkr",
                                fontStyle: FontStyle.normal,
                                fontSize: 15.0)),
                        Spacer(),
                        SvgPicture.asset(IMG_COIN, width: displayWidth * 0.08, color: Color(0xFF2274f4)),
                        sizeBox(4),
                        textMedium("53,213 원",
                            color: const Color(0xff393939),
                            style: TextStyle(
                                color: const Color(0xff393939),
                                fontWeight: FontWeight.w500,
                                fontFamily: "NotoSansCJKkr",
                                fontStyle: FontStyle.normal,
                                fontSize: 16.0)),
                      ],
                    ),
                  ))
            ],
          ),
        ),
        sizeHeight(24),
        Container(
          height: 65,
          margin: EdgeInsets.only(left: 24.0, right: 24.0),
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              border: Border.all(color: const Color(0xffdddddd), width: 1),
              color: const Color(0xffeff6ff)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.card_giftcard_outlined,
                size: 36,
                color: Color(0xFF2274f4),
              ),
              sizeBox(12),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textMedium("친구 초대하기",
                      color: const Color(0xff2274f4),
                      style: const TextStyle(
                          color: const Color(0xff2274f4),
                          fontWeight: FontWeight.w500,
                          fontFamily: "NotoSansCJKkr",
                          fontStyle: FontStyle.normal,
                          fontSize: 16.0)),
                  textRegular("2,000 콩 마일리지 받기",
                      color: const Color(0xff393939),
                      style: const TextStyle(
                          color: const Color(0xff393939),
                          fontWeight: FontWeight.w400,
                          fontFamily: "NotoSansCJKkr",
                          fontStyle: FontStyle.normal,
                          fontSize: 12.0)),
                ],
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios_outlined,
                size: 22,
                color: Color(0xFF2274f4),
              ),
            ],
          ),
        ),
        ListView.separated(
          separatorBuilder: (context, index) {
            return Container(
                child: Divider(
                  height: 2,
                  thickness: 1,
                  color: Color(0xffe7e7e7),
                ));
          },
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _dList.length,
          scrollDirection: Axis.vertical,
          primary: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: ListTile(
                leading: getSvg(_dList[index]["logo"], width: 32, height: 32, color: Color(0xff696969)),
                title: textRegular(_dList[index]["title"],
                    color: Color(0xff5d5d5d),
                    style: TextStyle(
                        color: const Color(0xff5d5d5d),
                        fontWeight: FontWeight.w400,
                        fontFamily: "NotoSansCJKkr",
                        fontStyle: FontStyle.normal,
                        fontSize: 13.0)),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: const Color(0xff2274f4),
                  size: displayWidth * 0.04,
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            );
          },
        ),
        Container(
            child: Divider(
              height: 2,
              thickness: 1,
              color: Color(0xffe7e7e7),
            )),
        Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.all(24),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textRegular("로그아웃",
                    color: const Color(0xff393939),
                    style: const TextStyle(
                        color: const Color(0xff393939),
                        fontWeight: FontWeight.w400,
                        fontFamily: "NotoSansCJKkr",
                        fontStyle: FontStyle.normal,
                        fontSize: 12.0),
                    textAlign: TextAlign.center),
                sizeBox(8),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: displayWidth * 0.04,
                  color: Color(0xff6f6f6f),
                )
              ],
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)), border: Border.all(color: const Color(0xffdddddd), width: 1)))

      ],
    );
  }
}
