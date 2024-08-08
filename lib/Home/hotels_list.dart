import 'package:flutter/material.dart';
import 'package:hotel_booking_app/Home/hotel_details.dart';
import 'package:hotel_booking_app/Model/hotel_models.dart';
import 'package:hotel_booking_app/Providers/user_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HotelsList extends StatelessWidget {
  String? searchtext;
  HotelsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, value, child) {
      return FutureBuilder<List<HotelModel>>(
          future: value.getHotels(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<HotelModel> data = snapshot.data!;
              return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: data.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true)
                                .push(MaterialPageRoute(
                                    builder: (context) => HotelDetails(
                                          name: data[index].name,
                                          location: data[index].address!,
                                          price: data[index]
                                              .cheapestPrice
                                              .toString(),
                                          hotelImage: data[index].photos,
                                          hotelId: data[index].id,
                                          description: data[index].description,
                                        )));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 1,
                                  color: Colors.black.withOpacity(0.5),
                                  offset: const Offset(0, 0.5),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(7),
                                        topRight: Radius.circular(7)),
                                    child: data[index].photos.isEmpty
                                        ? Container(
                                            color: Colors.red,
                                          )
                                        : Image.network(
                                            data[index].photos[0],
                                            fit: BoxFit.fill,
                                          ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data[index].name,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        data[index].address!,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Rs ${data[index].cheapestPrice}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ));
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          });
    });
  }
}
