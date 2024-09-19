import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_management/constant/kstrings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_management/utils/kloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class AuthService {
  static Future<UserModel?>? login(String email, String password) async {
    try {
      final UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (credential.user != null) {
        try {
          final firestore = FirebaseFirestore.instance;
          const String userRole = 'guest';

          final endUsersData = await firestore
              .doc('users/guests')
              .collection('guests')
              .doc(email)
              .get();

          bool isUsernameExist = endUsersData.exists;

          if (isUsernameExist) {
            final DateTime finalCreatedAt2 =
                DateTime.parse(endUsersData.get('createdAt'));
            final DateTime finalUpdateAt2 =
                DateTime.parse(endUsersData.get('updatedAt'));

            final UserModel userDataModel = UserModel(
              id: endUsersData.get('id'),
              name: endUsersData.get('name'),
              email: endUsersData.get('email'),
              role: userRole,
              bookings: endUsersData.get('bookings'),
              createdAt: finalCreatedAt2,
              updatedAt: finalUpdateAt2,
            );

            final Map<String, dynamic> userJsonData = userDataModel.toMap();
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            await prefs.setString(
                KPrefsKeys.userData, jsonEncode(userJsonData));

            return userDataModel;
          }
          KLoadingToast.showToast(msg: ErrorsHandlerValues.notARegisterUser);
          throw ErrorsHandlerValues.notARegisterUser;
        } catch (e) {
          KLoadingToast.showToast(
              msg: ErrorsHandlerValues.defaultEndUserErrorMessage);
          throw 'Error during username check $e';
        }
      }
      KLoadingToast.showToast(
        msg: credential.user.toString(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        KLoadingToast.showToast(msg: ErrorsHandlerValues.passOrEmailInvalid);
        throw ErrorsHandlerValues.passOrEmailInvalid;
      } else if (e.code == 'wrong-password') {
        KLoadingToast.showToast(msg: ErrorsHandlerValues.passOrEmailInvalid);

        throw ErrorsHandlerValues.passOrEmailInvalid;
      } else if (e.toString().contains('INVALID_LOGIN_CREDENTIALS')) {
        KLoadingToast.showToast(msg: ErrorsHandlerValues.passOrEmailInvalid);
        throw ErrorsHandlerValues.passOrEmailInvalid;
      } else if (e.toString().contains(
          '[firebase_auth/invalid-email] The email address is badly formatted')) {
        KLoadingToast.showToast(msg: ErrorsHandlerValues.passOrEmailInvalid);
        throw ErrorsHandlerValues.passOrEmailInvalid;
      } else {
        KLoadingToast.showToast(
            msg: ErrorsHandlerValues.defaultEndUserErrorMessage);

        throw 'Something went wrong during login $e';
      }
    }
    KLoadingToast.showToast(
        msg: ErrorsHandlerValues.defaultEndUserErrorMessage);

    throw 'Something went wrong during login process.';
  }

  static Future<UserModel?> signup(
      String email, String password, String role) async {
    throw UnimplementedError();
  }

  static Future<void> logout() async {
    throw UnimplementedError();
  }
}
