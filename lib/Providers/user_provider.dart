// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotel_booking_app/Model/book_model.dart';
import 'package:hotel_booking_app/Model/hotel_models.dart';
import 'package:hotel_booking_app/Model/room_model.dart';
import 'package:hotel_booking_app/Model/search_model.dart';
import 'package:hotel_booking_app/config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class UserProvider extends ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool isLoading = false;
  final _dio = Dio();


  Future registerUser(String fullname, String email, String password) async {
    isLoading = true;

    var regBody = jsonEncode(
        {"fullname": fullname, "email": email, "password": password});

    var response = await http.post(Uri.parse(register),
        headers: {"Content-Type": "application/json"}, body: regBody);

    var result = jsonDecode(response.body);

    isLoading = false;

    return result;
  }

  Future signIn(String email, String password) async {
    final SharedPreferences prefs = await _prefs;

    String id = '';
    String message = '';
    bool success = false;
    isLoading = true;

    var reggBody = jsonEncode({"email": email, "password": password});

    var response = await http.post(Uri.parse(login),
        headers: {"Content-Type": "application/json"}, body: reggBody);

    var result = jsonDecode(response.body);

    if (result['success'] == true) {
      isLoading = false;

      success = true;

      await prefs.setString('id', result['_id']);
      await prefs.setString('fullname', result['fullname']);
      await prefs.setString('email', result['email']);
      return result;
    } else {
      isLoading = false;

      message = result['message'];
      success = false;
      return result;
    }
  }

  //get hotels
  Future<List<HotelModel>> getHotels() async {
    final SharedPreferences prefs = await _prefs;
    String? userid = prefs.getString('id');

    final response = await http.get(Uri.parse(getAllHotels), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      return jsonResponse
          .map((data) => HotelModel.fromJson(data))
          .toList()
          .reversed
          .toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
  //get hotels

  Future<Map<String, dynamic>> createHotels(
    String name,
    String address,
    int phoneNumber,
    List imageList,
    String rooms,
    int cheapestPrice,
    String description,
  ) async {
    final SharedPreferences prefs = await _prefs;
    String? userid = prefs.getString('id');
    FormData formData;

    List<dynamic>? documents = [];
    for (int i = 0; i < imageList.length; i++) {
      String? fileName = imageList[i]?.path.split('/').last;
      String? last = imageList[i]?.path.split('.').last;

      documents.add(await MultipartFile.fromFile(imageList[i]?.path ?? '',
          filename: fileName, contentType: MediaType("image", last!)));
    }
    final FormData formdata = FormData.fromMap({
      "name": name,
      "address": address,
      "phoneNumber": phoneNumber,
      "photos": documents,
      "rooms": rooms,
      "cheapestPrice": cheapestPrice,
      "description": description,
    });
    final response = await _dio.post("$createHotel/${userid!}", data: formdata);

    if (response.statusCode == 200) {
      var result = response.data;
      getHotels();
      return result;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<Map<String, dynamic>> bookRooms(
    String hotel,
    hotelid,
    String fromdate,
    String todate,
    int totalamount,
    String roomid,
    int totaldays,
  ) async {
    final SharedPreferences prefs = await _prefs;
    String? userid = prefs.getString('id');
    var regBody = jsonEncode({
      "hotelid": hotelid,
    });

    FormData formData;

    var reggBody = jsonEncode({
      "hotel": hotel,
      "hotelid": hotelid,
      "roomid": roomid,
      "fromdate": fromdate,
      "todate": todate,
      "totalamount": totalamount,
      "totaldays": totaldays,
    });

    var response = await http.post(Uri.parse("$roomBook/${userid!}"),
        headers: {"Content-Type": "application/json"}, body: reggBody);

    var result = jsonDecode(response.body);

    if (result['success'] == true) {
      getBook();
      return result;
    } else {
      getBook();
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<BookModel>> getBook() async {
    final SharedPreferences prefs = await _prefs;
    String? userid = prefs.getString('id');
    var reggBody = jsonEncode({"userid": userid});

    final response = await http.post(Uri.parse(getBooked),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: reggBody);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      notifyListeners();
      return jsonResponse
          .map((data) => BookModel.fromJson(data))
          .toList()
          .reversed
          .toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future cancelBook({hotelid, bookingid}) async {
    final SharedPreferences prefs = await _prefs;
    String? userid = prefs.getString('id');
    var reggBody = jsonEncode({
      "hotelid": hotelid,
      "bookingid": bookingid,
    });

    final response = await http.post(Uri.parse(cancel),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: reggBody);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      getBook();

      return jsonResponse;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<SearchModel>> searchHotel(
    address,
  ) async {
    var reggBody = jsonEncode({
      "address": address,
    });

    final SharedPreferences prefs = await _prefs;
    String? userid = prefs.getString('id');

    var response = await http.post(Uri.parse(search),
        headers: {"Content-Type": "application/json"}, body: reggBody);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      return jsonResponse.map((data) => SearchModel.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<Map<String, dynamic>> createRooms(
      String roomType,
      int price,
      int maxPeople,
      String description,
      int roomNumbers,
      List imageList,
      String hotelId) async {
    FormData formData;

    List<dynamic>? documents = [];
    for (int i = 0; i < imageList.length; i++) {
      String? fileName = imageList[i]?.path.split('/').last;
      String? last = imageList[i]?.path.split('.').last;

      documents.add(await MultipartFile.fromFile(imageList[i]?.path ?? '',
          filename: fileName, contentType: MediaType("image", last!)));
    }
    final FormData formdata = FormData.fromMap({
      "name": roomType,
      "price": price,
      "roomNumbers": roomNumbers,
      "maxPeople": maxPeople,
      "photos": documents,
      "description": description,
    });
    final response = await _dio.post("$room/$hotelId", data: formdata);

    if (response.statusCode == 200) {
      var result = response.data;
      getHotels();
      return result;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<RoomModel>> getRooms(hotelid) async {
    final SharedPreferences prefs = await _prefs;
    String? userid = prefs.getString('id');
    var reggBody = jsonEncode({
      "hotelid": hotelid,
    });

    final response = await http.get(Uri.parse("$rooms/$hotelid"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    print(response.body);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)["data"];

      return jsonResponse.map((data) => RoomModel.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<HotelModel>> getHotelsById() async {
    final SharedPreferences prefs = await _prefs;
    String? userid = prefs.getString('id');

    final response =
        await http.get(Uri.parse("$adminHotel/${userid!}"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      print("aaa");
      List jsonResponse = json.decode(response.body)["data"];
      print(jsonResponse);

      return jsonResponse
          .map((data) => HotelModel.fromJson(data))
          .toList()
          .reversed
          .toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}
