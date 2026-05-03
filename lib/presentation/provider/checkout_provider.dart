import 'package:flutter/material.dart';

class CheckoutProvider extends ChangeNotifier {
  int _selectedDelivery = 1;
  String _selectedPaymentId = 'card_1';

  int get selectedDelivery => _selectedDelivery;
  String get selectedPaymentId => _selectedPaymentId;

  void setDelivery(int value) {
    _selectedDelivery = value;
    notifyListeners();
  }

  void setPayment(String id) {
    _selectedPaymentId = id;
    notifyListeners();
  }
}
