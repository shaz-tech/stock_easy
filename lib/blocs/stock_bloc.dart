import 'package:rxdart/rxdart.dart';
import 'package:stock_easy/models/best_matches_stock_item.dart';
import 'package:stock_easy/models/stock_details_daily_item.dart';
import 'package:stock_easy/resources/stock_repository.dart';

class StockBloc {
  final stockRepository = StockRepository();
  final _stockSearchFetcher = PublishSubject<MatchesStocks>();
  final _stockDailyFetcher = PublishSubject<DailyStockItem>();

  Observable<MatchesStocks> get stockSearchStream => _stockSearchFetcher.stream;

  Observable<DailyStockItem> get stockDaily => _stockDailyFetcher.stream;

  search(String keyword) async {
    _stockSearchFetcher.sink.add(null);
    MatchesStocks model = await stockRepository.search(keyword);
    if (model != null && model.bestMatchesStocks.length > 0)
      _stockSearchFetcher.sink.add(model);
    else
      _stockSearchFetcher.sink.addError('No result found');
  }

  dailyDetails(String symbol) async {
    _stockDailyFetcher.add(null);
    DailyStockItem model = await stockRepository.dailyDetails(symbol);
    if (model != null)
      _stockDailyFetcher.sink.add(model);
    else
      _stockDailyFetcher.sink.addError('No result found');
  }

  dispose() {
    _stockSearchFetcher.close();
    _stockDailyFetcher.close();
  }
}

final stockBloc = StockBloc();
