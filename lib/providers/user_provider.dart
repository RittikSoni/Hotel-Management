import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotel_management/constant/kenums.dart';
import 'package:hotel_management/constant/kstrings.dart';
import 'package:hotel_management/providers/room_provider.dart';
import 'package:hotel_management/utils/kroute.dart';
import 'package:provider/provider.dart';
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
    } else {
      _user = UserModel.fromMap(jsonDecode(userData));
    }
    notifyListeners();
  }

  Future<void> loginGuestStaff({
    required String email,
    required String password,
    KEnumUserRole? role,
  }) async {
    _user = await AuthService.loginGuestStaff(
        email: email, password: password, role: role);
    notifyListeners();
  }

  Future<void> signupGuest(
      {required String name,
      required String email,
      required String password}) async {
    _user = await AuthService.registerGuest(
      emailAddress: email,
      password: password,
      name: name,
    );
    notifyListeners();
  }

  Future<void> logout() async {
    await AuthService.logout();
    _user = null;
    Provider.of<RoomProvider>(navigatorKey.currentContext!, listen: false)
        .reset();
    notifyListeners();
  }
}
