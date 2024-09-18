import 'package:flutter/material.dart';
import 'package:hotel_management/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class BookingHistoryScreen extends StatelessWidget {
  const BookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking History'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Current Bookings',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            user?.currentBookings.isNotEmpty == true
                ? Expanded(
                    child: ListView.builder(
                      itemCount: user?.currentBookings.length,
                      itemBuilder: (context, index) {
                        final booking = user!.currentBookings[index];
                        return ListTile(
                          title:
                              Text('${booking.roomType} - ${booking.roomId}'),
                          subtitle: Text(
                              'Check-in: ${booking.checkInDate} \nCheck-out: ${booking.checkOutDate}'),
                        );
                      },
                    ),
                  )
                : const Center(
                    child: Text('No current bookings available'),
                  ),
            const SizedBox(height: 20),
            const Text('Past Bookings',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            user?.pastBookings.isNotEmpty == true
                ? Expanded(
                    child: ListView.builder(
                      itemCount: user?.pastBookings.length,
                      itemBuilder: (context, index) {
                        final booking = user!.pastBookings[index];
                        return ListTile(
                          title:
                              Text('${booking.roomType} - ${booking.roomId}'),
                          subtitle: Text(
                              'Check-in: ${booking.checkInDate} \nCheck-out: ${booking.checkOutDate}'),
                        );
                      },
                    ),
                  )
                : const Center(
                    child: Text('No past bookings available'),
                  ),
          ],
        ),
      ),
    );
  }
}
