import 'package:stock_easy/models/best_matches_stock_item.dart';
import 'package:stock_easy/models/stock_details_daily_item.dart';
import 'package:stock_easy/resources/remote/stock_api_provider.dart';

class StockRepository {
  static final StockRepository _instance = StockRepository._internal();
  StockApiProvider _stockApiProvider;

  StockRepository._internal() {
    _stockApiProvider = StockApiProvider();
  }

  factory StockRepository() {
    return _instance;
  }

  Future<MatchesStocks> search(String keyword) =>
      _stockApiProvider.search(keyword);

  Future<DailyStockItem> dailyDetails(String symbol) =>
      _stockApiProvider.dailyDetails(symbol);
}
