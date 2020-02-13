import 'package:stock_easy/models/best_matches_stock_item.dart';
import 'package:stock_easy/models/stock_details_daily_item.dart';
import 'package:stock_easy/resources/remote/stock_api_provider.dart';

class StockRepository {
  final stockApiProvider = StockApiProvider();

  Future<MatchesStocks> search(String keyword) =>
      stockApiProvider.search(keyword);

  Future<DailyStockItem> dailyDetails(String symbol) =>
      stockApiProvider.dailyDetails(symbol);
}
