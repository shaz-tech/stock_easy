import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:stock_easy/models/stock_details_daily_item.dart';
import 'package:stock_easy/resources/reposiroties/stock_repository.dart';

class StockDetailsBloc {
  final _stockRepository = StockRepository();

  final _stockSymbol = PublishSubject<String>();
  final _stockDetails = BehaviorSubject<Future<DailyStockItem>>();

  Function(String) get fetchDetailsBySymbol => _stockSymbol.sink.add;

  Observable<Future<DailyStockItem>> get stockDetails => _stockDetails.stream;

  StockDetailsBloc() {
    _stockSymbol.stream.transform(_itemTransform()).pipe(_stockDetails);
  }

  _itemTransform() {
    return ScanStreamTransformer(
        (Future<DailyStockItem> details, String symbol, int index) {
      details = _stockRepository.dailyDetails(symbol);
      return details;
    });
  }

  dispose() async {
    _stockSymbol.close();
    await _stockDetails.drain();
    _stockDetails.close();
  }
}
