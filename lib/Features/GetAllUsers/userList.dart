// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/Features/GetAllUsers/hotelModels.dart';
import 'package:http/http.dart' as http;

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList>
    with SingleTickerProviderStateMixin {
  bool _isloading = true;
  List<UserModel> users = [];

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('http://192.168.18.175:3000/api/users'));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      users = jsonData.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    fetchData().then((value) {
      setState(() {
        _isloading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: _isloading == true
                ? const CircularProgressIndicator()
                : ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          color: Colors.red,
                          height: 70,
                          width: 300,
                          child: Column(
                            children: [
                              Text(users[index].email),
                              Text(users[index].id),
                              Text(users[index].name),
                            ],
                          ),
                        ),
                      );
                    },
                  )));
  }
}
