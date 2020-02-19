import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_easy/blocs/stock_bloc.dart';
import 'package:stock_easy/models/best_matches_stock_item.dart';
import 'package:stock_easy/ui/stock_details_page.dart';
import 'package:stock_easy/utils/widget_util.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  List<String> _defaultSearch = ['YES', 'IRC', 'INFO', 'VODA', 'FB'];
  var keyword = '';

  Widget appBarTitleFixed;
  Widget appBarTitle;

  Icon searchActionIcon = Icon(Icons.search);
  String searchActionIconHint = 'Search';

  @override
  void initState() {
    super.initState();
    appBarTitle = getAppBarTitle(18.0, 22.0);
    Future.delayed(Duration.zero, () {
      initScreenUtil(context);
      appBarTitleFixed =
          getAppBarTitle(ScreenUtil().setSp(18.0), ScreenUtil().setSp(22.0));
      appBarTitle = appBarTitleFixed;
    });
    updateKeyword(
        _defaultSearch[Random.secure().nextInt(_defaultSearch.length - 1)]);
  }

  @override
  void dispose() {
    stockBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initScreenUtil(context);
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
        elevation: ScreenUtil().setWidth(4.0),
        actions: <Widget>[
          IconButton(
            icon: searchActionIcon,
            color: Colors.white,
            tooltip: searchActionIconHint,
            onPressed: () {
              setState(
                () {
                  if (this.searchActionIcon.icon == Icons.search) {
                    this.searchActionIcon = Icon(Icons.close);
                    this.searchActionIconHint = 'Close';
                    this.appBarTitle = Container(
                      child: Row(
                        children: [
                          Icon(Icons.search),
                          SizedBox(
                            width: ScreenUtil().setWidth(12.0),
                          ),
                          Expanded(
                            child: TextField(
                              maxLines: 1,
                              autofocus: true,
                              cursorColor: Colors.white,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.search,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.words,
                              onSubmitted: (value) {
                                updateKeyword(value);
                              },
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(18.0),
                              ),
                              decoration: InputDecoration.collapsed(
                                /*prefixIcon: Icon(Icons.search, color: Colors.white),*/
                                hintText: "Search stock...",
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    this.searchActionIcon = Icon(Icons.search);
                    this.searchActionIconHint = 'Search';
                    this.appBarTitle = appBarTitleFixed;
                  }
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(8.0),
          right: ScreenUtil().setWidth(8.0),
        ),
        child: StreamBuilder(
          stream: stockBloc.stockSearchStream,
          builder: (context, AsyncSnapshot<MatchesStocks> snapshot) {
            if (snapshot.hasData) {
              return buildStockList(snapshot);
            } else if (snapshot.hasError) {
              return WidgetUtil.error(context, snapshot.error.toString(),
                  onRetry: () => searchKeyword());
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildStockList(AsyncSnapshot<MatchesStocks> snapshot) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data.bestMatchesStocks.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: ScreenUtil().setWidth(2.0),
          child: ListTile(
            contentPadding: EdgeInsets.only(
                left: ScreenUtil().setWidth(16.0),
                top: ScreenUtil().setWidth(8.0),
                right: ScreenUtil().setWidth(16.0),
                bottom: ScreenUtil().setWidth(8.0)),
            onTap: () {
              openStockDetails(snapshot.data.bestMatchesStocks[index]);
            },
            title: Text(snapshot.data.bestMatchesStocks[index].name),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: ScreenUtil().setHeight(8.0),
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Text(snapshot.data.bestMatchesStocks[index].type),
                    WidgetUtil.circularDot(
                        ScreenUtil().setWidth(4.0), ScreenUtil().setWidth(8.0)),
                    Text(snapshot.data.bestMatchesStocks[index].region),
                    WidgetUtil.circularDot(
                        ScreenUtil().setWidth(4.0), ScreenUtil().setWidth(8.0)),
                    Text(snapshot.data.bestMatchesStocks[index].symbol),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void searchKeyword() {
    stockBloc.search(keyword);
  }

  void updateKeyword(String value) {
    setState(() {
      keyword = value;
      searchKeyword();
    });
  }

  void openStockDetails(Stock stock) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => StockDetailsPage(stock: stock)));
  }
}

void initScreenUtil(BuildContext context) {
  final size = MediaQuery.of(context).size;
  ScreenUtil.init(context,
      width: size.width, height: size.height, allowFontScaling: true);
}

Widget getAppBarTitle(
  num defaultFontSize,
  num bigFontSize,
) {
  return RichText(
    text: TextSpan(
        style: TextStyle(color: Colors.white, fontSize: defaultFontSize),
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
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        ]),
  );
}
