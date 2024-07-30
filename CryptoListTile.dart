// ignore_for_file: file_names, unused_local_variable

import 'package:crypto_wallet/models/Cryptocurrency.dart';
import 'package:crypto_wallet/pages/DetailsPage.dart';
import 'package:crypto_wallet/providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CryptoListTile extends StatelessWidget {
  const CryptoListTile({super.key, required this.currentCrypto});

  final CryptoCurrency currentCrypto;

  @override
  Widget build(BuildContext context) {
    MarketProvider marketProvider =
        Provider.of<MarketProvider>(context, listen: false);

    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsPage(
                      id: currentCrypto.id!,
                    )));
      },
      contentPadding: const EdgeInsets.all(0),
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(currentCrypto.image!),
      ),
      title: Row(
        children: [
          Flexible(
            child: Text(
              currentCrypto.name!,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
      subtitle: Text(
        currentCrypto.symbol!.toUpperCase(),
        style: TextStyle(color: Colors.grey.shade700),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "\$ ${currentCrypto.currentPrice!.toStringAsFixed(4)}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
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
                    fontSize: 15,
                    color: Colors.red,
                    fontWeight: FontWeight.w400),
              );
            } else {
              // positive
              return Text(
                "+${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(3)})",
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.green,
                    fontWeight: FontWeight.w400),
              );
            }
          })
        ],
      ),
    );
  }
}
