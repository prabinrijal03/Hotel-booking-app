import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel_booking_app/Providers/user_provider.dart';
import 'package:hotel_booking_app/widgets/bottom_nav.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  Future<void> _handleSignIn(BuildContext context) async {
    final SharedPreferences prefs = await _prefs;

    try {
      await _googleSignIn.signIn().then((value) async {
        // ignore: unnecessary_null_comparison
        value!.email == null
            ? () {}
            : {
                UserProvider()
                    .registerUser(
                        _googleSignIn.currentUser!.displayName.toString(),
                        _googleSignIn.currentUser!.email,
                        "12345678")
                    .then(
                  (value) {
                    value["success"] == false
                        ? UserProvider()
                            .signIn(
                                _googleSignIn.currentUser!.email, "12345678")
                            .then((value) async {
                            await prefs.setString('id', value['_id']);
                            await prefs.setString(
                                'fullname', value['fullname']);
                            await prefs
                                .setString('email', value['email'])
                                .then((value) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Dash()));
                            });
                          })
                        : null;
                  },
                ),
              };
      });
    } catch (error) {
      print('Error signing in: $error');
    }
  }

  late SharedPreferences prefs;
  shared() async {
    prefs = await _prefs;
  }

  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  bool _islogin = true;
  bool _isNotValidate = false;

  @override
  void initState() {
    shared();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, value, child) {
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark
            .copyWith(statusBarColor: Colors.transparent),
        child: PopScope(
          canPop: false,
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: ListView(
                children: [
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GradientText(
                          'Welcome',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 34,
                          ),
                          colors: const [
                            Color.fromARGB(255, 197, 33, 4),
                            Color.fromARGB(255, 205, 25, 5),
                          ],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                          'assets/images/aaaa.png',
                          height: 42,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: SizedBox(
                      height: 120,
                      child: Image.asset('assets/images/p.png'),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Text(
                            'Hello! Amazing deals are just a sign-up away.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextFormField(
                              controller: _islogin
                                  ? emailController
                                  : usernameController,
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                errorText:
                                    _isNotValidate ? "Enter username" : null,
                                border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                labelText: _islogin
                                    ? 'Enter your E-mail'
                                    : 'Enter username',
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          _islogin
                              ? const SizedBox()
                              : Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: TextFormField(
                                    controller: emailController,
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      errorText: _isNotValidate
                                          ? "Enter your Email"
                                          : null,
                                      prefixStyle:
                                          const TextStyle(fontSize: 16),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black, width: 2),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      labelText: 'Enter your email',
                                      labelStyle:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: _islogin ? 0 : 30,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextFormField(
                              controller: passwordController,
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              decoration: InputDecoration(
                                errorText: _isNotValidate
                                    ? "Enter your Password"
                                    : null,
                                prefixStyle: const TextStyle(fontSize: 16),
                                border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                labelText: 'Enter password',
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 8),
                                  textStyle: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                              onPressed: _islogin
                                  ? () {
                                      value
                                          .signIn(emailController.text,
                                              passwordController.text)
                                          .then((data) {
                                        data["success"] == true
                                            ? Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => Dash(),
                                                ),
                                              )
                                            : ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                content: Text(data["message"]),
                                              ));
                                      });
                                    }
                                  : () {
                                      value
                                          .registerUser(
                                              usernameController.text,
                                              emailController.text,
                                              passwordController.text)
                                          .then((data) {
                                        data["success"] == true
                                            ? setState(() {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content:
                                                      Text(data["message"]),
                                                ));
                                                _islogin = true;
                                                passwordController.clear();
                                                emailController.clear();
                                                usernameController.clear();
                                              })
                                            : ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                content: Text(data["message"]),
                                              ));
                                      });
                                    },
                              child: value.isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      _islogin ? "Login" : "Register",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )),
                          const SizedBox(
                            height: 10,
                          ),
                          TextButton(
                              onPressed: () {
                                _islogin == true
                                    ? setState(() {
                                        _islogin = false;
                                      })
                                    : setState(() {
                                        _islogin = true;
                                      });
                              },
                              child: Text(
                                _islogin
                                    ? "Create an account"
                                    : "Already have an account?",
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.blue,
                                ),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          /*  AnimatedButton(
                          image: "assets/images/facebook.png",
                          text: "Continue with Facebook",
                          color: Colors.white,
                          ontap: () {},
                        ), */

                          /*  AnimatedButton(
                          image: "assets/images/google.png",
                          text: "Continue with Google",
                          color: Colors.white,
                          ontap: (){},
                        ), */
                          /*  InkWell(
                            onTap: () {},
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.black,
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/facebook.png',
                                      height: 35,
                                      width: 35,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const Text(
                                      'Continue with Facebook',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ), */
                          InkWell(
                            onTap: () => _handleSignIn(context),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.black,
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/google.png',
                                      height: 35,
                                      width: 35,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const Text(
                                      'Continue with Google',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
