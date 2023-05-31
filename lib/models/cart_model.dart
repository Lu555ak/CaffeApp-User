import 'package:caffe_app_user/auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:caffe_app_user/models/menu_model.dart';

class Cart {
  static Cart? _instance;

  Cart._();

  factory Cart() => _instance ??= Cart._();

  final Map<String, int> _cart = {};
  final database = FirebaseDatabase.instance;

  int euroRate = 1;
  int creditsRate = 1;

  void getRates() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('loyalty').get();
    if (snapshot.exists) {
      euroRate = int.parse(snapshot.child("euroRate").value.toString());
      creditsRate = int.parse(snapshot.child("creditsRate").value.toString());
    }
  }

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

  double cartTotal() {
    double total = 0;
    for (var cartItem in Cart().getKeys()) {
      if (Menu().getMenuItemWithName(cartItem).getDiscount > 0) {
        total += Menu().getMenuItemWithName(cartItem).getPriceDiscount *
            Cart().getItemAmount(cartItem);
      } else {
        total += Menu().getMenuItemWithName(cartItem).getPrice *
            Cart().getItemAmount(cartItem);
      }
    }
    return total;
  }

  int cartPointsTotal() {
    return (cartTotal() / euroRate).round() * creditsRate;
  }

  List<String> getKeys() {
    return _cart.keys.toList();
  }

  Map<String, int> get getCart => _cart;

  int get getCartLength => _cart.length;

  void commitOrder(int tableId) async {
    int pointsTotal = cartPointsTotal();

    int orderNumber;
    final DatabaseReference orderLengthRef = database.ref("orders/");
    final snapshot = await orderLengthRef.get();
    if (snapshot.exists) {
      orderNumber = snapshot.children.length + 1;
    } else {
      orderNumber = 1;
    }

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    var user =
        users.where('uid', isEqualTo: Auth().currentUser?.uid).limit(1).get();

    await user.then((value) {
      var creditData = value.docs[0].data() as Map<String, dynamic>;
      value.docs[0].reference
          .update({"credits": (creditData["credits"] + pointsTotal)});
    });

    final DatabaseReference orderRef = database.ref("orders/order$orderNumber");
    await orderRef
        .set({"table": tableId, "accepted": false, "cart": _cart}).then(
            (value) => _cart.clear());
  }
}
