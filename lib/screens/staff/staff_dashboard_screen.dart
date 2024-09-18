import 'package:flutter/material.dart';

class StaffDashboardScreen extends StatelessWidget {
  const StaffDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to guest management
              },
              child: const Text('Manage Guests'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to room availability
              },
              child: const Text('Check Room Availability'),
            ),
          ],
        ),
      ),
    );
  }
}
