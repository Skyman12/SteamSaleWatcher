class SteamGame {

  String _name;
  Map _data;

  SteamGame(String name, Map data) {
    _name = name;
    _data = data;
  }

  int getFinalPrice() {
    return _data["final"];
  }

  int getInitialPrice() {
    return _data["initial"];
  }

  int getDiscountPercent() {
    return _data["discount_percent"];
  }

  String getName()
  {
    return _name;
  }

}