import 'package:flutter/material.dart';
import 'package:hotel_management/constant/kstrings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;
  String? get role => _user?.role;

  Future<void> fetchSavedUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(KPrefsKeys.userData);
    if (userData == null) {
      _user = KDummyModelData.notARegisteredUser;
    }
    notifyListeners();
  }

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
