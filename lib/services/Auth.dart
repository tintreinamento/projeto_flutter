import 'package:localstorage/localstorage.dart';

class Auth {
  static final storage = new LocalStorage('my_data');
  static final TOKEN_KEY = "@nm";

  static bool isAuthenticated() {
    return storage.getItem(TOKEN_KEY) != null;
  }

  static void login(String token) {
    storage.setItem(TOKEN_KEY, token);
  }

  static String getToken() {
    return storage.getItem(TOKEN_KEY);
  }

  static logout() {
    storage.deleteItem(TOKEN_KEY);
  }
}
