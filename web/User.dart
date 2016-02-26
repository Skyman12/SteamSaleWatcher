import 'dart:html';
import 'dart:convert';
import 'dart:async';

class User {

  Map<String, String> _informationMap;
  Map<String, int> _gamesMap;

  User(String username, String password, String email) {
    _informationMap = new Map();

    _informationMap["username"] = username;
    _informationMap["password"] = password;
    _informationMap["email"] = email;

    _gamesMap = new Map();
  }

  String getUsername() {
    return _informationMap["username"];
  }

  String getEmail() {
    return _informationMap["email"];
  }

  String getPassword() {
    return _informationMap["password"];
  }

  addGame(String gameName, int discount) {
    _gamesMap[gameName] = discount;
  }

  removeGame(String gameName) {
    _gamesMap.remove(gameName);
  }

  changeDiscountLevelOfGame(String gameName, int discount) {
    addGame(gameName, discount);
  }

  String toString() {
    return _informationMap["username"] + " - " + _informationMap["password"] + " - " + _informationMap["email"] + " - ";
  }
}