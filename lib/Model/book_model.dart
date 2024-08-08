class BookModel {
  late String hotel;
  late String bookingid;
  late String status;
  late String hotelid;
  late String roomid;

  late String fromdate;
  late String todate;
  late int totalamount;
  late int totaldays;
  late List photos;

  BookModel({
    required this.hotel,
    required this.bookingid,
    required this.status,
    required this.hotelid,
    required this.roomid,
    required this.fromdate,
    required this.todate,
    required this.totalamount,
    required this.totaldays,
    required this.photos,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      hotel: json["hotel"],
      bookingid: json["_id"],
      status: json["status"],
      hotelid: json["hotelid"],
      roomid: json["roomid"],
      fromdate: json["fromdate"],
      todate: json["todate"],
      totalamount: json["totalamount"],
      totaldays: json["totaldays"],
      photos: json["photos"],
    );
  }
}
