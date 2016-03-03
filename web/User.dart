import 'dart:html';
import 'dart:convert';
import 'dart:async';
import 'SteamSaleServerConnector.dart';
import 'SteamGame.dart';

class User {

  Map<String, String> _informationMap;
  SteamSaleServerConnector _server;

  User(String username, String password, String email) {
    _server = new SteamSaleServerConnector();
    _informationMap = new Map();

    _informationMap["username"] = username;
    _informationMap["password"] = password;
    _informationMap["email"] = email;
  }

  void addUser() {
    _server.addUserToDatabase(this);
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

  String toString() {
    return _informationMap["username"] + " - " + _informationMap["password"] + " - " + _informationMap["email"] + " - ";
  }

  void addGameToUser(String gameName, int discountAmount) {
    _server.addGameToUser(this, gameName, discountAmount);
  }

  void removeGameFromUser(String gameName) {
    _server.removeGameFromUser(this, gameName);
  }

  void changeDiscountOfGame(String gameName, int discountAmount) {
    _server.addGameToUser(this, gameName, discountAmount);
  }

  Future<List<SteamGame>> getAllGames() {
    return _server.getUsersGames(this);
  }
}