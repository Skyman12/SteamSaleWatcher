import 'dart:html';
import 'dart:convert';
import 'dart:async';

class SteamSaleServer {
  var host = "127.0.0.1:8081";

  SteamSaleServer() {

  }
  /// Returns all steam games. They are stored in a Map, with the key being the appid and the value being the name
  /// of the game
  Future<Map<int, String>> getSteamAppIDs() async {
    Map<int, String> map = new Map();
    // URL to get the summoner data associated with the summonerName
     var appIDsURL = "http://localhost:8081/SteamSaleWatcherServer/SimpleSteamSaleServer.php?action=getSteamAppIDs";

    // call the web server
    Map data = await HttpRequest.getString(appIDsURL).then(onDataLoaded);

    // From the data, build a map with the keys being the appid and the values being the name of the game
    for (Map m in data["applist"]["apps"]) {
      map[m["appid"]] = m["name"];
    }

    return map;
  }

  Map onDataLoaded(String responseText) {
    var jsonString = responseText;
    return JSON.decode(jsonString);
  }
}