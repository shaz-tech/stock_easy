import 'package:flutter/material.dart';
import 'package:stock_easy/blocs/stock_bloc_details.dart';

class StockDetailsBlocProvider extends InheritedWidget {
  final StockDetailsBloc _bloc;

  StockDetailsBlocProvider({Key key, @required Widget child})
      : _bloc = StockDetailsBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(__) {
    return true;
  }

  static StockDetailsBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<StockDetailsBlocProvider>()
        ._bloc;
  }
}
