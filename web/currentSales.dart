// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'SteamSaleServerConnector.dart';
import 'SteamGame.dart';
import 'SteamGameSorter.dart';
import 'dart:html';
import 'SteamSaleDisplayComponent.dart';

Map<String, SteamGame> onSaleGames;
List<SteamGame> onSaleList;

main() async {
  SteamSaleServer server = new SteamSaleServer();

  onSaleGames = await server.getOnSaleGames();

  onSaleList = SteamGameSorter.sortByDiscountPercent(onSaleGames);

  var sortingType = querySelector("#sortingType");
  sortingType.onChange.listen(updateListWithSort);

  updateCurrentSales();
}

void updateCurrentSales() {
  var element = querySelector('#sale-table');
  var header = element.children.elementAt(0);
  element.children.clear();

  element.children.add(header);

  for (SteamGame game in onSaleList) {
    element.children.add(SteamSaleDisplayComponent.buildComponent(game));
  }
}

void updateListWithSort([Event e]) {
  SelectElement selection = querySelector("#sortingType");
  switch (selection.value) {
    case "Discount Percent" :
      onSaleList = SteamGameSorter.sortByDiscountPercent(onSaleGames);
      break;
    case "Game Name" :
      onSaleList = SteamGameSorter.sortByName(onSaleGames);
      break;
    case "Initial Price" :
      onSaleList = SteamGameSorter.sortByInitialPrice(onSaleGames);
      break;
    case "Final Price" :
      onSaleList = SteamGameSorter.sortByFinalPrice(onSaleGames);
      break;
  }

  updateCurrentSales();
}
