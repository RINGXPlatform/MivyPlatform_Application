import 'dart:io';

import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ring_mobile/common_widgets/common.dart';
import 'package:ring_mobile/common_widgets/common_widgets.dart';
import 'package:ring_mobile/common_widgets/widgets.dart';
import 'package:ring_mobile/contants/common.dart';
import 'package:ring_mobile/res/colors.dart';
import 'package:ring_mobile/res/image.dart';
import 'package:ring_mobile/translation/translations.dart';
import 'package:ring_mobile/ui/splash_screen.dart';

import 'home_page.dart';
import 'my_page_screen.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> with WidgetsBindingObserver {
  int selectedNavigationItem = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  double displayHeight;
  double displayWidth;
  double padding = 8.0;

  List _dList = [
    {"title": "마이 컨텐츠"},
    {"title": "위시 리스트"},
    {"title": "전자지갑"},
    {"title": "이용약관"}
  ];

  List<Widget> _children = [HomePage(), HomePage(), HomePage(), HomePage(), MyPage()];

  TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    displayWidth = MediaQuery.of(context).size.width;
    displayHeight = MediaQuery.of(context).size.height;
    final itemWidth = displayWidth / 5;

    return WillPopScope(
      onWillPop: () {
        exit(0);
        return Future.value(false);
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawerEnableOpenDragGesture: true,
        appBar: selectedNavigationItem == 0 ? _generalAppBar() : null,
        body: Stack(
          children: [
            Positioned(child: _children[selectedNavigationItem]),
            if (selectedNavigationItem == 0)
              Positioned(
                  child: GestureDetector(
                    onTap: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                    child: Card(
                      margin: EdgeInsets.only(left: 0),
                      elevation: 0.5,
                      child: Container(
                        width: 24.0,
                        height: displayHeight / 3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            border: Border.all(color: const Color(0x296b6b6b), width: 1),
                            boxShadow: [
                              BoxShadow(color: const Color(0x32000000), offset: Offset(0, 4), blurRadius: 10, spreadRadius: 0)
                            ],
                            color: const Color(0xffffffff)),
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                              border: Border.all(color: COLOR_GRAY, width: 1),
                            ),
                            width: 2.0,
                            height: 60,
                          ),
                        ),
                      ),
                    ),
                  ),
                  top: 20)
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                navigationItem(IMG_HOME_UNFILL, IMG_HOME_FILL, '홈', selectedNavigationItem == 0, itemWidth, () {
                  onBottomIconTap(0);
                }),
                navigationItem(IMG_FAVORITES_FILL, IMG_FAVORITES_UNFILL, '위시리스트', selectedNavigationItem == 1, itemWidth, () {
                  onBottomIconTap(1);
                }),
                navigationItem(IMG_LAYER_UNFILL, IMG_LAYER_FILL, '마이컨텐츠', selectedNavigationItem == 2, itemWidth, () {
                  onBottomIconTap(2);
                }),
                navigationItem(IMG_WALLET_UNFILL, IMG_WALLET_FILL, '전자지갑', selectedNavigationItem == 3, itemWidth, () {
                  onBottomIconTap(3);
                }),
                navigationItem(IMG_PROFILE_UNFILL, IMG_PROFILE_FILL, '마이페이지', selectedNavigationItem == 4, itemWidth, () {
                  onBottomIconTap(4);
                }),
              ],
            ),
          ),
        ),
        drawer: selectedNavigationItem == 0
            ? Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Container(
                      height: 200,
                      child: Stack(
                        overflow: Overflow.visible,
                        children: [
                          Positioned.fill(
                              child: DrawerHeader(
                            child: Container(
                              margin: EdgeInsets.only(left: 16),
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
                                          color: const Color(0xffffffff),
                                          style: TextStyle(
                                              color: const Color(0xffffffff),
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "NotoSansCJKkr",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 16.0)),
                                      textRegular("SS@gmail.com",
                                          color: Color(0xffffffff),
                                          style: TextStyle(
                                              color: const Color(0xffffffff),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "NotoSansCJKkr",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 13.0))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xff2274f4),
                            ),
                          )),
                          AlignPositioned(
                              dy: 15,
                              dx: -10,
                              alignment: Alignment.bottomCenter,
                              childWidth: displayWidth * 0.6,
                              childHeight: 65,
                              child: Container(
                                padding: EdgeInsets.only(left: 8.0, right: 8.0),
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
                    ListView.separated(
                      separatorBuilder: (context, index) {
                        return Container(
                            child: Divider(
                          height: 2,
                          thickness: 1,
                          color: Color(0xffe7e7e7),
                          indent: 40.0,
                          endIndent: 20.0,
                        ));
                      },
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _dList.length,
                      scrollDirection: Axis.vertical,
                      primary: true,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
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
                        );
                      },
                    ),
                    Container(
                        child: Divider(
                          height: 2,
                          thickness: 1,
                          color: Color(0xffe7e7e7),
                          indent: 40.0,
                          endIndent: 20.0,
                        ))
                  ],
                ),
              )
            : null,
      ),
    );
  }

  AppBar _generalAppBar() {
    return AppBar(
      backgroundColor: COLOR_TRANSPARENT,
      elevation: 0.0,
      brightness: Brightness.light,
      automaticallyImplyLeading: false,
      titleSpacing: 32.0,
      title: Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              IMG_BELL,
              width: displayWidth * 0.05,
              color: Color(0xFF2274f4),
            ),
            sizeBox(4.0),
            textRegular("공지",
                color: Color(0xff2274f4),
                style: TextStyle(
                    color: Color(0xff2274f4),
                    fontWeight: FontWeight.w500,
                    fontFamily: "NotoSansCJKkr",
                    fontStyle: FontStyle.normal,
                    fontSize: 15.0)),
            sizeBox(8.0),
            textRegular("서버 점검이 있습니다",
                style: const TextStyle(
                    color: const Color(0xff4a4a4a),
                    fontWeight: FontWeight.w400,
                    fontFamily: "NotoSansCJKkr",
                    fontStyle: FontStyle.normal,
                    fontSize: 15.0)),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: const Color(0xff2274f4),
              size: displayWidth * 0.05,
            )
          ],
        ),
      ),
      bottom: PreferredSize(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage(IMG_SEARCH_BG), fit: BoxFit.fill)),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 12.0),
              child: textFormField(context, controller, "검색할 내용을 입력해주세요", TextInputType.name,
                  size: Theme.of(context).textTheme.headline6.fontSize, suffixIcon: imageFromAsset(IMG_SEARCH)),
            ),
          ),
          preferredSize: Size.fromHeight(70.0)),
    );
  }

  Widget navigationItem(String image, String selectedImage, String title, bool isSelected, double itemWidth, var onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: itemWidth,
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: isSelected ? Color(0xFF2274f4) : Colors.transparent, width: 2.0)),
        ),
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.all(4.0),
              child: SvgPicture.asset(
                isSelected ? selectedImage : image,
                width: displayWidth * 0.08,
                color: isSelected ? Color(0xFF2274f4) : COLOR_BLACK,
              ),
            ),
            textSemiBold(title,
                style: TextStyle(
                    color: isSelected ? Color(0xff2274f4) : COLOR_TEXT_BLACK,
                    fontWeight: FontWeight.w700,
                    fontFamily: "NotoSansCJKkr",
                    fontStyle: FontStyle.normal,
                    fontSize: 12.0),
                alignment: TextAlign.center)
          ],
        ),
      ),
    );
  }

  void onBottomIconTap(int index) {
    setState(() {
      selectedNavigationItem = index;
    });
  }

  AppBar appBar() {}
}
