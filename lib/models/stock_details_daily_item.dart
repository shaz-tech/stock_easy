class DailyStockItem {
  Details details;
  List<DailyItem> dailyItems = [];

  DailyStockItem.fromJson(Map<String, dynamic> parsedJson) {
    details = Details(parsedJson['Meta Data']);
    Map<String, dynamic> dailyItemJson = parsedJson['Time Series (Daily)'];
    dailyItemJson.forEach((k, v) => dailyItems.add(DailyItem.fromJson(k, v)));
  }
}

class Details {
  String information;
  String symbol;
  String lastRefreshed;
  String outputSize;
  String timeZone;

  Details(data) {
    information = data['1. Information'];
    symbol = data['2. Symbol'];
    lastRefreshed = data['3. Last Refreshed'];
    outputSize = data['4. Output Size'];
    timeZone = data['5. Time Zone'];
  }
}

class DailyItem {
  String date;
  double open;
  double high;
  double low;
  double close;
  int volume;

  DailyItem.fromJson(String key, Map<String, dynamic> json) {
    date = key;
    open = double.tryParse(json['1. open']) ?? 0.0;
    high = double.tryParse(json['2. high']) ?? 0.0;
    low = double.tryParse(json['3. low']) ?? 0.0;
    close = double.tryParse(json['4. close']) ?? 0.0;
    volume = int.tryParse(json['5. volume']) ?? 0;
  }
}
