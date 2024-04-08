// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

/// Service to store and retrieve token from local storage
class TokenStorage {
  /// Get token from local storage
  static String? getToken() {
    return window.localStorage['token'];
  }

  /// Save token into local storage
  static void saveToken({required String token}) {
    window.localStorage['token'] = token;
  }

  /// Delete token from local storage
  static void deleteToken() {
    window.localStorage.remove('token');
  }
}
