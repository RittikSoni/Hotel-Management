import 'package:flutter/material.dart';
import 'package:hotel_management/screens/guest/room_list_screen.dart';
import 'package:hotel_management/screens/staff/guest_lists.dart';
import 'package:hotel_management/services/auth_service.dart';
import 'package:hotel_management/utils/common_functions.dart';
import 'package:hotel_management/utils/kroute.dart';

class StaffDashboardScreen extends StatelessWidget {
  const StaffDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              AuthService.logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                KRoute.push(context: context, page: const GuestLists());
              },
              child: const Text('Manage Guests'),
            ),
            Commonfunctions.gapMultiplier(),
            ElevatedButton(
              onPressed: () {
                KRoute.push(
                  context: context,
                  page: const RoomListScreen(),
                );
              },
              child: const Text('Check Room Availability'),
            ),
          ],
        ),
      ),
    );
  }
}
