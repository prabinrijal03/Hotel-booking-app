import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hotel_booking_app/login/signin.dart';
import 'package:hotel_booking_app/widgets/bottom_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late SharedPreferences prefs;
  String? id;
  void checkId() async {
    prefs = await _prefs;
    id = prefs.getString("id");
  }

  @override
  void initState() {
    super.initState();
    checkId();
    Timer(
        const Duration(seconds: 3),
        () => id == null
            ? Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => const MyApp()))
            : Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) => Dash())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Image.asset(
            "assets/images/p.png",
            width: MediaQuery.of(context).size.width - 200,
          ),
        ),
      ),
    );
  }
}
