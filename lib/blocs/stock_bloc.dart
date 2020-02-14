import 'package:rxdart/rxdart.dart';
import 'package:stock_easy/models/best_matches_stock_item.dart';
import 'package:stock_easy/resources/reposiroties/stock_repository.dart';

class StockBloc {
  final _stockRepository = StockRepository();
  final _stockSearchFetcher = PublishSubject<MatchesStocks>();

  Observable<MatchesStocks> get stockSearchStream => _stockSearchFetcher.stream;

  search(String keyword) async {
    _stockSearchFetcher.sink.add(null);
    MatchesStocks model = await _stockRepository.search(keyword);
    if (model != null && model.bestMatchesStocks.length > 0)
      _stockSearchFetcher.sink.add(model);
    else
      _stockSearchFetcher.sink.addError('No result found. Please try after sometime');
  }

  dispose() {
    _stockSearchFetcher.close();
  }
}

final stockBloc = StockBloc();
