// ignore_for_file: file_names

class CryptoCurrency {
  String? id;
  String? symbol;
  String? name;
  String? image;
  double? currentPrice;
  double? marketCap;
  int? marketCapRank;
  double? high24;
  double? low24;
  double? priceChange24;
  double? priceChangePercentage24;
  double? circulatingSupply;
  double? ath;
  double? atl;
  bool isFavourite = false;

  CryptoCurrency({
    required this.ath,
    required this.atl,
    required this.circulatingSupply,
    required this.currentPrice,
    required this.high24,
    required this.id,
    required this.image,
    required this.low24,
    required this.marketCap,
    required this.marketCapRank,
    required this.name,
    required this.priceChange24,
    required this.priceChangePercentage24,
    required this.symbol,
  });

  factory CryptoCurrency.fromJSON(Map<String, dynamic> map) {
    return CryptoCurrency(
      ath: map['ath'] != null
          ? double.tryParse(map['ath'].toString()) ?? 0.0
          : 0.0,
      atl: map['atl'] != null
          ? double.tryParse(map['atl'].toString()) ?? 0.0
          : 0.0,
      circulatingSupply: map['circulating_supply'] != null
          ? double.tryParse(map['circulating_supply'].toString()) ?? 0.0
          : 0.0,
      currentPrice: map['current_price'] != null
          ? double.tryParse(map['current_price'].toString()) ?? 0.0
          : 0.0,
      high24: map['high_24h'] != null
          ? double.tryParse(map['high_24h'].toString()) ?? 0.0
          : 0.0,
      id: map['id'],
      image: map['image'],
      low24: map['low_24h'] != null
          ? double.tryParse(map['low_24h'].toString()) ?? 0.0
          : 0.0,
      marketCap: map['market_cap'] != null
          ? double.tryParse(map['market_cap'].toString()) ?? 0.0
          : 0.0,
      marketCapRank: map['market_cap_rank'],
      name: map['name'],
      priceChange24: map['price_change_24h'] != null
          ? double.tryParse(map['price_change_24h'].toString()) ?? 0.0
          : 0.0,
      priceChangePercentage24: map['price_change_percentage_24h'] != null
          ? double.tryParse(map['price_change_percentage_24h'].toString()) ??
              0.0
          : 0.0,
      symbol: map['symbol'],
    );
  }
}
