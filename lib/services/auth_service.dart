import 'package:hotel_management/constant/kenums.dart';

import '../models/user_model.dart';

class AuthService {
  static Future<UserModel?> login(String email, String password) async {
    // Demo login
    return UserModel(
        id: '123', name: 'Guest name', role: KEnumUserRole.guest.name);
    return UserModel(
        id: '123', name: 'Staff Name', role: KEnumUserRole.staff.name);
  }

  static Future<UserModel?> signup(
      String email, String password, String role) async {
    // Demo signup
    return UserModel(id: '456', name: 'Staff name', role: role);
  }

  static Future<void> logout() async {
    throw UnimplementedError();
  }
}
