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

     var appIDsURL = "http://localhost:8081/SteamSaleWatcherServer/SimpleSteamSaleServer.php?action=getSteamAppIDs";

    // call the web server
    Map data = await HttpRequest.getString(appIDsURL).then(onDataLoaded);

    // From the data, build a map with the keys being the appid and the values being the name of the game
    for (Map m in data["applist"]["apps"]) {
      map[m["appid"]] = m["name"];
    }

    return map;
  }

  Future<Map<String, String>> getSteamSaleInformation(int appid) async {
    print(appid.toString());
    Map<int, String> map = new Map();

    var appIDsURL = "http://localhost:8081/SteamSaleWatcherServer/SimpleSteamSaleServer.php?action=getSteamSaleInformation&appid=" + appid.toString();

    // call the web server
    Map data = await HttpRequest.getString(appIDsURL).then(onDataLoaded);

    if (data != null && data[appid.toString()]["success"] == "true") {
      return data[appid.toString()]["data"]["price_overview"];
    }

    return {"xxx" : "false"};
  }

  Map onDataLoaded(String responseText) {
    var jsonString = responseText;
    try {
      return JSON.decode(jsonString);
    } catch(Exception) {
      return null;
    }
  }
}