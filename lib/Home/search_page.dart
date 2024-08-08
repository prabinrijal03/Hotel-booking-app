import 'package:flutter/material.dart';
import 'package:hotel_booking_app/Home/hotel_details.dart';
import 'package:hotel_booking_app/Model/search_model.dart';
import 'package:hotel_booking_app/Providers/user_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                Positioned(
                    top: 45,
                    left: 10,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    )),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 43),
                    child: SizedBox(
                      child: Text(
                        'Search Hotel',
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
                    child: TextFormField(
                      controller: _searchcontroller,
                      onChanged: (value) {
                        _searchcontroller = _searchcontroller;
                        Future.delayed(const Duration(seconds: 1), () {
                          UserProvider()
                              .searchHotel(_searchcontroller.text)
                              .then((value) {
                            setState(() {});
                          });
                        });
                      },
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none),
                          contentPadding: const EdgeInsets.all(12),
                          prefixIconColor:
                              const Color.fromARGB(255, 142, 130, 130),
                          hintText: 'Search for City or Location',
                          suffixIcon: InkWell(
                              onTap: () {}, child: const Icon(Icons.search))),
                    ),
                  ),
                ),
              ],
            ),
            FutureBuilder<List<SearchModel>>(
              future: UserProvider()
                  .searchHotel(_searchcontroller.text.toLowerCase()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<SearchModel> data = snapshot.data!;
                  return data.isEmpty
                      ? const Text("No hotels found in this location")
                      : SizedBox(
                          height: 535,
                          child: Column(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: GridView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 20,
                                          ),
                                          itemCount: data.length,
                                          shrinkWrap: true,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            HotelDetails(
                                                          name:
                                                              data[index].name,
                                                          location: data[index]
                                                              .address!,
                                                          price: data[index]
                                                              .cheapestPrice
                                                              .toString(),
                                                          hotelImage:
                                                              data[index]
                                                                  .photos,
                                                          hotelId:
                                                              data[index].id,
                                                          description:
                                                              data[index]
                                                                  .description,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 1,
                                                          color: Colors.black
                                                              .withOpacity(0.5),
                                                          offset: const Offset(
                                                              0, 0.5),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 100,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: ClipRRect(
                                                            borderRadius: const BorderRadius
                                                                .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        7),
                                                                topRight: Radius
                                                                    .circular(
                                                                        7)),
                                                            child: data[index]
                                                                    .photos
                                                                    .isEmpty
                                                                ? Container(
                                                                    color: Colors
                                                                        .red,
                                                                  )
                                                                : Image.network(
                                                                    data[index]
                                                                        .photos[0],
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 12,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 8.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                data[index]
                                                                    .name,
                                                                style: const TextStyle(
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                data[index]
                                                                    .address!,
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                "Rs ${data[index].cheapestPrice}",
                                                                style:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ));
                                          })),
                                ),
                              ),
                            ],
                          ),
                        );
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.red,
                  ));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
