import 'package:flutter/material.dart';
import 'package:hotel_booking_app/Providers/user_provider.dart';

import 'package:hotel_booking_app/splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splash(),
      ),
    ),
  );
}
