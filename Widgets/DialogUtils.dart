import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ring_mobile/common_widgets/widgets.dart';
import 'package:ring_mobile/res/colors.dart';

class DialogUtils {
  static DialogUtils _instance = new DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static void showCustomOptionDialog(BuildContext context,
      {@required String title, @required Widget widget, String cancelBtnText = "cancel", @required Function cancelBtnFunction}) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
          titlePadding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 10),
          title: textSemiBold(title, color: Theme
              .of(context)
              .textTheme
              .bodyText2
              .color),
          contentPadding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
          content: Container(
            height: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget,
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: cancelBtnFunction,
                        child: Container(
                            child: Stack(
                              children: <Widget>[
                                Center(
                                    child: Text(cancelBtnText,
                                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: COLOR_WHITE)))
                              ],
                            ),
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(25.0)), color:COLOR_BG_RED)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }


}



