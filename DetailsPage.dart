// ignore_for_file: file_names, unused_field

import 'package:crypto_wallet/models/API.dart';
import 'package:crypto_wallet/models/Cryptocurrency.dart';
import 'package:crypto_wallet/providers/market_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DetailsPage extends StatefulWidget {
  final String id;

  const DetailsPage({super.key, required this.id});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  List<PriceData> _priceData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchHistoricalPrices();
  }

  Future<void> _fetchHistoricalPrices() async {
    List<PriceData> prices = await API.getHistoricalPrices(widget.id);
    setState(() {
      _priceData = prices;
      _isLoading = false;
    });
  }

  Widget titleAndDetail(
      String title, String detail, CrossAxisAlignment crossAxisAlignment) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(
          detail,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Consumer<MarketProvider>(
          builder: (context, marketProvider, child) {
            CryptoCurrency currentCrypto =
                marketProvider.fetchCryptoById(widget.id);

            return RefreshIndicator(
              color: Colors.white,
              onRefresh: () async {
                await marketProvider.fetchMarkets();
                _fetchHistoricalPrices();
              },
              child: ListView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(currentCrypto.image!),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${currentCrypto.name!} (${currentCrypto.symbol!.toUpperCase()})",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 12.0, right: 10.0),
                          child: (currentCrypto.isFavourite == false)
                              ? GestureDetector(
                                  onTap: () {
                                    marketProvider
                                        .addToFavoutite(currentCrypto);
                                  },
                                  child: const Icon(
                                    CupertinoIcons.heart,
                                    size: 36,
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    marketProvider
                                        .removeFromFavoutite(currentCrypto);
                                  },
                                  child: const Icon(
                                    CupertinoIcons.heart_fill,
                                    size: 36,
                                    color: Colors.red,
                                  ),
                                ),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      currentCrypto.currentPrice!.toStringAsFixed(4),
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Price Change (24H)',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Builder(builder: (context) {
                        double priceChange = currentCrypto.priceChange24!;
                        double priceChangePercentage =
                            currentCrypto.priceChangePercentage24!;
                        if (priceChange < 0) {
                          // negative
                          return Text(
                            "${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(3)})",
                            style: const TextStyle(
                                fontSize: 23,
                                color: Colors.red,
                                fontWeight: FontWeight.w600),
                          );
                        } else {
                          // positive
                          return Text(
                            "+${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(3)})",
                            style: const TextStyle(
                                fontSize: 23,
                                color: Colors.green,
                                fontWeight: FontWeight.w600),
                          );
                        }
                      })
                    ],
                  ),
                  const SizedBox(height: 30),
                  SfCartesianChart(
                    margin: const EdgeInsets.all(0),
                    primaryXAxis: const DateTimeAxis(),
                    series: <CartesianSeries>[
                      LineSeries<PriceData, DateTime>(
                        dataSource: _priceData,
                        xValueMapper: (PriceData data, _) => data.date,
                        yValueMapper: (PriceData data, _) => data.price,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetail(
                          "Market Cap",
                          "\$ ${currentCrypto.marketCap!.toStringAsFixed(4)}",
                          CrossAxisAlignment.start),
                      titleAndDetail(
                          "Market Cap Rank",
                          "#${currentCrypto.marketCapRank!}",
                          CrossAxisAlignment.end),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetail(
                          "Low 24H",
                          "\$ ${currentCrypto.low24!.toStringAsFixed(4)}",
                          CrossAxisAlignment.start),
                      titleAndDetail("High 24H", "\$ ${currentCrypto.high24!}",
                          CrossAxisAlignment.end),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetail(
                          "Circulating Supply",
                          currentCrypto.circulatingSupply!.toInt().toString(),
                          CrossAxisAlignment.start),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetail(
                          "All time Low",
                          currentCrypto.atl!.toStringAsFixed(4),
                          CrossAxisAlignment.start),
                      titleAndDetail(
                          "All time High",
                          currentCrypto.ath!.toStringAsFixed(4),
                          CrossAxisAlignment.end),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      )),
    );
  }
}
