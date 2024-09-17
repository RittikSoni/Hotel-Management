class RoomModel {
  final String id;
  final String type; // Deluxe, Standard
  final double price;
  final List<String> amenities; // like, Free Wi-fi, 2BHK, 1BHK, etc
  bool isBooked;

  RoomModel({
    required this.id,
    required this.type,
    required this.price,
    required this.amenities,
    this.isBooked = false,
  });

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      id: map['id'],
      type: map['type'],
      price: map['price'],
      amenities: List<String>.from(map['amenities']),
      isBooked: map['isBooked'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'price': price,
      'amenities': amenities,
      'isBooked': isBooked,
    };
  }
}
