import '../models/room_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class RoomService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> getRooms(
      {bool? isAvailable, String? roomType, double? maxPrice}) async {
    Query query = _firestore.collection('rooms');

    // Apply filters
    if (isAvailable != null) {
      query = query.where('isBooked', isEqualTo: !isAvailable);
    }
    if (roomType != null && roomType.isNotEmpty) {
      query = query.where('type', isEqualTo: roomType);
    }
    if (maxPrice != null) {
      query = query.where('price', isLessThanOrEqualTo: maxPrice);
    }

    // Rest of the fetch code
  }

  Future<bool> bookRoom(String roomId, String userId) async {
    try {
      DocumentReference roomRef = _firestore.collection('rooms').doc(roomId);

      return await _firestore.runTransaction((transaction) async {
        DocumentSnapshot roomSnapshot = await transaction.get(roomRef);

        if (!roomSnapshot.exists) {
          throw Exception("Room does not exist!");
        }

        RoomModel room =
            RoomModel.fromMap(roomSnapshot.data() as Map<String, dynamic>);

        // Check if the room is already booked
        if (room.isBooked) {
          throw Exception("Room is already booked!");
        }

        // If not booked, proceed with booking
        transaction.update(roomRef, {'isBooked': true});

        // You can also add booking information to a 'bookings' collection here
        DocumentReference bookingRef = _firestore.collection('bookings').doc();
        transaction.set(bookingRef, {
          'roomId': roomId,
          'userId': userId,
          'bookingDate': DateTime.now(),
          'checkInDate': DateTime.now(), // Sample data, replace as needed
          'checkOutDate': DateTime.now().add(Duration(days: 2)), // Sample data
        });

        return true;
      });
    } catch (e) {
      print('Error booking room: $e');
      return false;
    }
  }
}
