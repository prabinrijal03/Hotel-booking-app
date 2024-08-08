class HotelModel {
  late String name;
  late String id;
  late String? type;
  late String? city;
  late String? address;
  late String description;
  late int? cheapestPrice;
  late List photos;

  HotelModel({
    required this.id,
    required this.name,
    this.type,
    this.city,
    this.address,
    required this.cheapestPrice,
    required this.photos,
    required this.description,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      id: json["_id"],
      name: json["name"],
      type: json["type"],
      city: json["city"],
      photos: json["photos"],
      address: json["address"],
      cheapestPrice: json["cheapestPrice"],
      description: json["description"],
    );
  }
}
