import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show Client;
import 'package:stock_easy/models/stock_details_daily_item.dart';
import 'package:stock_easy/resources/api_constants.dart';

import '../models/best_matches_stock_item.dart';

class StockApiProvider {
  final Client client = Client();

  Future<MatchesStocks> search(String keyword) async {
    final response = await client.get(ApiConstants.searchUrl(keyword));
    debugPrint('Response=> ' + response.body.toString());
    if (response.statusCode == 200) {
      return MatchesStocks.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to search the keyword');
    }
  }

  Future<DailyStockItem> dailyDetails(String symbol) async {
    final response = await client.get(ApiConstants.dailyDetails(symbol));
    debugPrint('Response=> ' + response.body.toString());
    if (response.statusCode == 200) {
      return DailyStockItem.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load details');
    }
  }
}
