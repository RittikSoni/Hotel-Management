import 'package:flutter/material.dart';
import 'package:hotel_management/models/room_model.dart';
import 'package:hotel_management/services/booking_service.dart';

class BookingListScreen extends StatefulWidget {
  final String userEmail;

  const BookingListScreen({super.key, required this.userEmail});

  @override
  BookingListScreenState createState() => BookingListScreenState();
}

class BookingListScreenState extends State<BookingListScreen> {
  late Future<List<RoomModel>> _currentBookings;
  late Future<List<RoomModel>> _historyBookings;

  @override
  void initState() {
    super.initState();
    final bookingService = BookingService();
    _currentBookings = bookingService.fetchCurrentBookings(widget.userEmail);
    _historyBookings = bookingService.fetchHistoryBookings(widget.userEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Bookings'),
      ),
      body: Column(
        children: [
          // Current Bookings Section
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Current Bookings', style: TextStyle(fontSize: 18)),
          ),
          Expanded(
            child: FutureBuilder<List<RoomModel>>(
              future: _currentBookings,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(
                      child: Text('Error fetching current bookings.'));
                }

                final currentBookings = snapshot.data ?? [];

                if (currentBookings.isEmpty) {
                  return const Center(child: Text('No current bookings.'));
                }

                return ListView.builder(
                  itemCount: currentBookings.length,
                  itemBuilder: (context, index) {
                    final booking = currentBookings[index];
                    return BookingCard(booking: booking);
                  },
                );
              },
            ),
          ),

          // History Bookings Section
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Booking History', style: TextStyle(fontSize: 18)),
          ),
          Expanded(
            child: FutureBuilder<List<RoomModel>>(
              future: _historyBookings,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(
                      child: Text('Error fetching booking history.'));
                }

                final historyBookings = snapshot.data ?? [];

                if (historyBookings.isEmpty) {
                  return const Center(child: Text('No booking history.'));
                }

                return ListView.builder(
                  itemCount: historyBookings.length,
                  itemBuilder: (context, index) {
                    final booking = historyBookings[index];
                    return BookingCard(booking: booking);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final RoomModel booking;

  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('${booking.type} - \$${booking.price}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Amenities: ${booking.amenities.join(', ')}'),
            Text(
                'Check-in: ${booking.checkInDate?.toLocal().toString().split(' ')[0]}'),
            Text(
                'Check-out: ${booking.checkOutDate?.toLocal().toString().split(' ')[0]}'),
          ],
        ),
      ),
    );
  }
}
