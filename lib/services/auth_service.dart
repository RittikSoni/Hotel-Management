import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_management/constant/kenums.dart';
import 'package:hotel_management/constant/kstrings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_management/screens/auth/login_home_screen.dart';
import 'package:hotel_management/screens/guest/guest_home_screen.dart';
import 'package:hotel_management/screens/staff/staff_dashboard_screen.dart';
import 'package:hotel_management/utils/kloading.dart';
import 'package:hotel_management/utils/kroute.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class AuthService {
  static Future<void> _addMustFieldIfDocContainsOnlySubCollection(
      {required String docPath}) async {
    await FirebaseFirestore.instance.doc(docPath).set({
      'readme': '_',
      'forMoreInfo':
          'https://firebase.google.com/docs/firestore/using-console?hl=en&authuser=0&_gl=1*1alzu52*_ga*ODYwNzgwODAyLjE2ODg2NTU4NDc.*_ga_CW55HF8NVT*MTcwMDM3MjM1Ny4xMzYuMS4xNzAwMzg3MTM3LjYwLjAuMA..#non-existent_ancestor_documents'
    });
  }

  static Future<UserModel?>? registerGuest({
    required String name,
    required String emailAddress,
    required String password,
  }) async {
    try {
      KLoadingToast.startLoading();
      final UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailAddress, password: password);

      if (credential.user != null) {
        const String userRole = 'guest';

        // Create a batch for Firestore writes
        final WriteBatch batch = FirebaseFirestore.instance.batch();

        // PREVENT ITALIC DOC (EMPTY DOC), SO JUST ADD RANDOM FIELD
        _addMustFieldIfDocContainsOnlySubCollection(docPath: 'users/guests');

        // Create a new user document in Firestore
        final DocumentReference userDocRef =
            FirebaseFirestore.instance.doc('users/guests/guests/$emailAddress');

        final UserModel userDataModel = UserModel(
          id: emailAddress,
          name: name,
          email: emailAddress,
          role: userRole,
          createdAt: DateTime.now().toLocal(),
          updatedAt: DateTime.now().toLocal(),
        );
        batch.set(
          userDocRef,
          userDataModel.toMap(),
        );

        // Commit the batch
        await batch.commit();

        final Map<String, dynamic> userJsonData = userDataModel.toMap();
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(KPrefsKeys.userData, jsonEncode(userJsonData));

        KRoute.pushRemove(
            context: navigatorKey.currentContext!,
            page: const GuestHomeScreen());

        return userDataModel;
      }
      KLoadingToast.showToast(msg: ErrorsHandlerValues.registrationFailed);
      throw ErrorsHandlerValues.registrationFailed;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        KLoadingToast.showToast(msg: ErrorsHandlerValues.emailInUse);
        throw ErrorsHandlerValues.emailInUse;
      } else {
        KLoadingToast.showToast(msg: ErrorsHandlerValues.registrationFailed);
        throw ErrorsHandlerValues.registrationFailed;
      }
    } finally {
      KLoadingToast.stopLoading();
    }
  }

  static Future<UserModel?>? loginGuestStaff(
      {required String email,
      required String password,
      KEnumUserRole? role}) async {
    try {
      KLoadingToast.startLoading();
      final UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (credential.user != null) {
        try {
          final firestore = FirebaseFirestore.instance;
          final String userRole = role?.name ?? KEnumUserRole.guest.name;
          final DocumentSnapshot<Map<String, dynamic>> endUsersData;
          if (userRole == KEnumUserRole.guest.name) {
            endUsersData = await firestore
                .doc('users/guests')
                .collection('guests')
                .doc(email)
                .get();
          } else {
            endUsersData = await firestore
                .doc('users/staffs')
                .collection('staffs')
                .doc(email)
                .get();
          }

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
              createdAt: finalCreatedAt2,
              updatedAt: finalUpdateAt2,
            );

            final Map<String, dynamic> userJsonData = userDataModel.toMap();
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            await prefs.setString(
                KPrefsKeys.userData, jsonEncode(userJsonData));
            if (userDataModel.role == KEnumUserRole.staff.name) {
              KRoute.pushRemove(
                  context: navigatorKey.currentContext!,
                  page: const StaffDashboardScreen());
            } else {
              KRoute.pushRemove(
                  context: navigatorKey.currentContext!,
                  page: const GuestHomeScreen());
            }
            return userDataModel;
          }
          KLoadingToast.showToast(msg: ErrorsHandlerValues.notARegisterUser);
          throw ErrorsHandlerValues.notARegisterUser;
        } catch (e) {
          KLoadingToast.showToast(
              msg: ErrorsHandlerValues.defaultEndUserErrorMessage);
          return KDummyModelData.notARegisteredUser;
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
    } finally {
      KLoadingToast.stopLoading();
    }
    KLoadingToast.showToast(
        msg: ErrorsHandlerValues.defaultEndUserErrorMessage);

    throw 'Something went wrong during login process.';
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();

    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    KRoute.pushRemove(
        context: navigatorKey.currentContext!, page: const LoginScreen());
  }
}
