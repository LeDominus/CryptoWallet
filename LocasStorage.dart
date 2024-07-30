// ignore_for_file: file_names
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<bool> saveTheme(String theme) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    bool result = await sharedPreferences.setString("theme", theme);

    return result;
  }

  static Future<String?> getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? currentTheme = sharedPreferences.getString("theme");

    return currentTheme;
  }

  static Future<bool> addToFavourite(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List<String> favourites =
        sharedPreferences.getStringList('favourites') ?? [];
    favourites.add(id);

    return await sharedPreferences.setStringList('favourites', favourites);
  }

  static Future<bool> removeFromFavourite(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List<String> favourites =
        sharedPreferences.getStringList('favourites') ?? [];
    favourites.remove(id);

    return await sharedPreferences.setStringList('favourites', favourites);
  }

  static Future<List<String>> fetchFavourite() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList("favourites") ?? [];
  }
}
