import 'SteamGame.dart';

class SteamGameSorter {

  static List<SteamGame> sortByName(Map<String, SteamGame> gameList) {
    List<SteamGame> list = new List();

    for (SteamGame s in gameList.values) {
      list.add(s);
    }

    list.sort((a,b) => _getName(a).compareTo(_getName(b)));

    return list;
  }

  static List<SteamGame> sortByFinalPrice(Map<String, SteamGame> gameList) {
    List<SteamGame> list = new List();

    for (SteamGame s in gameList.values) {
      list.add(s);
    }

    list.sort((a,b) => _getFinalPrice(b).compareTo(_getFinalPrice(a)));

    return list;
  }

  static List<SteamGame> sortByInitialPrice(Map<String, SteamGame> gameList) {
    List<SteamGame> list = new List();

    for (SteamGame s in gameList.values) {
      list.add(s);
    }

    list.sort((a,b) => _getInitialPrice(b).compareTo(_getInitialPrice(a)));

    return list;
  }

  static List<SteamGame> sortByDiscountPercent(Map<String, SteamGame> gameList) {
    List<SteamGame> list = new List();

    for (SteamGame s in gameList.values) {
      list.add(s);
    }

    list.sort((a,b) => _getDiscountPercent(b).compareTo(_getDiscountPercent(a)));

    return list;
  }

  static String _getName(SteamGame game) {
    return game.getName();
  }

  static int _getDiscountPercent(SteamGame game) {
    return game.getDiscountPercent();
  }

  static int _getFinalPrice(SteamGame game) {
    return game.getFinalPrice();
  }

  static int _getInitialPrice(SteamGame game) {
    return game.getInitialPrice();
  }





}