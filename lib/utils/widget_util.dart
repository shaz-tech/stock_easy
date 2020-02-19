import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WidgetUtil {
  static Widget circularDot(double size, double margin) => Container(
        height: size,
        width: size,
        margin: EdgeInsets.only(left: margin, right: margin),
        decoration: BoxDecoration(
          color: Colors.grey.shade600,
          shape: BoxShape.circle,
        ),
      );

  static Widget error(
    BuildContext context,
    String errorMessage, {
    VoidCallback onRetry,
  }) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(ScreenUtil().setWidth(16.0)),
          height: ScreenUtil().setHeight(200.0),
          child: Text(
            errorMessage,
            style: TextStyle(
                color: Colors.grey, fontSize: ScreenUtil().setSp(16.0)),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(16.0),
        ),
        RaisedButton(
          onPressed: () => onRetry(),
          color: Theme.of(context).accentColor,
          child: Text(
            'Retry',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    ));
  }

  static Widget getSnackbar(String message) {
    return new SnackBar(
      content: Text(message),
    );
  }
}
