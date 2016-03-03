// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'SteamSaleServerConnector.dart';
import 'SteamGame.dart';
import 'SteamGameSorter.dart';
import 'dart:html';
import 'SteamSaleDisplayComponent.dart';
import 'User.dart';

Map<String, SteamGame> allGames;
Map<String, SteamGame> onSaleGames;
List<SteamGame> onSaleList;
User currentUser;
SteamSaleServerConnector server;


main() async {
  if (currentUser == null) {
    var watchlistData = querySelector("#watchlistData");
    watchlistData.setAttribute("class","hidden");
  } else {
    var watchlistData = querySelector("#watchlistData");
    watchlistData.setAttribute("class","");
  }

  server = new SteamSaleServerConnector();

  allGames = await server.getAllGames();
  onSaleGames = await server.getOnSaleGames();

  onSaleList = SteamGameSorter.sortByDiscountPercent(onSaleGames);

  var createAccountButton = querySelector("#createAccount");
  createAccountButton.onClick.listen(createUser);

  var loginButton = querySelector("#login");
  loginButton.onClick.listen(await login);

  if (currentUser != null) {
    updateCurrentSales();
  }


}

updateCurrentSales() async {
  if (currentUser == null) {
    var watchlistData = querySelector("#watchlistData");
    watchlistData.setAttribute("class","hidden");
  } else {
    var watchlistData = querySelector("#watchlistData");
    watchlistData.setAttribute("class","");
  }

  var element = querySelector('#sale-table');
  var header = element.children.elementAt(0);
  element.children.clear();

  element.children.add(header);

  List<SteamGame> usersGames = await server.getUsersGames(currentUser);

  for (SteamGame game in usersGames) {
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
}

void createUser([Event e]) {
  var createUsername = querySelector("#createUsername");
  var createPassword = querySelector("#createPassword");
  var createEmail = querySelector("#createEmail");

  if (createUsername.value.length > 0 && createPassword.value.length > 0 && createEmail.value.length > 0) {
    User newUser = new User(createUsername.value, createPassword.value, createEmail.value);
    newUser.addUser();
  }
}

login([Event e]) async {
  var username = querySelector("#username");
  var password = querySelector("#password");

  User user = await server.getUser(username.value.trim());

  if (user.getPassword().trim() == password.value.trim()) {
    currentUser = user;
    updateCurrentSales();
    var loginButton = querySelector("#loginDiv");
    loginButton.setAttribute("class","hidden");
    var signup = querySelector("#signUp");
    signup.setAttribute("class","hidden");
  }

}
