import 'package:localstorage/localstorage.dart';

final TOKEN_KEY = "token";

void login(String token) {
  final storage = new LocalStorage('data');

  storage.setItem(TOKEN_KEY, token);
}

String getToken() {
  final storage = new LocalStorage('data');

  return storage.getItem(TOKEN_KEY);
}

void logout() {
  final storage = new LocalStorage('data');
  storage.deleteItem(TOKEN_KEY);
}
