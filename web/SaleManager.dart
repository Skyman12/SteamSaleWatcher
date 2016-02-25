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
        Map<String, int> saleData = await server.getSteamSaleInformation(id);

        print(saleData);

        if (saleData != null && !saleData.containsKey("xxx")) {
          print(saleData['discount_percent']);
          _allGames[games[id]] = saleData['discount_percent'];
        }
    }

    printAllGames();
    return true;
  }

  void printAllGames() {
    for (String game in _allGames.keys) {
      print(game + " - Discount: " + _allGames[game].toString());
    }
  }





}