import 'package:flutter/material.dart';
import 'package:project/data/model/product.dart';
import 'package:project/data/service/api_service.dart';

class ProductProvider extends ChangeNotifier {
  // Private Identifiers
  List<Product> _products = [];
  bool _isLoading = false;
  String? _isError;

  // Getter
  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get isError => _isError;

  // Logic
  Future<void> fetchProduct() async {
    _isLoading = true;
    notifyListeners();
    try {
      _products = await ApiService.getProduct();
    } catch (e) {
      _products = [];
      _isError = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    return await fetchProduct();
  }
}
