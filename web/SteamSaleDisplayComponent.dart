import "dart:html";
import 'SteamGame.dart';

class SteamSaleDisplayComponent {

  static TableRowElement buildComponent(SteamGame game) {
    TableRowElement tableRow = new TableRowElement();

    TableCellElement gameName = tableRow.insertCell(0);
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
    gameFinal.text = finalPrice;

    return tableRow;
  }
}