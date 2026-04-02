import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/data/service/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  bool isLoading = false;

  User? get user => _user;

  Future<User?> register(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();
      _user = await _authService.register(email, password);
      return user;
    } catch (e) {
      log('$e');
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();
      _user = await _authService.login(email, password);
      return user;
    } catch (e) {
      log('$e');
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _authService.signOut();
    _user = null;
    notifyListeners();
  }
}
