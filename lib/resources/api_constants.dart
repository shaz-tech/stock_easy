class ApiConstants {
  static final String baseUrl = 'https://www.alphavantage.co';
  static final String apiKey = 'EKGP8D5O15SINU06';

  static String searchUrl(String keyword) =>
      "$baseUrl/query?function=SYMBOL_SEARCH&keywords=$keyword&apikey=$apiKey";

  static String dailyDetails(String symbol) =>
      "$baseUrl/query?function=TIME_SERIES_DAILY&symbol=$symbol&apikey=$apiKey";
}
