import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hotel_booking_app/Providers/user_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProperty extends StatefulWidget {
  const AddProperty({super.key});

  @override
  State<AddProperty> createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  final TextEditingController _hotelNameController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _roomsController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _cheapestPriceController =
      TextEditingController();

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
                      "Fill-up your hotel details",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    TextFormField(
                      controller: _hotelNameController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        labelText: "Hotel name",
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
                      controller: _addressController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        labelText: "Address",
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
                      keyboardType: TextInputType.phone,
                      controller: _phoneNumberController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        labelText: "Phone number",
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
                      controller: _roomsController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        labelText: "Rooms",
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
                      controller: _cheapestPriceController,
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
                      height: 20,
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
                            .createHotels(
                          _hotelNameController.text,
                          _addressController.text,
                          int.parse(_phoneNumberController.text),
                          imageList,
                          _roomsController.text,
                          int.parse(_cheapestPriceController.text),
                          _descriptionController.text,
                        )
                            .then((data) {
                          setState(() {
                            isloading = false;
                          });
                          data["success"] == true
                              ? {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(data["message"]))),
                                  Navigator.pop(context)
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
