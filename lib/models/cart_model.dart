import 'package:caffe_app_user/auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:caffe_app_user/models/menu_model.dart';
import 'package:flutter/material.dart';

class Cart {
  static Cart? _instance;

  Cart._();

  factory Cart() => _instance ??= Cart._();

  final Map<String, int> _cart = {};
  final Map<String, int> _creditCart = {};
  final database = FirebaseDatabase.instance;

  ValueNotifier<int> credits = ValueNotifier(0);
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

  void getCredits() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    var user = users.where('uid', isEqualTo: Auth().currentUser?.uid).limit(1).get();

    user.then((value) {
      var d = value.docs[0].data() as Map<String, dynamic>;
      credits.value = d["credits"];
    });
  }

  void updateCredits(int credit) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    var user = users.where('uid', isEqualTo: Auth().currentUser?.uid).limit(1).get();

    user.then((value) {
      value.docs[0].reference.update({"credits": credit});
    });
    credits.value = credit;
  }

  void addItem(String item, int amount) {
    if (amount == 0) return;
    if (_cart[item] == null) {
      _cart[item] = amount;
    } else {
      _cart[item] = _cart[item]! + amount;
    }
  }

  void addCreditsItem(String item) {
    if (_creditCart[item] == null) {
      _creditCart[item] = 1;
    } else {
      _creditCart[item] = _creditCart[item]! + 1;
    }
  }

  int getItemAmount(String item) {
    return _cart[item] ?? 0;
  }

  int getCreditsItemLength() {
    return _creditCart.length;
  }

  int getCreditsItemAmount(String item) {
    return _creditCart[item] ?? 0;
  }

  void reduceItemAmount(String item) {
    _cart[item] = _cart[item]! - 1;
    if (_cart[item] == 0) {
      _cart.remove(item);
    }
  }

  void reduceCreditsItemAmount(String item) {
    _creditCart[item] = _creditCart[item]! - 1;
    if (_creditCart[item] == 0) {
      _creditCart.remove(item);
    }
  }

  double cartTotal() {
    double total = 0;
    for (var cartItem in Cart().getKeys()) {
      if (Menu().getMenuItemWithName(cartItem).getDiscount > 0) {
        total += Menu().getMenuItemWithName(cartItem).getPriceDiscount * Cart().getItemAmount(cartItem);
      } else {
        total += Menu().getMenuItemWithName(cartItem).getPrice * Cart().getItemAmount(cartItem);
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

  List<String> getCreditsKeys() {
    return _creditCart.keys.toList();
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
    var user = users.where('uid', isEqualTo: Auth().currentUser?.uid).limit(1).get();

    await user.then((value) {
      var creditData = value.docs[0].data() as Map<String, dynamic>;
      value.docs[0].reference.update({"credits": (creditData["credits"] + pointsTotal)});
      credits.value = creditData["credits"] + pointsTotal;
    }).then((value) => getCredits());

    final DatabaseReference orderRef = database.ref("orders/order$orderNumber");
    await orderRef.set({"table": tableId, "accepted": false, "cart": _cart, "creditCart": _creditCart}).then((value) {
      _cart.clear();
      _creditCart.clear();
    });
  }
}
