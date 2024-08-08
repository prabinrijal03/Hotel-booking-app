class SearchModel {
  late String name;
  late String id;
  late String? type;
  late String? city;
  late String? address;
  late String description;
  late int? cheapestPrice;
  late List photos;

  SearchModel({
    required this.id,
    required this.name,
    this.type,
    this.city,
    this.address,
    required this.cheapestPrice,
    required this.photos,
    required this.description,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
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
