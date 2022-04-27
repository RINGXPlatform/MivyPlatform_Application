import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ring_mobile/common_widgets/common.dart';
import 'package:ring_mobile/common_widgets/widgets.dart';
import 'package:ring_mobile/res/colors.dart';
import 'package:ring_mobile/res/image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double displayHeight;
  double displayWidth;
  double padding = 8.0;

  List _gridList = [
    {"title": "비디오", "image": IMG_PIC_ONE},
    {"title": "음악", "image": IMG_PIC_TWO},
    {"title": "게임아이템", "image": IMG_PIC_THREE},
    {"title": "웹툰", "image": IMG_PIC_FOUR},
  ];

  List _hList = [
    {"title": "사막 여행 투어 영상", "image": IMG_PIC_FOUR},
    {"title": "한옥마을 풍경", "image": IMG_PIC_ONE},
    {"title": "사막 여행 투어 영상", "image": IMG_PIC_TWO}
  ];

  List _vList = [
    {"title": "아시아 경제 네이버 뉴스 구독", "desc": "네이버 뉴스 구독", "image": IMG_V_ONE , "distance" : "80KM"},
    {"title": "한국리서치 패널 모집[60세이상]", "desc": "패널 가입완료", "image": IMG_V_TWO, "distance" : "500KM"},
    {"title": "sk텔레콤 유투브 구독하기", "desc": "유투브 구독완료", "image": IMG_V_THREE, "distance" : "70KM"},
  ];

  @override
  Widget build(BuildContext context) {
    displayWidth = MediaQuery.of(context).size.width;
    displayHeight = MediaQuery.of(context).size.height;

    Widget titleSection = Container(
      padding: const EdgeInsets.only(left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: textSemiBold("새로운 컨텐츠",
                color : Color(0xff212121),
                style: TextStyle(
                    color: Color(0xff212121),
                    fontWeight: FontWeight.w600,
                    fontFamily: "NotoSansCJKkr",
                    fontStyle: FontStyle.normal,
                    fontSize: Theme.of(context).textTheme.headline6.fontSize)),
          ),
          centerImage(),
          Container(width: displayWidth, height: 16, decoration: BoxDecoration(color: const Color(0xfff4f6f8))),
          sizeHeight(12.0),
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: textSemiBold("다양한 컨텐츠를 즐겨 보세요",
                color : Color(0xff212121),
                style: TextStyle(
                    color: Color(0xff212121),
                    fontWeight: FontWeight.w600,
                    fontFamily: "NotoSansCJKkr",
                    fontStyle: FontStyle.normal,
                    fontSize: Theme.of(context).textTheme.headline6.fontSize)),
          ),
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;
    var width = MediaQuery.of(context).size.width / 2;
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    Widget gridSection = Container(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _gridList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 12,
          childAspectRatio: ((itemHeight - 100) / (itemWidth + 5)),
        ),
        primary: true,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        child: Stack(
                      children: [
                        Positioned.fill(child: imageFromAsset(_gridList[index]["image"], fit: BoxFit.fill)),
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [const Color(0xff3264f0), const Color(0xff0391fa)]),
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(4))),
                              padding: EdgeInsets.all(8.0),
                              child: textMedium(_gridList[index]["title"],
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
                    ))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
    Widget listSection = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sizeHeight(12.0),
          Container(width: displayWidth, height: 16, decoration: BoxDecoration(color: const Color(0xfff4f6f8))),
          sizeHeight(8.0),
          Container(
            padding: const EdgeInsets.only(left: 24, top: 8.0, bottom: 8.0),
            child: textSemiBold("공유 컨텐츠를 무료로!",
                color : Color(0xff212121),
                style: TextStyle(
                    color: Color(0xff212121),
                    fontWeight: FontWeight.w600,
                    fontFamily: "NotoSansCJKkr",
                    fontStyle: FontStyle.normal,
                    fontSize: Theme.of(context).textTheme.headline6.fontSize)),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            padding: EdgeInsets.only(left: 12.0, right: 12.0),
            child: ListView.builder(
              itemCount: _hList.length,
              scrollDirection: Axis.horizontal,
              primary: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.only(left: 4.0, right: 4.0),
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                Positioned.fill(child: imageFromAsset(_gridList[index]["image"], fit: BoxFit.fill)),
                                Align(
                                  alignment: Alignment.center,
                                  child: circleImage(AssetImage(IMG_PLAY), size: 80),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: textRegular(_hList[index]["title"],
                                color: Color(0xff424242),
                                style: TextStyle(
                                    color: Color(0xff424242),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "AppleSDGothicNeo",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 15.0)),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );

    Widget vListSection = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sizeHeight(12.0),
          Container(width: displayWidth, height: 16, decoration: BoxDecoration(color: const Color(0xfff4f6f8))),
          Container(
            padding: const EdgeInsets.only(left: 24, top: 8.0, bottom: 8.0),
            child: textSemiBold("콩마일리지 무료적립",
                style: TextStyle(
                    color: Color(0xff212121),
                    fontWeight: FontWeight.w600,
                    fontFamily: "NotoSansCJKkr",
                    fontStyle: FontStyle.normal,
                    fontSize: Theme.of(context).textTheme.headline6.fontSize)),
          ),
          Container(
            padding: EdgeInsets.only(left: 12.0, right: 12.0),
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return index != _vList.length
                    ? Container(
                        padding: EdgeInsets.only(left: 8.0, right: 12.0),
                        child: Divider(
                          height: 2,
                          color: Color(0xffe7e7e7),
                        ))
                    : null;
              },
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _vList.length,
              scrollDirection: Axis.vertical,
              primary: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.only(left: 8.0, right: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      squareImageFromAsset(_vList[index]["image"], size: 80),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textMedium(_vList[index]["title"],
                              overflow: TextOverflow.ellipsis,
                              color: Color(0xff393939),
                              style: TextStyle(
                                  color: Color(0xff393939),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "NotoSansCJKkr",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 15)),
                          Wrap(
                            children: [
                              textRegular("무료",
                                  color: Color(0xff2274f4),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff2274f4),
                                      fontFamily: "NotoSansCJKkr",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 13.0)),
                              sizeBox(8.0),
                              textRegular(_vList[index]["desc"],
                                  color: Color(0xff6e6e6e),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff6e6e6e),
                                      fontFamily: "NotoSansCJKkr",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 13.0)),
                            ],
                          )
                        ],
                      ),
                      Spacer(),
                      Container(
                        width: displayWidth * 0.18,
                        padding: EdgeInsets.all(12.0),
                        decoration:
                            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: const Color(0xff2274f4)),
                        child: textRegular(_vList[index]["distance"],
                            style: const TextStyle(
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w300,
                                fontFamily: "AppleSDGothicNeo",
                                fontStyle: FontStyle.normal,
                                fontSize: 14.0),
                            textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );

    return Scaffold(
      body: ListView(
        children: [
          titleSection,
          gridSection,
          listSection,
          vListSection,
        ],
      ),
    );
  }

  Widget centerImage() {
    final controller = PageController(viewportFraction: 1);

    return SizedBox(
      width: displayWidth,
      height: displayHeight / 3.5,
      child: Stack(
        children: [
          PageView(
            pageSnapping: true,
            controller: controller,
            children: List.generate(
                3,
                (_) => Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0.0),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: imageFromAsset(IMG_SLIDER, fit: BoxFit.fill),
                            ),
                            Positioned.fill(
                              child: Container(
                                padding: EdgeInsets.only(bottom: 30.0, left: 12.0),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      stops: [0.1, 0.6],
                                      colors: [Color(0xD4000b11), Colors.transparent]),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    textBold("초능력자들",
                                        style: TextStyle(
                                            color: const Color(0xffffffff),
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "NotoSansCJKkr",
                                            fontStyle: FontStyle.normal,
                                            fontSize: Theme.of(context).textTheme.headline5.fontSize)),
                                    textRegular("초능력 하나를 얻을 수 있다면, \n당신의 선택은?",
                                        style: TextStyle(
                                            color: const Color(0xffffffff),
                                            fontWeight: FontWeight.w300,
                                            fontFamily: "NotoSansCJKkr",
                                            fontStyle: FontStyle.normal,
                                            fontSize: Theme.of(context).textTheme.bodyText2.fontSize))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.bottomCenter,
            child: SmoothPageIndicator(
              controller: controller,
              count: 3,
              effect: ColorTransitionEffect(
                spacing: 20.0,
                radius: 8.0,
                dotWidth: 10.0,
                dotHeight: 10.0,
                dotColor: Color(0xffffffff),
                paintStyle: PaintingStyle.fill,
                strokeWidth: 1,
                activeDotColor: Color(0xff2274f4),
              ),
            ),
          )
        ],
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
