import 'package:crypto_wallet/models/LocasStorage.dart';
import 'package:crypto_wallet/pages/WalletPage.dart';
import 'package:crypto_wallet/providers/market_provider.dart';
import 'package:crypto_wallet/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String currentTheme = await LocalStorage.getTheme() ?? "light";
  runApp( MyApp(
    theme: currentTheme
  ));
}

class MyApp extends StatelessWidget {

  final String theme;

  const MyApp({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MarketProvider>(
            create: (context) => MarketProvider()),
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider(theme)),
        // ...
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProiver, child) {
        return MaterialApp(
          themeMode: themeProiver.themeMode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: const WalletPage(),
          debugShowCheckedModeBanner: false,
        );
      }),
    );
  }
}
