// ignore_for_file: file_names, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class API {
  static Future<List<dynamic>> getMarkets() async {
    Uri requestPath = Uri.parse(
        "http://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=20&page=1&sparkline=false");
    var response = await http.get(requestPath);

    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      if (decodedResponse is List) {
        return decodedResponse;
      } else {
        print('Unexpected response format: $decodedResponse');
        return [];
      }
    } else {
      print('Failed to load markets: ${response.statusCode}');
      return [];
    }
  }

  static Future<List<PriceData>> getHistoricalPrices(String id) async {
    Uri requestPath = Uri.parse(
      "https://api.coingecko.com/api/v3/coins/$id/market_chart?vs_currency=inr&days=30"
    );
    var response = await http.get(requestPath);

    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      List<PriceData> prices = [];
      for (var item in decodedResponse['prices']) {
        DateTime date = DateTime.fromMillisecondsSinceEpoch(item[0]);
        double price = item[1];
        prices.add(PriceData(date, price));
      }
      return prices;
    } else {
      print('Failed to load historical prices: ${response.statusCode}');
      return [];
    }
  }
}

class PriceData {
  PriceData(this.date, this.price);
  final DateTime date;
  final double price;
}
