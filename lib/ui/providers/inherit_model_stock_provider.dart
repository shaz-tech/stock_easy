import 'package:flutter/material.dart';
import 'package:stock_easy/models/best_matches_stock_item.dart';

class StockModelProvider extends InheritedModel<String> {
  final Stock stock;

  const StockModelProvider({@required this.stock, @required Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(StockModelProvider old) {
    return old.stock != stock;
  }

  @override
  bool updateShouldNotifyDependent(
      StockModelProvider old, Set<String> aspects) {
    return aspects.contains('stock') && old.stock != stock;
  }

  static StockModelProvider of(BuildContext context, String aspect) {
    return InheritedModel.inheritFrom<StockModelProvider>(context,
        aspect: aspect);
  }
}
