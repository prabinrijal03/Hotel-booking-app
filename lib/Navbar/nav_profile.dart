import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hotel_booking_app/Profile/hotel_list.dart';
import 'package:hotel_booking_app/Profile/profile_property.dart';
import 'package:hotel_booking_app/config.dart';
import 'package:hotel_booking_app/login/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late SharedPreferences prefs;
  String name = "";
  String email = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    shared();
  }

  shared() async {
    try {
      prefs = await _prefs;
      print('SharedPreferences loaded');
      setState(() {
        name = prefs.getString('fullname') ?? '';
        email = prefs.getString('email') ?? '';
        print('Name: $name, Email: $email');
        isLoading = false;
      });
    } catch (e) {
      print('Error loading SharedPreferences: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  delete(BuildContext context) async {
    String userid = prefs.getString('id')!;
    final response =
        await http.delete(Uri.parse("$deleteUser/$userid"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      await prefs.clear();
      Navigator.of(context, rootNavigator: true).pushReplacement(
        MaterialPageRoute(builder: (context) => const MyApp()),
      );
    } else {
      throw Exception('Unexpected error occurred!');
    }
  }

  showDialogue(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sign out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "No",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await prefs.clear();
                await _googleSignIn.signOut();
                Navigator.of(context, rootNavigator: true).pushReplacement(
                  MaterialPageRoute(builder: (context) => const MyApp()),
                );
              },
              child: const Text(
                "Yes",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  showDialogue1(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text('Are you sure you want to delete account?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "No",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                delete(context);
              },
              child: const Text(
                "Yes",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 300,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(18),
                            bottomRight: Radius.circular(18),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: Column(
                          children: [
                            Center(
                              child: Container(
                                height: 140,
                                width: 140,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://static-00.iconduck.com/assets.00/profile-circle-icon-2048x2048-cqe5466q.png"),
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              email,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                  builder: (context) => const AddProperty()),
                            );
                          },
                          trailing:
                              const Icon(Icons.arrow_forward_ios_outlined),
                          leading: const Icon(
                            Icons.hotel,
                            color: Colors.green,
                          ),
                          title: const Text(
                            'Add your hotels',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                  builder: (context) => const HotelList()),
                            );
                          },
                          trailing:
                              const Icon(Icons.arrow_forward_ios_outlined),
                          leading: const Icon(
                            Icons.bed,
                            color: Colors.blue,
                          ),
                          title: const Text(
                            'Add your rooms',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          onTap: () {},
                          trailing:
                              const Icon(Icons.arrow_forward_ios_outlined),
                          leading: const Icon(
                            Icons.reviews,
                            color: Colors.amber,
                          ),
                          title: const Text(
                            'Rate Our App',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          onTap: () {
                            showDialogue1(context);
                          },
                          trailing:
                              const Icon(Icons.arrow_forward_ios_outlined),
                          leading: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          title: const Text(
                            'Delete Account',
                            style: TextStyle(fontSize: 20, color: Colors.red),
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          onTap: () {
                            showDialogue(context);
                          },
                          trailing:
                              const Icon(Icons.arrow_forward_ios_outlined),
                          leading: const Icon(
                            Icons.power_settings_new,
                            color: Colors.red,
                          ),
                          title: const Text(
                            'Sign out',
                            style: TextStyle(fontSize: 20, color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
