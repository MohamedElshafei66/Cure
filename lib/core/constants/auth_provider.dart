import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'secure_storage_data.dart';

class AuthProvider extends ChangeNotifier {
  String? _accessToken;
  String? _refreshToken;

  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;

  
  Future<void> setTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    _accessToken = accessToken;
    _refreshToken = refreshToken;

    // Save to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken);
    await prefs.setString('refresh_token', refreshToken);

    // Also save to SecureStorageService
    final secureStorage = SecureStorageService();
    await secureStorage.write(key: 'accessToken', value: accessToken);
    await secureStorage.write(key: 'refreshToken', value: refreshToken);

    notifyListeners();
  }

 
  Future<void> loadTokens() async {
    // Try to load from SharedPreferences first
    final prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString('access_token');
    _refreshToken = prefs.getString('refresh_token');

    // If not found in SharedPreferences, try SecureStorageService
    if (_accessToken == null || _refreshToken == null) {
      final secureStorage = SecureStorageService();
      _accessToken ??= await secureStorage.read(key: 'accessToken');
      _refreshToken ??= await secureStorage.read(key: 'refreshToken');
      
      // If found in SecureStorageService, sync to SharedPreferences
      if (_accessToken != null && _refreshToken != null) {
        await prefs.setString('access_token', _accessToken!);
        await prefs.setString('refresh_token', _refreshToken!);
      }
    }

    if (kDebugMode) {
      print("🔁 Loaded Access Token: $_accessToken");
    }

    notifyListeners();
  }

  
  Future<void> clearTokens() async {
    _accessToken = null;
    _refreshToken = null;

    // Clear from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');

    // Also clear from SecureStorageService
    final secureStorage = SecureStorageService();
    await secureStorage.delete(key: 'accessToken');
    await secureStorage.delete(key: 'refreshToken');

    notifyListeners();
  }
}
