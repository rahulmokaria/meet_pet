import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meet_pet/screens/login_signup/forgot_password.dart';
import 'package:meet_pet/widgets/show_snackbar.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../resources/auth_methods.dart';
import '../../utils/colors.dart';
import '../../widgets/text_field_ui.dart';
import '../home_page.dart';
import 'sign_up_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  bool _isLoading = false;
  late Position _userLocation;

  @override
  dispose() {
    super.dispose();
    _passwordTextController.dispose();
    _emailTextController.dispose();
  }

  void loginUser() async {
    print("loginng ");
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
      email: _emailTextController.text,
      password: _passwordTextController.text,
    );

    if (res == 'success' || res == 'Success') {
      gotoHome();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          showCustomSnackBar(ctype: ContentType.failure, message: res));
    }
    setState(() {
      _isLoading = false;
    });
  }

  loginUserWithGoogleAuth() async {
    print("loginng ");
    // setState(() {
    //   _isLoading = true;
    // });
    String res = await AuthMethods().loginWithGoogle();
    if (res == 'success') {
      gotoHome();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          showCustomSnackBar(message: res, ctype: ContentType.failure));
    }
    // setState(() {
    //   _isLoading = false;
    // });
  }

  // updateLocation() async {
  //   print("i am trying");
  //   Position location = await Geolocator.getCurrentPosition();

  //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //   var userSnap = await FirebaseFirestore.instance
  //       .collection('locationcheck')
  //       .doc('demo')
  //       .get();

  //   var location1 = userSnap['location'];

  //   double distance = await Geolocator.distanceBetween(location.latitude,
  //       location.longitude, location1.latitude, location1.longitude);

  //   ScaffoldMessenger.of(context).showSnackBar(showCustomSnackBar(
  //       "Oh Snap!",
  //       ((distance / 1000).round()).toString() + "km",
  //       pink,
  //       CupertinoIcons.exclamationmark_circle));
  //   // late GeoPoint ll =
  //   print(location.toString());
  // }

  void gotoHome() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width / 100;
    var _height = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      backgroundColor: secondary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: _width * 30),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(
                left: _width * 10,
              ),
              child: Text(
                "Login",
                textScaleFactor: 3,
                style: TextStyle(
                  color: primary,
                ),
              ),
            ),
            SizedBox(
              height: _width * 14,
            ),
            Container(
              padding: EdgeInsets.only(
                right: _width * 10,
                left: _width * 10,
              ),
              child: Column(
                children: [
                  textFieldUi('Email', Icons.person, false,
                      _emailTextController, TextInputType.emailAddress),
                  const SizedBox(
                    height: 20,
                  ),
                  textFieldUi('Password', Icons.lock_outline, true,
                      _passwordTextController, TextInputType.visiblePassword),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const ForgotPasswordPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                            color: primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: _width * 14,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(90)),
                    child: ElevatedButton(
                      onPressed: () => loginUser(),
                      // onPressed: () => updateLocation(),

                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return secondary;
                          }
                          return primary;
                        }),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(_width * 28))),
                      ),
                      child: _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: white,
                              ),
                            )
                          : const Text(
                              "Login",
                              style: TextStyle(
                                color: secondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 20.0),
                          child: Divider(
                            color: primary,
                            // height: 36,
                          ),
                        ),
                      ),
                      Text(
                        "OR",
                        style: TextStyle(
                          color: primary,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: Divider(
                            color: primary,
                            // height: 36
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: _width * 14,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(90)),
                    child: ElevatedButton(
                      onPressed: () {
                        loginUserWithGoogleAuth();
                        // loginUserDb(context, _emailTextController,
                        // _passwordTextController);
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return primary;
                          }
                          return secondaryLight;
                        }),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(_width * 8))),
                      ),
                      child: Stack(
                        children: [
                          Text(
                            "Login with Google",
                            style: TextStyle(
                              color: primary,
                              // fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 18,
                          color: black,
                        ),
                      ),
                      TextButton(
                        onPressed: openSignUp,
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 18,
                            color: primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: _width * 10),
          ],
        ),
      ),
    );
  }

  void openSignUp() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const SignUpPage()));
  }
}
