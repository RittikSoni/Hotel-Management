class RoomModel {
  final String id;
  final String type; // Deluxe, Standard, Suite
  final double price;
  final List<String> amenities; // like, Free Wi-fi, 2BHK, 1BHK, etc
  bool isBooked;

  DateTime? checkInDate;
  DateTime? checkOutDate;

  RoomModel({
    required this.id,
    required this.type,
    required this.price,
    required this.amenities,
    this.isBooked = false,
    this.checkInDate,
    this.checkOutDate,
  });

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      id: map['id'],
      type: map['type'],
      price: map['price'],
      amenities: List<String>.from(map['amenities']),
      isBooked: map['isBooked'] ?? false,
      checkInDate: map['checkInDate'] != null
          ? DateTime.parse(map['checkInDate'])
          : null,
      checkOutDate: map['checkOutDate'] != null
          ? DateTime.parse(map['checkOutDate'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'price': price,
      'amenities': amenities,
      'isBooked': isBooked,
      if (checkInDate != null) 'checkInDate': checkInDate?.toIso8601String(),
      if (checkOutDate != null) 'checkOutDate': checkOutDate?.toIso8601String(),
    };
  }
}
