import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_easy/blocs/stock_bloc_details.dart';
import 'package:stock_easy/models/best_matches_stock_item.dart';
import 'package:stock_easy/models/stock_details_daily_item.dart';
import 'package:stock_easy/ui/providers/inherit_widget_stock_details_bloc_provider.dart';
import 'package:stock_easy/ui/providers/inherit_widget_stock_provider.dart';
import 'package:stock_easy/ui/widgets/custom_radio_button.dart';
import 'package:stock_easy/ui/widgets/simple_time_series_chart.dart';
import 'package:stock_easy/utils/widget_util.dart';

class StockDetailsPage extends StatefulWidget {
  final Stock stock;

  StockDetailsPage({@required this.stock});

  @override
  State<StatefulWidget> createState() {
    print('createState');
    return StockDetailsPageState();
  }
}

class StockDetailsPageState extends State<StockDetailsPage> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final size = MediaQuery.of(context).size;
      ScreenUtil.init(context,
          width: size.width, height: size.height, allowFontScaling: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: AppBarTitle(),
      ),
      body: Container(
        child: StockWidgetProvider(
          stock: widget.stock,
          child:
              StockDetailsBlocProvider(child: StockDetailsBody(_scaffoldKey)),
        ),
      ),
    );
  }
}

class AppBarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Details',
      style: TextStyle(
        fontSize: ScreenUtil().setSp(22.0),
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}

class StockDetailsBody extends StatefulWidget {
  final selectedDaysNotifier = new ValueNotifier(3);
  final GlobalKey<ScaffoldState> _scaffoldKey;

  StockDetailsBody(this._scaffoldKey);

  @override
  _StockDetailsBodyState createState() => _StockDetailsBodyState();
}

class _StockDetailsBodyState extends State<StockDetailsBody> {
  StockDetailsBloc stockDetailsBloc;
  var lowHigh = true;
  final listDays = generateDaysList();
  ValueListenable<int> selectedDaysListenable;
  var stockProvider;

  @override
  void dispose() {
    stockDetailsBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    selectedDaysListenable = widget.selectedDaysNotifier;
  }

  @override
  void didChangeDependencies() {
    stockProvider = StockWidgetProvider.of(context);
    stockDetailsBloc = StockDetailsBlocProvider.of(context);
    fetchDetails();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueListenableBuilder<int>(
        valueListenable: widget.selectedDaysNotifier,
        builder: (BuildContext context, int value, Widget child) {
          return StreamBuilder(
            stream: stockDetailsBloc.stockDetails,
            builder: (context, AsyncSnapshot<Future<DailyStockItem>> snapShot) {
              if (snapShot.hasData) {
                return FutureBuilder(
                    future: snapShot.data,
                    builder:
                        (context, AsyncSnapshot<DailyStockItem> itemSnapShot) {
                      if (itemSnapShot.hasData) {
                        return Padding(
                          padding: EdgeInsets.all(ScreenUtil().setWidth(8.0)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  height: MediaQuery.of(context).size.height -
                                      ScreenUtil().setHeight(200.0),
                                  child: buildChart(stockProvider.stock,
                                      itemSnapShot.data, lowHigh)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('Low'),
                                  Switch(
                                    value: lowHigh,
                                    onChanged: (value) {
                                      setState(() {
                                        lowHigh = value;
                                        widget._scaffoldKey.currentState
                                            .hideCurrentSnackBar(
                                                reason: SnackBarClosedReason
                                                    .remove);
                                        widget._scaffoldKey.currentState
                                            .showSnackBar(WidgetUtil.getSnackbar(
                                                'Changed to ${value ? 'High' : 'Low'}'));
                                      });
                                    },
                                  ),
                                  Text('High'),
                                ],
                              ),
                              Container(
                                height: ScreenUtil().setHeight(40.0),
                                child: new CustomRadio.create(
                                    listDays, selectedDaysListenable),
                              )
                            ],
                          ),
                        );
                      } else if (itemSnapShot.hasError) {
                        return WidgetUtil.error(
                            context, itemSnapShot.error.toString(),
                            onRetry: () => fetchDetails());
                      } else {
                        return CircularProgressIndicator();
                      }
                    });
              } else {
                return CircularProgressIndicator();
              }
            },
          );
        },
      ),
    );
  }

  Widget buildChart(Stock stock, DailyStockItem data, bool lowHigh) {
    return SimpleTimeSeriesChart.create(data, selectedDaysListenable.value,
        lowHigh, stock.name, 'Amount in ${stock.currency}', 'Date');
  }

  void fetchDetails() {
    stockDetailsBloc.fetchDetailsBySymbol(stockProvider.stock.symbol);
  }
}

List<RadioModel> generateDaysList() {
  final models = new List<RadioModel>();
  final list = [3, 7, 15, 30, 45, 60, 90];
  /*for (int i = 5; i <= count; i = i + 5)
    models.add(new RadioModel(models.isEmpty, i, '$i Days'));*/
  list.forEach((value) {
    models.add(new RadioModel(models.isEmpty, value, '$value Days'));
  });
  return models;
}
