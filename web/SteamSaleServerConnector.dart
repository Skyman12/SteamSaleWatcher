import 'dart:html';
import 'dart:convert';
import 'dart:async';
import 'User.dart';

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

  addUserToDatabase(User user) async {
    var appIDsURL = "http://localhost:8081/SteamSaleServer/SteamSaleServer.php?action=addUser&username=" + user.getUsername()
    + "&password=" + user.getPassword() + "&email=" + user.getEmail();

    // call the web server
    await HttpRequest.getString(appIDsURL).then(_onDataLoaded);
  }

  Future<List<User>> getAllUsers() async {
    List list = new List();

    var appIDsURL = "http://localhost:8081/SteamSaleServer/SteamSaleServer.php?action=getAllUsers";

    // call the web server
    Map data = await HttpRequest.getString(appIDsURL).then(_onDataLoaded);

    for (Map m in data) {
      User user = new User(m["username"], m["password"], m["email"]);
      list.add(user);
    }

    return list;
  }

}