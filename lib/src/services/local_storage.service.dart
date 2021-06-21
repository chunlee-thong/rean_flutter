import 'package:shared_preferences/shared_preferences.dart';

const String THEME_KEY = "theme";

class LocalStorage {
  static late SharedPreferences sharedPreferences;

  //Prevent initialization
  LocalStorage._();

  static Future<void> initialize() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> save({
    required String key,
    required String value,
  }) async {
    await sharedPreferences.setString(key, value);
  }

  static Future<String?> read({required String key}) async {
    return await sharedPreferences.getString(key);
  }

  static Future<bool> deleteAll() async {
    return await sharedPreferences.clear();
  }
}
