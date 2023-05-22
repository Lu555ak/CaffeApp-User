import 'package:cloud_firestore/cloud_firestore.dart';

class Menu {
  static Menu? _instance;

  Menu._();

  factory Menu() => _instance ??= Menu._();

  final List<MenuItem> _menu = List.empty(growable: true);

  int get getMenuLength => _menu.length;
  MenuItem getMenuItemAt(int index) => _menu[index];
  void addMenuItem(MenuItem menuItem) => _menu.add(menuItem);
  void clearMenu() => _menu.clear();

  Future loadFromDatabase() async {
    await FirebaseFirestore.instance.collection("menu").get().then((snapshot) {
      for (var menuItem in snapshot.docs) {
        addMenuItem(MenuItem(menuItem["name"], menuItem["price"],
            menuItem["discount"], menuItem["featured"]));
      }
    });
  }
}

class MenuItem {
  final String _name;
  final double _price;
  late double _priceDiscount;
  final int _discount;
  final bool _featured;

  MenuItem(this._name, this._price, this._discount, this._featured) {
    _priceDiscount = _price * (1 - _discount / 100);
  }

  String get getName => _name;
  double get getPrice => _price;
  double get getPriceDiscount => _priceDiscount;
  int get getDiscount => _discount;
  bool get getFeatured => _featured;
}
