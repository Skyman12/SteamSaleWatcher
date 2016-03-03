import 'dart:html';
import 'dart:convert';
import 'dart:async';
import 'User.dart';
import 'SteamGame.dart';

class SteamSaleServerConnector {
  var host = "127.0.0.1:8081";

  Future<Map<String, SteamGame>> getCurrentGameData() async {
    Map<String, int> map = new Map();

    var appIDsURL = "http://localhost:8081/SteamSaleServer/SteamSaleServer.php?action=getCurrentData";

    // call the web server
    Map data = await HttpRequest.getString(appIDsURL).then(_onDataLoaded);

    Map<String, SteamGame> games = new Map();

    for (String k in data.keys) {
      games[k] = new SteamGame(k, data[k]);
    }

    return games;
  }

  Future<Map<String, SteamGame>> getOnSaleGames() async {
    Map<String, SteamGame> gameMap = await getCurrentGameData();
    Map<String, SteamGame> onSaleGames = new Map();

    for (String k in gameMap.keys) {
      if (gameMap[k].getDiscountPercent() != 0) {
        onSaleGames[k] = gameMap[k];
      }
    }

    return onSaleGames;
  }

  Future<Map<String, SteamGame>> getAllGames() async {
    Map<String, SteamGame> gameMap = await getCurrentGameData();
    Map<String, SteamGame> games = new Map();

    for (String k in gameMap.keys) {
      games[k] = gameMap[k];
    }

    return games;
  }

  updateGameList() {
    var appIDsURL = "http://localhost:8081/SteamSaleServer/SteamSaleServer.php?action=buildSteamSaleInformation";

    // call the web server
    HttpRequest.getString(appIDsURL);
  }

  Map _onDataLoaded(String responseText) {
    var jsonString = responseText;
    return JSON.decode(jsonString);
  }

  addUserToDatabase(User user) {
    var appIDsURL = "http://localhost:8081/SteamSaleServer/SteamSaleServer.php?action=addUser&username=" + user.getUsername()
    + "&password=" + user.getPassword() + "&email=" + user.getEmail();

    // call the web server
    HttpRequest.getString(appIDsURL);
  }

  addGameToUser(User user, String gameName, int discountAmount) {
    var appIDsURL = "http://localhost:8081/SteamSaleServer/SteamSaleServer.php?action=addGameToUser&gameName=" + gameName + "&discountAmount=" + discountAmount.toString() + "&username="
    + user.getUsername();
    HttpRequest.getString(appIDsURL);
  }

  removeGameFromUser(User user, String gameName) {
    var appIDsURL = "http://localhost:8081/SteamSaleServer/SteamSaleServer.php?action=removeGameFromUser&gameName=" + gameName + "&username=" + user.getUsername();
    HttpRequest.getString(appIDsURL);
  }

  Future<List<SteamGame>> getUsersGames(User user) async {
    var appIDsURL = "http://localhost:8081/SteamSaleServer/SteamSaleServer.php?action=getUser&username=" + user.getUsername();
    Map data = await HttpRequest.getString(appIDsURL).then(_onDataLoaded);
    List gameList = new List();
    for (String s in data["gameList"].keys) {
        Map newData = new Map();
        newData["discount_percent"] = int.parse(data["gameList"][s]);
        gameList.add(new SteamGame(s, newData));
      }

    return gameList;
  }

  Future<List<User>> getAllUsers() async {
    List list = new List();

    var appIDsURL = "http://localhost:8081/SteamSaleServer/SteamSaleServer.php?action=getAllUsers";

    // call the web server
    List data = await HttpRequest.getString(appIDsURL).then(_onDataLoaded);

    for (Map m in data) {
      User user = new User(m["username"], m["password"], m["email"]);
      list.add(user);
    }

    return list;
  }

  Future<User> getUser(String username) async {
    var appIDsURL = "http://localhost:8081/SteamSaleServer/SteamSaleServer.php?action=getUser&username=" + username;

    // call the web server
    Map data = await HttpRequest.getString(appIDsURL).then(_onDataLoaded);

    return new User(data["username"], data["password"], data["email"]);
  }


}