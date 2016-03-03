// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'SteamSaleServerConnector.dart';
import 'SteamGame.dart';
import 'SteamGameSorter.dart';
import 'dart:html';
import 'WatchlistDisplayComponent.dart';
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

  addGamesToSelector();
  addDiscountsToSelector();

  var loginDiv = querySelector("#loginDiv");
  loginDiv.setAttribute("class","");
  var signup = querySelector("#signUp");
  signup.setAttribute("class","");

  querySelector("#dataloading").style.visibility = "hidden";
  querySelector("#progressBar").style.visibility = "hidden";

  var createAccountButton = querySelector("#createAccount");
  createAccountButton.onClick.listen(createUser);

  var loginButton = querySelector("#login");
  loginButton.onClick.listen(login);

  var addButton = querySelector("#add");
  addButton.onClick.listen(addGame);

  var removeButton = querySelector("#remove");
  removeButton.onClick.listen(removeGame);

  var updateButton = querySelector("#update");
  updateButton.onClick.listen(updatePrice);

  if (currentUser != null) {
    updateCurrentSales();
  }


}

addGamesToSelector() {
  var watchlistData = querySelector("#gamesListSelection");
  List<SteamGame> sorted = SteamGameSorter.sortByName(allGames);
  for ( SteamGame s in sorted) {
    OptionElement element = new OptionElement();
    element.text = s.getName();
    watchlistData.children.add(element);
  }
}

addDiscountsToSelector() {
  var discount = querySelector("#discountSelection");
  for (int i = 0; i < 100; i++) {
    OptionElement element = new OptionElement();
    element.text = i.toString();
    discount.children.add(element);
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
    element.children.add(WatchlistDisplayComponent.buildComponent(game, allGames[game.getName()]));
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

void addGame([Event e]) {
  var game = querySelector("#gamesListSelection");
  var discount = querySelector("#discountSelection");

  currentUser.addGameToUser(game.children.elementAt(game.selectedIndex).text, int.parse(discount.children.elementAt(discount.selectedIndex).text));
}

void removeGame([Event e]) {
  var game = querySelector("#gamesListSelection");
  var discount = querySelector("#discountSelection");

  currentUser.removeGameFromUser(game.children.elementAt(game.selectedIndex).text);
}

void updatePrice([Event e]) {
  var game = querySelector("#gamesListSelection");
  var discount = querySelector("#discountSelection");

  currentUser.changeDiscountOfGame(game.children.elementAt(game.selectedIndex).text, int.parse(discount.children.elementAt(discount.selectedIndex).text));
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
