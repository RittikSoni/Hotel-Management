import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/room_model.dart';
import 'package:flutter/material.dart';

class RoomProvider with ChangeNotifier {
  List<RoomModel>? rooms;

  // Firestore reference
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch rooms with optional filters
  Future<void> fetchRooms(
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

    try {
      QuerySnapshot querySnapshot = await query.get();
      rooms = querySnapshot.docs
          .map((doc) => RoomModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      notifyListeners(); // Notify UI to rebuild with new data
    } catch (e) {
      print('Error fetching rooms: $e');
      rooms = [];
    }
  }
}
