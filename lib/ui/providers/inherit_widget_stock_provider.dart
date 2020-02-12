import 'package:flutter/material.dart';
import 'package:stock_easy/models/best_matches_stock_item.dart';

class StockWidgetProvider extends InheritedWidget {
  final Stock stock;

  StockWidgetProvider({Key key, @required this.stock, @required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(StockWidgetProvider old) {
    return old.stock != stock;
  }

  static StockWidgetProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StockWidgetProvider>();
  }
}
