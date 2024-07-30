// ignore_for_file: file_names

import 'package:crypto_wallet/models/Cryptocurrency.dart';
import 'package:crypto_wallet/providers/market_provider.dart';
import 'package:crypto_wallet/widgets/CryptoListTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(builder: (context, marketProvider, child) {
      List<CryptoCurrency> favourites = marketProvider.markets
          .where((element) => element.isFavourite == true)
          .toList();

      if (favourites.isNotEmpty) {
        return ListView.builder(
            itemCount: favourites.length,
            itemBuilder: (context, index) {
              CryptoCurrency currentCrypto = favourites[index];
              return CryptoListTile(currentCrypto: currentCrypto);
            });
      } else {
        return const Center(
          child: Text('Add crypto to Favourite list!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500
            ),),
        );
      }
    });
    // return Container(
    //   child: const Text('Favourite will show up here'),
    // );
  }
}
