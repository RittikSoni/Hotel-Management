import 'package:hotel_management/models/booking_model.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String role; // 'guest' or 'staff'
  final List<BookingModel>? bookings; // Allow null for bookings

  DateTime createdAt;
  DateTime updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    this.bookings,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    var bookingList = map['bookings'] as List<dynamic>?;

    // If bookings are null, assign an empty list
    List<BookingModel> bookings = bookingList != null
        ? bookingList.map((b) => BookingModel.fromMap(b)).toList()
        : [];

    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      role: map['role'],
      bookings: bookings,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'bookings': bookings?.map((b) => b.toMap()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Filter bookings as current based on check-in/check-out dates
  List<BookingModel> get currentBookings {
    return bookings?.where((b) => b.isCurrent()).toList() ?? [];
  }

  // Filter bookings as past based on check-out date
  List<BookingModel> get pastBookings {
    return bookings?.where((b) => b.isPast()).toList() ?? [];
  }
}
