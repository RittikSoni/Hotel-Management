import 'package:flutter/material.dart';
import 'package:hotel_management/utils/common_functions.dart';
import 'package:hotel_management/utils/kloading.dart';
import 'package:provider/provider.dart';
import '../../providers/room_provider.dart';

class RoomListScreen extends StatelessWidget {
  const RoomListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context);

    if (roomProvider.rooms == null) {
      roomProvider.fetchRooms();
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rooms'),
      ),
      body: ListView.builder(
        itemCount: roomProvider.rooms?.length,
        itemBuilder: (context, index) {
          final room = roomProvider.rooms![index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const FlutterLogo(
                    size: 100.0,
                  ),
                  ListTile(
                    title: Text('${room.type} - \$${room.price}'),
                    subtitle: Text('Amenities: ${room.amenities.join(', ')}'),
                    trailing: room.isBooked
                        ? const Icon(Icons.check, color: Colors.green)
                        : ElevatedButton(
                            onPressed: () {
                              KLoadingToast.showDialogMultipleButtons(
                                  title: 'Book Room',
                                  content: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(room.type),
                                          Text(room.price.toString()),
                                        ],
                                      ),
                                      Text(room.amenities.join(', ')),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              decoration: const InputDecoration(
                                                  label: Text('From')),
                                              onTap: () {
                                                showDatePicker(
                                                    context: context,
                                                    firstDate: DateTime.now(),
                                                    lastDate:
                                                        DateTime(2035, 1, 1));
                                              },
                                            ),
                                          ),
                                          Commonfunctions.gapMultiplier(
                                              isHorizontal: true,
                                              gapMultiplier: 0.5),
                                          Expanded(
                                            child: TextField(
                                              decoration: const InputDecoration(
                                                  label: Text('To')),
                                              onTap: () {
                                                showDatePicker(
                                                    context: context,
                                                    firstDate: DateTime.now(),
                                                    lastDate:
                                                        DateTime(2035, 1, 1));
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  widgets: [
                                    ElevatedButton(
                                      onPressed: () {
                                        // BOOK NOW
                                      },
                                      child: const Text('Book Now'),
                                    )
                                  ]);
                            },
                            child: const Text('Book'),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
