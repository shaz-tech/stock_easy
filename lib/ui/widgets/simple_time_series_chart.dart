import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:stock_easy/models/stock_details_daily_item.dart';

class SimpleTimeSeriesChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final String topTitle, leftTitle, bottomTitle;
  final bool lowHigh;
  final int showCount;

  SimpleTimeSeriesChart(this.seriesList, this.showCount, this.lowHigh,
      this.topTitle, this.leftTitle, this.bottomTitle,
      {this.animate});

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      behaviors: [
        new charts.ChartTitle(topTitle,
            titleStyleSpec: charts.TextStyleSpec(
                fontWeight: FontWeight.bold.toString(), fontSize: 20),
            behaviorPosition: charts.BehaviorPosition.top,
            titleOutsideJustification: charts.OutsideJustification.middle,
            innerPadding: 24),
        new charts.ChartTitle(bottomTitle,
            behaviorPosition: charts.BehaviorPosition.bottom,
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea),
        new charts.ChartTitle(leftTitle,
            behaviorPosition: charts.BehaviorPosition.start,
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea),
      ],
    );
  }

  factory SimpleTimeSeriesChart.create(DailyStockItem stock, int showCount,
      bool lowHigh, String topTitle, String leftTitle, String bottomTitle) {
    return new SimpleTimeSeriesChart(
      _createRealData(stock, showCount, lowHigh),
      showCount,
      lowHigh,
      topTitle,
      leftTitle,
      bottomTitle,
      animate: true,
    );
  }

  static List<charts.Series<DailyStockDetails, DateTime>> _createRealData(
      DailyStockItem stock, int showCount, bool lowHigh) {
    final List<DailyStockDetails> data = new List<DailyStockDetails>();
    stock.dailyItems.take(showCount).forEach((d) {
      data.add(
          DailyStockDetails(DateTime.parse(d.date), lowHigh ? d.high : d.low));
    });

    return [
      new charts.Series<DailyStockDetails, DateTime>(
        id: 'DailyStock',
        colorFn: (_, __) => lowHigh
            ? charts.MaterialPalette.green.shadeDefault
            : charts.MaterialPalette.red.shadeDefault,
        domainFn: (DailyStockDetails item, _) => item.dateTime,
        measureFn: (DailyStockDetails item, _) => item.lowHigh,
        data: data,
      )
    ];
  }
}

class DailyStockDetails {
  final DateTime dateTime;
  final double lowHigh;

  DailyStockDetails(this.dateTime, this.lowHigh);
}
