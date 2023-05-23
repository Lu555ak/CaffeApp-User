class Cart {
  static Cart? _instance;

  Cart._();

  factory Cart() => _instance ??= Cart._();

  final Map<String, int> _cart = {};

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

  Map<String, int> get getCart => _cart;

  int get getCartLength => _cart.length;
}
