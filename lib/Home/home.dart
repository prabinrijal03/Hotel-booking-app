import 'package:flutter/material.dart';

import 'package:hotel_booking_app/Home/hotels_list.dart';
import 'package:hotel_booking_app/Home/search_page.dart';
import 'package:hotel_booking_app/Providers/user_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, value, child) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            Stack(
              children: [
                Container(
                  height: 140,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 43),
                    child: SizedBox(
                      child: Text(
                        'SastoHotel',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                /*  Positioned(
                    top: 16,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(
                        Icons.refresh,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        value.getHotels();
                      },
                    )), */
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 112, 18, 0),
                  child: Container(
                    height: 49,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 7,
                          offset: const Offset(0, 0.5),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchPage()));
                      },
                      child: TextFormField(
                        enabled: false,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none),
                          contentPadding: const EdgeInsets.all(12),
                          prefixIcon: const Icon(Icons.search_outlined),
                          prefixIconColor:
                              const Color.fromARGB(255, 142, 130, 130),
                          hintText: 'Search for Hotel, City or Location',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            /*  Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircularAvatar(icon: Icons.near_me, text: "Nearby"),
                  CircularAvatar(image: 'assets/images/a.jpg', text: "Itahari"),
                  CircularAvatar(
                      image: 'assets/images/aa.jpg', text: "Biratnagar"),
                  CircularAvatar(icon: Icons.location_pin, text: "All cities"),
                ],
              ),
            ), */

            HotelsList(),
          ]),
        ),
      );
    });
  }
}
