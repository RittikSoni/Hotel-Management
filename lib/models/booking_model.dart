class BookingModel {
  final String bookingId;
  final String roomId;
  final String roomType;
  final DateTime checkInDate;
  final DateTime checkOutDate;

  BookingModel({
    required this.bookingId,
    required this.roomId,
    required this.roomType,
    required this.checkInDate,
    required this.checkOutDate,
  });

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      bookingId: map['bookingId'],
      roomId: map['roomId'],
      roomType: map['roomType'],
      checkInDate: DateTime.parse(map['checkInDate']),
      checkOutDate: DateTime.parse(map['checkOutDate']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bookingId': bookingId,
      'roomId': roomId,
      'roomType': roomType,
      'checkInDate': checkInDate.toIso8601String(),
      'checkOutDate': checkOutDate.toIso8601String(),
    };
  }

  // Check if booking is current based on today's date
  bool isCurrent() {
    final currentDate = DateTime.now();
    return checkInDate.isBefore(currentDate) &&
        checkOutDate.isAfter(currentDate);
  }

  // Check if booking is past based on today's date
  bool isPast() {
    final currentDate = DateTime.now();
    return checkOutDate.isBefore(currentDate);
  }
}
