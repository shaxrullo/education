import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _keyToken = 'access_token';

  // Tokenni saqlash
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyToken, token);
  }

  // Tokenni olish
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyToken);
  }

  // Logout bo'lganda tokenni o'chirish
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyToken);
  }
}

final storageService = StorageService();
