import 'package:flutter/material.dart';
import 'package:hotel_booking_app/Model/book_model.dart';
import 'package:hotel_booking_app/Providers/user_provider.dart';
import 'package:provider/provider.dart';

class Saved extends StatelessWidget {
  const Saved({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Center(
          child: Text(
            "My Bookings",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      body: Consumer<UserProvider>(builder: (context, value, child) {
        return FutureBuilder<List<BookModel>>(
          future: value.getBook(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<BookModel> data = snapshot.data!;
              return data.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10, top: 30),
                      child: Text(
                        "You have not booked any hotels, Please book and get our service",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return data[index].status == "cancelled"
                                      ? const SizedBox()
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 0.0),
                                          child: Container(
                                            height: 230,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    child: Image.network(
                                                      data[index].photos[0],
                                                      height: 160,
                                                      width: 140,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20, top: 25.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        data[index].hotel,
                                                        style: const TextStyle(
                                                            fontSize: 26,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          const Text(
                                                            "Check-In: ",
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Text(
                                                            data[index]
                                                                .fromdate,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        18),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          const Text(
                                                            "Check-Out: ",
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Text(
                                                            data[index].todate,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        18),
                                                          ),
                                                        ],
                                                      ),
                                                      const Row(
                                                        children: [
                                                          Text(
                                                            "Status: ",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                            "Booked",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      ElevatedButton(
                                                        style: const ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStatePropertyAll(
                                                                    Colors
                                                                        .red)),
                                                        onPressed: () {
                                                          showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                title: const Text(
                                                                    'Cancel Booking'),
                                                                content: const Text(
                                                                    'Are you sure you want to cancel booking?'),
                                                                actions: [
                                                                  ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      "No",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  ),
                                                                  ElevatedButton(
                                                                      onPressed:
                                                                          () async {
                                                                        value
                                                                            .cancelBook(
                                                                          hotelid:
                                                                              data[index].hotelid,
                                                                          bookingid:
                                                                              data[index].bookingid,
                                                                        )
                                                                            .then((value) {
                                                                          Navigator.pop(
                                                                              context);
                                                                          value["success"] == true
                                                                              ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value["message"])))
                                                                              : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong")));
                                                                        });
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        "Yes",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.red),
                                                                      )),
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        },
                                                        child: const Text(
                                                          "Cancel Booking",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                }),
                          ),
                        ),
                      ],
                    );
            } else {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.red,
              ));
            }
          },
        );
      }),
    );
  }
}
