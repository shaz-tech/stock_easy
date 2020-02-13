import 'dart:async';
import 'dart:convert';

import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:http/http.dart' show Client;
import 'package:stock_easy/models/stock_details_daily_item.dart';
import 'package:stock_easy/resources/api_constants.dart';

import '../../models/best_matches_stock_item.dart';
import 'dio_helper.dart';

class StockApiProvider {
  final Client client = Client();

  Future<MatchesStocks> search(String keyword) {
    return DioHelper.getDio()
        .get<String>(ApiConstants.searchUrl(keyword),
            options:
                buildCacheOptions(Duration(minutes: 1), forceRefresh: false))
        .then((response) {
      if (response.statusCode == 200) {
        return MatchesStocks.fromJson(jsonDecode(response.data));
      } else {
        throw Exception(
            'Failed to search the keyword. Please try after sometime');
      }
    }).catchError((onError, stackTrace) {
      throw Exception(stackTrace.toString());
    });

    /*final response = await client.get(ApiConstants.searchUrl(keyword));
    debugPrint('Response=> ' + response.body.toString());
    if (response.statusCode == 200) {
      return MatchesStocks.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to search the keyword');
    }*/
  }

  Future<DailyStockItem> dailyDetails(String symbol) async {
    return DioHelper.getDio()
        .get<String>(ApiConstants.dailyDetails(symbol),
            options:
                buildCacheOptions(Duration(minutes: 5), forceRefresh: false))
        .then((response) {
      if (response.statusCode == 200) {
        return DailyStockItem.fromJson(jsonDecode(response.data));
      } else {
        throw Exception('Failed to load details. Please try after sometime');
      }
    }).catchError((onError, stackTrace) {
      throw Exception(stackTrace.toString());
    });

    /*final response = await client.get(ApiConstants.dailyDetails(symbol));
    debugPrint('Response=> ' + response.body.toString());
    if (response.statusCode == 200) {
      return DailyStockItem.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load details');
    }*/
  }
}
