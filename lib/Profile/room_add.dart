import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hotel_booking_app/Providers/user_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class RoomAdd extends StatefulWidget {
  String hotelid;
  String hotelName;

  RoomAdd({
    super.key,
    required this.hotelid,
    required this.hotelName,
  });

  @override
  State<RoomAdd> createState() => _RoomAddState();
}

class _RoomAddState extends State<RoomAdd> {
  final TextEditingController _roomTypeController = TextEditingController();

  final TextEditingController _priceController = TextEditingController();

  final TextEditingController _maxPeopleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _roomNumbersController = TextEditingController();

  List imageList = [];
  List resultList = [];
  bool isloading = false;

  Future<void> _selectPhotos() async {
    try {
      resultList = await ImagePicker().pickMultiImage(imageQuality: 40);
      // XFile file = XFile(resultList.path);
      for (int i = 0; i < resultList.length; i++) {
        setState(() {
          imageList.add(resultList[i]);
        });
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, value, child) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 50),
                child: Column(
                  children: [
                    const Text(
                      "Fill-up your room details",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Text(
                      widget.hotelName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: _roomTypeController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        labelText: "Room type",
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _priceController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        labelText: "Price",
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _maxPeopleController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        labelText: "Maximum People",
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        labelText: "Description",
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _roomNumbersController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        labelText: "Room Numbers",
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: _selectPhotos,
                      child: const Text('Select Photos'),
                    ),
                    const SizedBox(height: 20),
                    imageList.isEmpty
                        ? const SizedBox()
                        : SizedBox(
                            height: 100,
                            child: ListView.builder(
                                itemCount: imageList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 100,
                                      width: 150,
                                      child: Image.file(
                                        File(imageList[index].path),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                }),
                          ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.red)),
                      onPressed: () {
                        setState(() {
                          isloading = true;
                        });
                        value
                            .createRooms(
                                _roomTypeController.text,
                                int.parse(_priceController.text),
                                int.parse(_maxPeopleController.text),
                                _descriptionController.text,
                                int.parse(_roomNumbersController.text),
                                imageList,
                                widget.hotelid)
                            .then((data) {
                          setState(() {
                            isloading = false;
                          });
                          data["success"] == true
                              ? {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(data["message"]))),
                                  data["message"] ==
                                          "All rooms price is greater than hotel's cheapest price"
                                      ? () {}
                                      : Navigator.pop(context)
                                }
                              : ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(data["message"])));
                        });
                      },
                      child: isloading == true
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              "Submit",
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
              Positioned(
                  top: 40,
                  left: 5,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ))
            ],
          ),
        ),
      );
    });
  }
}
