import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hotel_booking_app/Home/get_rooms.dart';
import 'package:hotel_booking_app/Home/hotel_carousel.dart';
import 'package:hotel_booking_app/Model/room_model.dart';
import 'package:hotel_booking_app/Providers/user_provider.dart';
import 'package:provider/provider.dart';

class HotelDetails extends StatefulWidget {
  final String name;
  final String location;
  final String price;
  final String hotelId;
  final List hotelImage;
  final String description;

  const HotelDetails({
    Key? key,
    required this.name,
    required this.location,
    required this.price,
    required this.hotelImage,
    required this.hotelId,
    required this.description,
  }) : super(key: key);

  @override
  State<HotelDetails> createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails> {
  late DateTime _checkInDate;
  late DateTime _checkOutDate;
  bool appInit = true;
  String roomid = "";

  @override
  void initState() {
    super.initState();
    _checkInDate = DateTime.now();
    _checkOutDate = DateTime.now().add(const Duration(days: 1));
  }

  Future<void> _selectCheckInDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _checkInDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        appInit = false;
        _checkInDate = picked;
        _checkOutDate = _checkInDate.add(const Duration(days: 1));
      });
    }
  }

  Future<void> _selectCheckOutDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _checkOutDate,
      firstDate: _checkInDate.add(const Duration(days: 1)),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        appInit = false;
        _checkOutDate = picked;
      });
    }
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 300,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: widget.hotelImage[0] == null
                            ? Container(
                                color: Colors.red,
                              )
                            : Carousel(widget.hotelImage),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.name,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Row(
                              children: [
                                const Text(
                                  "Rs ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                                Text(
                                  widget.price,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.location,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const Divider(),
                      const Text(
                        "Ameneties",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.description,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Check-in',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 1,
                                  offset: const Offset(0, 0.5))
                            ]),
                        child: InkWell(
                          onTap: () {
                            _selectCheckInDate(context);
                          },
                          child: TextFormField(
                            readOnly: true,
                            enabled: appInit == true ? false : true,
                            enableInteractiveSelection: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none),
                            ),
                            controller: TextEditingController(
                                text: appInit == true
                                    ? "Select Date"
                                    : "${_checkInDate.day}/${_checkInDate.month}/${_checkInDate.year}"),
                            onTap: () {
                              _selectCheckInDate(context);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Check-out',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () => _selectCheckOutDate(context),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    blurRadius: 1,
                                    offset: const Offset(0, 0.5))
                              ]),
                          child: TextFormField(
                            readOnly: true,
                            enabled: appInit == true ? false : true,
                            enableInteractiveSelection: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            controller: TextEditingController(
                                text: appInit == true
                                    ? "Select Date"
                                    : "${_checkOutDate.day}/${_checkOutDate.month}/${_checkOutDate.year}"),
                            onTap: () => _selectCheckOutDate(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Select Rooms",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 320,
                  child:
                      Consumer<UserProvider>(builder: (context, value, child) {
                    return FutureBuilder<List<RoomModel>>(
                        future: value.getRooms(widget.hotelId),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<RoomModel> data = snapshot.data!;
                            return data.isEmpty
                                ? const Text("No Rooms Available")
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: ListView.builder(
                                        itemCount: data.length,
                                        scrollDirection: Axis.horizontal,
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              child: InkWell(
                                                onTap: () {
                                                  if (roomid ==
                                                      data[index].id) {
                                                    setState(() {
                                                      roomid = "";
                                                    });
                                                  } else {
                                                    setState(() {
                                                      roomid = data[index].id;
                                                    });
                                                  }
                                                },
                                                child: Stack(
                                                  children: [
                                                    GetRooms(
                                                        hotelId: widget.hotelId,
                                                        name: data[index].name,
                                                        description: data[index]
                                                            .description,
                                                        photos: data[index]
                                                            .photos[0],
                                                        price:
                                                            data[index].price,
                                                        maxPeople: data[index]
                                                            .maxPeople,
                                                        roomNumbers: data[index]
                                                            .roomNumbers,
                                                        id: data[index].id,
                                                        roomId: roomid),
                                                    roomid != data[index].id
                                                        ? Positioned(
                                                            bottom: 10,
                                                            left: 30,
                                                            child: Container(
                                                              height: 30,
                                                              width: 150,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .black,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                              child:
                                                                  const Center(
                                                                child: Text(
                                                                  "Select",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : roomid ==
                                                                data[index].id
                                                            ? Positioned(
                                                                bottom: 10,
                                                                left: 30,
                                                                child:
                                                                    Container(
                                                                  height: 30,
                                                                  width: 150,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: const Color
                                                                              .fromARGB(
                                                                              255,
                                                                              222,
                                                                              220,
                                                                              220),
                                                                          borderRadius: BorderRadius.circular(
                                                                              8),
                                                                          border:
                                                                              Border.all(
                                                                            width:
                                                                                2,
                                                                            color:
                                                                                Colors.black,
                                                                          )),
                                                                  child:
                                                                      const Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        "Selected",
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            fontSize:
                                                                                18,
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                      Icon(
                                                                        Icons
                                                                            .done,
                                                                        color: Colors
                                                                            .green,
                                                                        size:
                                                                            26,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            : const SizedBox()
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        });
                  }),
                ),
                // Container(height: 350, child: GetRooms(hotelId: widget.hotelId)),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.red)),
                    onPressed: roomid == ""
                        ? () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Select Room First")));
                          }
                        : () {
                            setState(() {
                              isLoading = true;
                            });
                            UserProvider()
                                .bookRooms(
                              widget.name,
                              widget.hotelId,
                              "${_checkInDate.day}/${_checkInDate.month}/${_checkInDate.year}",
                              "${_checkOutDate.day}/${_checkOutDate.month}/${_checkOutDate.year}",
                              int.parse(widget.price),
                              roomid,
                              4,
                            )
                                .then((data) {
                              data["success"] == true
                                  ? {
                                      setState(() {
                                        isLoading = false;
                                      }),
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(data["message"]))),
                                      data["message"] == "Hotel booked"
                                          ? Navigator.pop(context)
                                          : () {}
                                    }
                                  : {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(data["message"]))),
                                      setState(() {
                                        isLoading = true;
                                      })
                                    };
                            });
                          },
                    child: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : const Text(
                            'Book now',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Positioned(
              top: 30,
              left: 4,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Center(
                    child: Icon(
                      Icons.cancel,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
