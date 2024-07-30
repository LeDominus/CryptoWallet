// ignore_for_file: file_names, prefer_is_empty, prefer_interpolation_to_compose_strings, unused_local_variable

import 'package:crypto_wallet/pages/Favourite.dart';
import 'package:crypto_wallet/pages/Markets.dart';
import 'package:crypto_wallet/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> with TickerProviderStateMixin{
  late TabController viewController;

  @override
  void initState() {
    super.initState();
    viewController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome back',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Crypto Today',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Consumer<ThemeProvider>(
                    builder: (context, themeProvider, child) {
                  return IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      themeProvider.toggleTheme();
                    },
                    icon: Icon(
                      themeProvider.themeMode == ThemeMode.light
                          ? Icons.dark_mode_outlined
                          : Icons.light_mode_rounded,
                      size: 40,
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
             TabBar(
              controller: viewController,
              tabs: const [
              Tab(
                child: Text("Markets",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500
                  ),),
              ),
              Tab(
                child: Text("Favourite",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500
                  ),),
              )
              ]
            ),
            Expanded(
              child: TabBarView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()
                ),
                controller: viewController,
                  children: const [
                    // Отображаю те страницы, которые необходимо
                    Markets(),
                    Favourite(),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
