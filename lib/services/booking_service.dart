import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_management/providers/user_provider.dart';
import 'package:hotel_management/utils/kloading.dart';
import 'package:hotel_management/utils/kroute.dart';
import 'package:provider/provider.dart';
import '../models/room_model.dart';

class BookingService {
  static Future bookRoom({required RoomModel roomData}) async {
    try {
      final currentUser =
          Provider.of<UserProvider>(navigatorKey.currentContext!, listen: false)
              .user;
      KLoadingToast.startLoading();
      final firestore = FirebaseFirestore.instance;
      await _addMustFieldIfDocContainsOnlySubCollection(
          docPath: 'bookings/${currentUser?.email}');
      await firestore
          .collection('bookings')
          .doc(currentUser?.email)
          .collection('bookings')
          .doc(roomData.id)
          .set(roomData.toMap());
      await firestore.collection('rooms').doc(roomData.id).update(
        {'isBooked': true},
      );
    } catch (e) {
      print(e);
      KLoadingToast.showToast(
          msg: 'Something went wrong, please try again later.');
      throw '$e';
    } finally {
      KLoadingToast.stopLoading();
    }
  }

  static Future<void> _addMustFieldIfDocContainsOnlySubCollection(
      {required String docPath}) async {
    await FirebaseFirestore.instance.doc(docPath).set({
      'readme': '_',
      'forMoreInfo':
          'https://firebase.google.com/docs/firestore/using-console?hl=en&authuser=0&_gl=1*1alzu52*_ga*ODYwNzgwODAyLjE2ODg2NTU4NDc.*_ga_CW55HF8NVT*MTcwMDM3MjM1Ny4xMzYuMS4xNzAwMzg3MTM3LjYwLjAuMA..#non-existent_ancestor_documents'
    });
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<RoomModel>> fetchCurrentBookings(String userEmail) async {
    final now = DateTime.now();

    QuerySnapshot querySnapshot = await _firestore
        .collection('bookings')
        .doc(userEmail)
        .collection('bookings')
        .where('checkOutDate', isGreaterThanOrEqualTo: now.toIso8601String())
        .get();

    List<RoomModel> currentBookings = querySnapshot.docs.map((doc) {
      return RoomModel.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();

    return currentBookings;
  }

  Future<List<RoomModel>> fetchHistoryBookings(String userEmail) async {
    final now = DateTime.now();

    QuerySnapshot querySnapshot = await _firestore
        .collection('bookings')
        .doc(userEmail)
        .collection('bookings')
        .where('checkOutDate', isLessThan: now.toIso8601String())
        .get();

    List<RoomModel> historyBookings = querySnapshot.docs.map((doc) {
      return RoomModel.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();

    return historyBookings;
  }
}
