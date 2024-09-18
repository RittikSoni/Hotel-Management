import 'package:flutter/material.dart';
import '../models/room_model.dart';
import '../services/room_service.dart';

class RoomProvider with ChangeNotifier {
  List<RoomModel>? _rooms;

  List<RoomModel>? get rooms => _rooms;

  Future<void> fetchRooms() async {
    _rooms = await RoomService.getRooms();
    notifyListeners();
  }

  void bookRoom(RoomModel room) {
    room.isBooked = true;
    notifyListeners();
  }
}
