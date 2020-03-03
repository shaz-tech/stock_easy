import 'package:flare_flutter/flare_actor.dart';
import 'package:flogger/flogger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_easy/ui/home_page.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Flogger().info('showing splash page');
    Future.delayed(
      Duration(
        seconds: 7,
      ),
      () {
        openHomePage(context);
      },
    );
    initScreenUtil(context);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              height: ScreenUtil().setHeight(300.0),
              width: ScreenUtil().setWidth(300.0),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).accentColor.withOpacity(0.5),
                child: ClipOval(
                  child: FlareActor(
                    "assets/splash.flr",
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                    animation: "Untitled",
                  ),
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(8.0),
            ),
            getTitle(
              context,
              ScreenUtil().setSp(24.0),
              ScreenUtil().setSp(28.0),
            ),
          ],
        ),
      ),
    );
  }

  void initScreenUtil(BuildContext context) {
    final size = MediaQuery.of(context).size;
    ScreenUtil.init(context,
        width: size.width, height: size.height, allowFontScaling: true);
  }

  Widget getTitle(
    BuildContext context,
    num defaultFontSize,
    num bigFontSize,
  ) {
    return Center(
      child: RichText(
        text: TextSpan(
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: defaultFontSize,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    offset: Offset(0.5, 0.5),
                    blurRadius: 1.0,
                  ),
                ]),
            children: [
              TextSpan(
                text: 'Stock',
                style: TextStyle(
                  fontSize: bigFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: ' Easy',
                style: TextStyle(
                  fontSize: bigFontSize,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ]),
      ),
    );
  }

  void openHomePage(BuildContext context) {
    /*Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => HomePage()),
        ModalRoute.withName('/'));*/
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => HomePage()),
    );
  }
}
