import 'package:cloud_firestore/cloud_firestore.dart';

class Menu {
  static Menu? _instance;

  Menu._();

  factory Menu() => _instance ??= Menu._();

  final List<MenuItem> _menu = List.empty(growable: true);

  int get getMenuLength => _menu.length;
  MenuItem getMenuItemAt(int index) => _menu[index];
  MenuItem getMenuItemWithName(String name) =>
      _menu[_menu.indexWhere((element) => element.getName == name)];
  void addMenuItem(MenuItem menuItem) => _menu.add(menuItem);
  void clearMenu() => _menu.clear();

  void loadFromDatabase() async {
    _menu.clear();
    var collection = FirebaseFirestore.instance.collection('menu');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      addMenuItem(MenuItem(
          data["name"], data["price"], data["discount"], data["featured"]));
    }
  }

  List<MenuItem> getFeaturedItems() {
    List<MenuItem> featured = [];
    for (var element in _menu) {
      if (element.getFeatured == true) {
        featured.add(element);
      }
    }
    return featured;
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
