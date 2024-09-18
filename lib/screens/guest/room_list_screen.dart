import 'package:flutter/material.dart';
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
            child: ListTile(
              title: Text('${room.type} - \$${room.price}'),
              subtitle: Text('Amenities: ${room.amenities.join(', ')}'),
              trailing: room.isBooked
                  ? const Icon(Icons.check, color: Colors.green)
                  : ElevatedButton(
                      onPressed: () {
                        roomProvider.bookRoom(room);
                      },
                      child: const Text('Book'),
                    ),
            ),
          );
        },
      ),
    );
  }
}
