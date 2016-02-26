// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'SteamSaleServerConnector.dart';
import 'User.dart';

main() async {
  querySelector('#output').text = 'Your Dart app is running.';
  SteamSaleServer server = new SteamSaleServer();

  User blake = new User("skyman", "test" , "skyman@iastate.edu");
  //server.addUserToDatabase(blake);
//
//  Map<String, int> games = await server.getCurrentGameData();
//
//  Map<String, int> onSaleGames = getOnSaleGames(games);
//
//  for (String k in onSaleGames.keys) {
//   print(k + " -Discount: " + onSaleGames[k].toString());
//  }

    List<User> users = await server.getAllUsers();
    for (User u in users) {
      print(u.toString());
    }
}

Map<String, int> getOnSaleGames(Map<String, int> gameMap) {
  Map<String, int> onSaleGames = new Map();

  for (String k in gameMap.keys) {
    if (gameMap[k] != 0) {
      onSaleGames[k] = gameMap[k];
    }
  }

  return onSaleGames;
}
