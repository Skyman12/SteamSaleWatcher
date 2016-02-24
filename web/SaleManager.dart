import "SteamSale.dart";
import "SteamSaleServer.dart";
import 'dart:html';
import 'dart:convert';
import 'dart:async';

class SaleManager {

  Map<String, int> _allGames;
  SteamSaleServer server;

  SaleManager() {
    server = new SteamSaleServer();
    _allGames = new Map();
  }


  Future<bool> getAllGames() async {
    Map<int, String> games = await server.getSteamAppIDs();

    for (int id in games.keys) {
        Map<String, String> saleData = await server.getSteamSaleInformation(id);

        if (saleData != null && !saleData.containsKey("xxx")) {
          _allGames[games[id]] = int.parse(saleData['discount_percent']);
        }
    }

    return true;
  }

  void printAllGames() {
    for (String game in _allGames.keys) {
      print(game + " - Discount: " + _allGames[game].toString());
    }
  }





}