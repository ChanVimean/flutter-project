import 'package:flutter/material.dart';
import 'package:project/data/model/product.dart';
import 'package:project/data/service/cart_repository.dart';

class CartProvider extends ChangeNotifier {
  List<Product> _carts = [];
  bool _isLoading = false;

  List<Product> get carts => _carts;
  bool get isLoading => _isLoading;

  double get totalPrice =>
      _carts.fold(0, (sum, item) => sum + (item.price * (item.qty ?? 0)));

  Future<void> loadCart() async {
    _isLoading = true;
    try {
      _carts = await CartRepository.loadCart();
    } catch (e) {
      debugPrint("Error loading cart: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshCart() async {
    return await loadCart();
  }

  void addToCart(Product product, {int quantity = 1}) async {
    int index = _carts.indexWhere((p) => (p.uuid == product.uuid));

    if (index != -1) {
      _carts[index] = _carts[index].copyWith(
        qty: _carts[index].qty ?? 0 + quantity,
      );
    } else {
      _carts.add(product.copyWith(qty: quantity));
    }

    notifyListeners();
    await CartRepository.saveToCart(
      _carts.firstWhere((p) => p.uuid == product.uuid),
    );
  }

  void incrementQty(String uuid) async {
    final index = _carts.indexWhere((p) => p.uuid == uuid);
    if (index != -1) {
      _carts[index] = _carts[index].copyWith(qty: (_carts[index].qty ?? 0) + 1);
      notifyListeners();
      await CartRepository.saveToCart(_carts[index]);
    }
  }

  void decrementQty(String uuid) async {
    final index = _carts.indexWhere((p) => p.uuid == uuid);
    if (index == -1) return;
    if ((_carts[index].qty ?? 1) > 1) {
      _carts[index] = _carts[index].copyWith(qty: _carts[index].qty! - 1);
      notifyListeners();
      await CartRepository.saveToCart(_carts[index]);
    } else {
      removeFromCart(uuid);
    }
  }

  void removeFromCart(String uuid) async {
    _carts.removeWhere((item) => item.uuid == uuid);
    notifyListeners();
    await CartRepository.removeFromCart(uuid);
  }

  // Checkout list
  double subtotal() {
    double subtotal = 0;
    for (var c in carts) {
      subtotal += c.price * (c.qty ?? 0);
    }

    return subtotal;
  }

  double discount() {
    double staticDiscount = 0.1; // 10% discount
    final test = subtotal() * staticDiscount;

    return test;
  }

  double delivery() {
    return 10; // 10$ delivery fee
  }

  double total() {
    return subtotal() - discount() + delivery();
  }
}
