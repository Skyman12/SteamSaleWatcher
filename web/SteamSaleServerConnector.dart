import 'dart:html';
import 'dart:convert';
import 'dart:async';

class SteamSaleServer {
  var host = "127.0.0.1:8081";

  SteamSaleServer() {

  }

  Future<Map<String, int>> getCurrentGameData() async {
    Map<String, int> map = new Map();

    var appIDsURL = "http://localhost:8081/SteamSaleServer/SteamSaleServer.php?action=getCurrentData";

    // call the web server
    Map data = await HttpRequest.getString(appIDsURL).then(_onDataLoaded);

    return data;
  }

  updateGameList() async {
    var appIDsURL = "http://localhost:8081/SteamSaleServer/SteamSaleServer.php?action=buildSteamSaleInformation";

    // call the web server
    await HttpRequest.getString(appIDsURL).then(_onDataLoaded);
  }

  Map _onDataLoaded(String responseText) {
    var jsonString = responseText;
    return JSON.decode(jsonString);
  }

}