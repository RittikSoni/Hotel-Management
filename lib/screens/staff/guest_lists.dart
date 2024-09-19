import 'package:flutter/material.dart';
import 'package:hotel_management/models/user_model.dart';
import 'package:hotel_management/screens/guest/booking_list_screen.dart';
import 'package:hotel_management/services/guests_service.dart';
import 'package:hotel_management/utils/kroute.dart';

class GuestLists extends StatelessWidget {
  const GuestLists({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guest lists'),
      ),
      body: FutureBuilder(
        future: GuestsService.fetchAllGuests(),
        builder: (context, snapshot) {
          if (!snapshot.hasData ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
          return _guestList(snapshot.data);
        },
      ),
    );
  }

  _guestList(List<UserModel> data) {
    return Column(
      children: [
        data.isEmpty
            ? const Center(
                child: Text('No Guests found'),
              )
            : Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final currentGuest = data[index];

                    return ListTile(
                      title: Text(currentGuest.name),
                      subtitle: Text(currentGuest.email),
                      trailing: ElevatedButton(
                        onPressed: () {
                          KRoute.push(
                            context: context,
                            page: BookingListScreen(
                                userEmail: currentGuest.email),
                          );
                        },
                        child: const Text('Check bookings'),
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
