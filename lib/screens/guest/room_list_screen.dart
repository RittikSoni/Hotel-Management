import 'package:flutter/material.dart';
import 'package:hotel_management/utils/common_functions.dart';
import 'package:hotel_management/utils/kloading.dart';
import 'package:provider/provider.dart';
import '../../providers/room_provider.dart';

class RoomListScreen extends StatefulWidget {
  const RoomListScreen({super.key});

  @override
  RoomListScreenState createState() => RoomListScreenState();
}

class RoomListScreenState extends State<RoomListScreen> {
  bool? isAvailable;
  String? selectedRoomType;
  double? maxPrice;

  final List<String> roomTypes = ['Deluxe', 'Standard', 'Suite'];

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context);
    if (roomProvider.rooms == null) {
      roomProvider.fetchRooms();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rooms'),
        actions: [
          isAvailable != null || selectedRoomType != null || maxPrice != null
              ? ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isAvailable = null;
                      selectedRoomType = null;
                      maxPrice = null;
                    });
                    KLoadingToast.startLoading();
                    await roomProvider.fetchRooms();
                    KLoadingToast.stopLoading();
                  },
                  child: const Text('Clear Filters'),
                )
              : Container(),
        ],
      ),
      body: Column(
        children: [
          // Filter Widgets
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Availability Filter
                DropdownButton<bool>(
                  value: isAvailable,
                  hint: const Text('Availability'),
                  items: const [
                    DropdownMenuItem(value: true, child: Text('Available')),
                    DropdownMenuItem(value: false, child: Text('Booked')),
                  ],
                  onChanged: (value) async {
                    KLoadingToast.startLoading();

                    setState(() {
                      isAvailable = value;
                    });
                    await roomProvider.fetchRooms(
                        isAvailable: isAvailable,
                        roomType: selectedRoomType,
                        maxPrice: maxPrice);
                    KLoadingToast.stopLoading();
                  },
                ),
                // Room Type Filter
                DropdownButton<String>(
                  value: selectedRoomType,
                  hint: const Text('Room Type'),
                  items: roomTypes.map((type) {
                    return DropdownMenuItem(value: type, child: Text(type));
                  }).toList(),
                  onChanged: (value) async {
                    KLoadingToast.startLoading();
                    setState(() {
                      selectedRoomType = value;
                    });
                    await roomProvider.fetchRooms(
                        isAvailable: isAvailable,
                        roomType: selectedRoomType,
                        maxPrice: maxPrice);
                    KLoadingToast.stopLoading();
                  },
                ),
                // Price Filter
                Row(
                  children: [
                    Text('Max Price: ${maxPrice?.toStringAsFixed(0) ?? 'Any'}'),
                    Slider(
                      value: maxPrice ?? 1000,
                      min: 0,
                      max: 5000,
                      divisions: 50,
                      onChanged: (value) {
                        setState(() {
                          maxPrice = value;
                        });
                      },
                      onChangeEnd: (value) async {
                        KLoadingToast.startLoading();
                        await roomProvider.fetchRooms(
                            isAvailable: isAvailable,
                            roomType: selectedRoomType,
                            maxPrice: maxPrice);
                        KLoadingToast.stopLoading();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Room List
          Expanded(
            child: roomProvider.rooms == null
                ? const Center(child: CircularProgressIndicator())
                : roomProvider.rooms!.isEmpty
                    ? const Center(child: Text('No rooms available'))
                    : GridView.builder(
                        itemCount: roomProvider.rooms?.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          final room = roomProvider.rooms![index];
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                      child: Image.asset(
                                          'assets/images/${room.type.toLowerCase()}.png',
                                          height: 100.0)),
                                  ListTile(
                                    title:
                                        Text('${room.type} - \$${room.price}'),
                                    subtitle: Text(
                                        'Amenities: ${room.amenities.join(', ')}'),
                                    trailing: room.isBooked
                                        ? const Icon(Icons.check,
                                            color: Colors.green)
                                        : ElevatedButton(
                                            onPressed: () {
                                              KLoadingToast
                                                  .showDialogMultipleButtons(
                                                      title: 'Book Room',
                                                      content: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(room.type),
                                                              Text(room.price
                                                                  .toString()),
                                                            ],
                                                          ),
                                                          Text(room.amenities
                                                              .join(', ')),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    TextField(
                                                                  decoration:
                                                                      const InputDecoration(
                                                                          label:
                                                                              Text('From')),
                                                                  onTap: () {
                                                                    showDatePicker(
                                                                        context:
                                                                            context,
                                                                        firstDate:
                                                                            DateTime
                                                                                .now(),
                                                                        lastDate: DateTime(
                                                                            2035,
                                                                            1,
                                                                            1));
                                                                  },
                                                                ),
                                                              ),
                                                              Commonfunctions
                                                                  .gapMultiplier(
                                                                      isHorizontal:
                                                                          true,
                                                                      gapMultiplier:
                                                                          0.5),
                                                              Expanded(
                                                                child:
                                                                    TextField(
                                                                  decoration:
                                                                      const InputDecoration(
                                                                          label:
                                                                              Text('To')),
                                                                  onTap: () {
                                                                    showDatePicker(
                                                                        context:
                                                                            context,
                                                                        firstDate:
                                                                            DateTime
                                                                                .now(),
                                                                        lastDate: DateTime(
                                                                            2035,
                                                                            1,
                                                                            1));
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      widgets: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        // BOOK NOW
                                                      },
                                                      child: const Text(
                                                          'Book Now'),
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
          ),
        ],
      ),
    );
  }
}
