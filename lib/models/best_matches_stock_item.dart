class MatchesStocks {
  List<Stock> bestMatchesStocks = [];

  MatchesStocks.fromJson(Map<String, dynamic> parsedJson) {
    for (int i = 0; i < parsedJson['bestMatches'].length; i++)
      bestMatchesStocks.add(Stock(parsedJson['bestMatches'][i]));
  }
}

class Stock {
  String symbol;
  String name;
  String type;
  String region;
  String marketOpen;
  String marketClose;
  String timezone;
  String currency;
  double matchScore;

  Stock(data) {
    symbol = data['1. symbol'];
    name = data['2. name'];
    type = data['3. type'];
    region = data['4. region'];
    marketOpen = data['5. marketOpen'];
    marketClose = data['6. marketClose'];
    timezone = data['7. timezone'];
    currency = data['8. currency'];
    matchScore = double.tryParse(data['9. matchScore']) ?? 0.0;
  }
}
