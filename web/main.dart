// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'SteamSaleServerConnector.dart';
import 'User.dart';
import 'SteamGame.dart';
import 'SteamGameSorter.dart';

main() async {
  querySelector('#output').text = 'Your Dart app is running.';
  SteamSaleServer server = new SteamSaleServer();

  Map<String, SteamGame> onSaleGames = await server.getOnSaleGames();

  List<SteamGame> onSaleList = SteamGameSorter.sortByDiscountPercent(onSaleGames);

  for (SteamGame game in onSaleList) {
    print(game.getName() + " -Discount: " + game.getDiscountPercent().toString()
    + " -Intial: " + game.getInitialPrice().toString() + " -Final: " + game.getFinalPrice().toString());
  }
}
