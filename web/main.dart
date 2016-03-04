// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'SteamSaleServerConnector.dart';
import 'User.dart';
import 'SteamGameSorter.dart';
import 'dart:math';


Map<String, SteamGame> onSaleGames;
List<SteamGame> onSaleList;

main() async {
  querySelector('#output').text = 'Your Dart app is running.';
  SteamSaleServerConnector server = new SteamSaleServerConnector();
  server.addUserToDatabase(new User("Test", "Test" , "Test"));

  onSaleGames = await server.getOnSaleGames();
  onSaleList = SteamGameSorter.sortByDiscountPercent(onSaleGames);
  updateCarousel();
}

void updateCarousel()
{
  var carousel = querySelector('.carousel-inner');
  for(int i = 0; i < 5; ++i)
  {
    var rng = new Random();
    var rand = rng.nextInt(onSaleList.length);
    print(rand);
    carousel.children.add(buildCarouselItem(onSaleList[rand].getName(), onSaleList[rand].getDiscountPercent()));
  }
  carousel.children[0].className = "item active";
//  print(carousel.children);
}

DivElement buildCarouselItem(var gameName, var discount) {
  DivElement item = new DivElement();
  HeadingElement inner = new HeadingElement.h1();

  item.className = "item";
  inner.className = "carousel";
  inner.setInnerHtml(gameName + " is on sale for " + discount.toString() + "%");
  item.children.add(inner);

  /*TableCellElement gameName = tableRow.insertCell(0);
  gameName.text = game.getName();

  TableCellElement gameDiscount = tableRow.insertCell(1);
  gameDiscount.text = game.getDiscountPercent().toString() + "%";

  TableCellElement gameInitial = tableRow.insertCell(2);
  String initialPrice = game.getInitialPrice().toString();
  if (initialPrice.length > 1) {
   initialPrice = initialPrice.substring(0,initialPrice.length - 2) + "." + initialPrice.substring(initialPrice.length - 2, initialPrice.length);
  }
  gameInitial.text = initialPrice;

  TableCellElement gameFinal = tableRow.insertCell(3);
  String finalPrice = game.getFinalPrice().toString();
  if (finalPrice.length > 1) {
    finalPrice = finalPrice.substring(0,finalPrice.length - 2) + "." + finalPrice.substring(finalPrice.length - 2, finalPrice.length);
  }
  gameFinal.text = finalPrice;*/

  return item;
}
