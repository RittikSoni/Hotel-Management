import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:hotel_management/constant/kstrings.dart';
import 'package:hotel_management/models/room_model.dart';
import 'package:hotel_management/models/user_model.dart';
import 'package:hotel_management/providers/room_provider.dart';
import 'package:hotel_management/utils/kloading.dart';
import 'package:hotel_management/utils/kroute.dart';
import 'package:provider/provider.dart';

class GuestsService {
  static Future fetchAllGuests() async {
    try {
      KLoadingToast.startLoading();
      final firestore = FirebaseFirestore.instance;

      final guestsData = await firestore
          .collection('users')
          .doc('guests')
          .collection('guests')
          .get();

      List<UserModel> listOfGuests = [];
      for (var e in guestsData.docs) {
        listOfGuests.add(
          UserModel.fromMap(
            e.data(),
          ),
        );
      }
      return listOfGuests;
    } catch (e) {
      KLoadingToast.showToast(
          msg: ErrorsHandlerValues.defaultEndUserErrorMessage);
      throw '$e';
    } finally {
      KLoadingToast.stopLoading();
    }
  }

  static checkoutGuest(
      {required String guestMail, required RoomModel roomDetails}) async {
    try {
      KLoadingToast.startLoading();
      final firestore = FirebaseFirestore.instance;

      await firestore
          .collection('bookings')
          .doc(guestMail)
          .collection('bookings')
          .doc(roomDetails.id)
          .update({'checkOutDate': DateTime.now().toIso8601String()});
      await firestore
          .collection('rooms')
          .doc(roomDetails.id)
          .update({'isBooked': false});

      Provider.of<RoomProvider>(navigatorKey.currentContext!, listen: false)
          .fetchRooms();
      Provider.of<RoomProvider>(navigatorKey.currentContext!, listen: false)
          .fetchRooms();
    } catch (e) {
      KLoadingToast.showToast(
          msg: ErrorsHandlerValues.defaultEndUserErrorMessage);
      print(e);
      throw ErrorsHandlerValues.defaultEndUserErrorMessage;
    } finally {
      KLoadingToast.stopLoading();
    }
  }
}
