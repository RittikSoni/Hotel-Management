import '../models/room_model.dart';

class RoomService {
  static Future<List<RoomModel>> getRooms() async {
    // Simulate fetching rooms from Firestore
    // Demo data
    return [
      RoomModel(id: '1', type: 'Deluxe', price: 200, amenities: ['WiFi', 'TV']),
      RoomModel(id: '2', type: 'Standard', price: 100, amenities: ['WiFi']),
    ];
  }
}
