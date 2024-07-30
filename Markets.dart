// ignore_for_file: prefer_is_empty, file_names

import 'package:crypto_wallet/models/Cryptocurrency.dart';
import 'package:crypto_wallet/providers/market_provider.dart';
import 'package:crypto_wallet/widgets/CryptoListTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Markets extends StatefulWidget {
  const Markets({super.key});

  @override
  State<Markets> createState() => _MarketsState();
}

class _MarketsState extends State<Markets> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        if (marketProvider.isLoading == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (marketProvider.markets.length > 0) {
            return RefreshIndicator(
              color: Colors.white,
              onRefresh: () async {
                await marketProvider.fetchMarkets();
              },
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: marketProvider.markets.length,
                  itemBuilder: (context, index) {
                    CryptoCurrency currentCrypto =
                        marketProvider.markets[index];

                    return CryptoListTile(currentCrypto: currentCrypto);
                  }),
            );
          } else {
            return const Center(
                child: Text(
              'Oops...something went wrong!',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ));
          }
        }
      },
    );
  }
}
