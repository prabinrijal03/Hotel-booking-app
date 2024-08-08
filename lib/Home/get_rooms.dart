import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class GetRooms extends StatefulWidget {
  String hotelId;
  String name;
  String description;
  String photos;
  int price;
  int maxPeople;
  int roomNumbers;
  String roomId;
  String id;

  GetRooms(
      {super.key,
      required this.hotelId,
      required this.name,
      required this.description,
      required this.photos,
      required this.price,
      required this.maxPeople,
      required this.roomNumbers,
      required this.roomId,
      required this.id});

  @override
  State<GetRooms> createState() => _GetRoomsState();
}

class _GetRoomsState extends State<GetRooms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 320,
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
            border: Border.all(
              style: BorderStyle.solid,
              color: widget.roomId == widget.id ? Colors.red : Colors.black,
            ),
            borderRadius: BorderRadius.circular(12)),
        child: Column(children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            child: Image.network(
              widget.photos,
              height: 125,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              children: [
                Row(children: [
                  const Text(
                    "Type:  ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ]),
                Row(children: [
                  const Text(
                    "Description:  ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.description,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ]),
                Row(children: [
                  const Text(
                    "Price:  ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.price.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ]),
                Row(children: [
                  const Text(
                    "max People:  ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.maxPeople.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ]),
                Row(children: [
                  const Text(
                    "Room Numbers:  ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.roomNumbers.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
