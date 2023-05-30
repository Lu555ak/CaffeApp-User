import 'package:firebase_database/firebase_database.dart';

class Cart {
  static Cart? _instance;

  Cart._();

  factory Cart() => _instance ??= Cart._();

  final Map<String, int> _cart = {};
  final database = FirebaseDatabase.instance;

  void addItem(String item, int amount) {
    if (amount == 0) return;
    if (_cart[item] == null) {
      _cart[item] = amount;
    } else {
      _cart[item] = _cart[item]! + amount;
    }
  }

  int getItemAmount(String item) {
    return _cart[item] ?? 0;
  }

  void reduceItemAmount(String item) {
    _cart[item] = _cart[item]! - 1;
    if (_cart[item] == 0) {
      _cart.remove(item);
    }
  }

  List<String> getKeys() {
    return _cart.keys.toList();
  }

  Map<String, int> get getCart => _cart;

  int get getCartLength => _cart.length;

  void commitOrder(int tableId) async {
    int orderNumber;
    final DatabaseReference orderLengthRef = database.ref("orders/");
    final snapshot = await orderLengthRef.get();
    if (snapshot.exists) {
      orderNumber = snapshot.children.length + 1;
    } else {
      orderNumber = 1;
    }

    final DatabaseReference orderRef = database.ref("orders/order$orderNumber");
    await orderRef.set({"table": tableId, "accepted": false, "cart": _cart});
    _cart.clear();
  }
}
