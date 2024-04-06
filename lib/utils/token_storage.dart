import 'dart:html';

class TokenStorage {
  static String? getToken() {
    return window.localStorage['token'];
  }

  static void saveToken({required String token}) {
    window.localStorage['token'] = token;
  }

  static void deleteToken() {
    window.localStorage.remove('token');
  }
}
