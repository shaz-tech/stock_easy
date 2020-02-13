import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  final Widget appBarTitleFixed = RichText(
    text: TextSpan(
        style: TextStyle(color: Colors.white, fontSize: 18.0),
        children: [
          TextSpan(
            text: 'Stock',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: ' Easy',
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        ]),
  );

  Icon searchActionIcon = Icon(Icons.search);
  String searchActionIconHint = 'Search';

  Widget appBarTitle;

  @override
  void initState() {
    super.initState();
    appBarTitle = appBarTitleFixed;
    updateKeyword(_defaultSearch[Random.secure().nextInt(4)]);
  }

  @override
  void dispose() {
    stockBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
        elevation: 4.0,
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
                            width: 12.0,
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
                                fontSize: 18.0,
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
          left: 8.0,
          right: 8.0,
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
          elevation: 2.0,
          child: ListTile(
            contentPadding:
                EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
            onTap: () {
              openStockDetails(snapshot.data.bestMatchesStocks[index]);
            },
            title: Text(snapshot.data.bestMatchesStocks[index].name),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 8.0,
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Text(snapshot.data.bestMatchesStocks[index].type),
                    WidgetUtil.circularDot(4.0, 8.0),
                    Text(snapshot.data.bestMatchesStocks[index].region),
                    WidgetUtil.circularDot(4.0, 8.0),
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
