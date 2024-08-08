class RoomModel {
  late String id;
  late String name;
  late int price;
  late int maxPeople;
  late String description;
  late int roomNumbers;
  late List photos;

  RoomModel({
    required this.id,
    required this.photos,
    required this.name,
    required this.price,
    required this.maxPeople,
    required this.description,
    required this.roomNumbers,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json["_id"],
      photos: json["photos"],
      name: json["name"],
      price: json["price"],
      maxPeople: json["maxPeople"],
      description: json["description"],
      roomNumbers: json["roomNumbers"],
    );
  }
}
