import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;
  String? get role => _user?.role;

  Future<void> login(String email, String password) async {
    _user = await AuthService.login(email, password);
    notifyListeners();
  }

  Future<void> signup(String email, String password, String role) async {
    _user = await AuthService.signup(email, password, role);
    notifyListeners();
  }

  Future<void> logout() async {
    await AuthService.logout();
    _user = null;
    notifyListeners();
  }
}
