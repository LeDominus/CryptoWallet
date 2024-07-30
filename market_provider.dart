// ignore_for_file: avoid_print

import 'dart:async';

import 'package:crypto_wallet/models/API.dart';
import 'package:crypto_wallet/models/Cryptocurrency.dart';
import 'package:crypto_wallet/models/LocasStorage.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';

class MarketProvider with ChangeNotifier {
  List<CryptoCurrency> _markets = [];
  bool _isLoading = false;

  List<CryptoCurrency> get markets => _markets;
  bool get isLoading => _isLoading;

  MarketProvider() {
    fetchMarkets();
  }

  Future<void> fetchMarkets() async {
    _isLoading = true;
    notifyListeners();

    try {
      List<dynamic> marketData = await API.getMarkets();
      List<String> favourites = await LocalStorage.fetchFavourite();
      _markets = marketData.map((data) {
        CryptoCurrency crypto = CryptoCurrency.fromJSON(data);
        if (favourites.contains(crypto.id)) {
          crypto.isFavourite = true;
        }
        return crypto;
      }).toList();
    } catch (e) {
      // Handle error
      print('Error fetching markets: $e');
      _markets = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  CryptoCurrency fetchCryptoById(String id) {
    return markets.firstWhere((element) => element.id == id);
  }

  void addToFavoutite(CryptoCurrency crypto) async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isFavourite = true;
    await LocalStorage.addToFavourite(crypto.id!);
    notifyListeners();
  }

  void removeFromFavoutite(CryptoCurrency crypto) async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isFavourite = false;
    await LocalStorage.removeFromFavourite(crypto.id!);
    notifyListeners();
  }
}
