import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meet_pet/widgets/show_snackbar.dart';

import '../../utils/colors.dart';
// import '../widgets/show_error.dart';
import '../../widgets/text_field_ui.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailTextController = TextEditingController();
  var isAnyError = false;
  var msg =
      "A password recovery link is send to your email, if not visible check span folder";
  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width / 100;
    var _height = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      backgroundColor: secondary,
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(left: _width * 10, top: _width * 22),
            child: Text(
              "Forgot\nPassword",
              style: TextStyle(
                color: primary,
                fontSize: 60,
              ),
            ),
          ),
          SizedBox(
            height: _width * 21,
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                right: _width * 10,
                left: _width * 10,
              ),
              child: Column(
                children: [
                  textFieldUi('Email', Icons.person, false,
                      _emailTextController, TextInputType.emailAddress),
                  SizedBox(
                    height: _width * 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: _width * 14,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(90)),
                    child: ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(
                                email: _emailTextController.text)
                            .onError((error, stackTrace) {
                          isAnyError = true;
                          setState(() {
                            msg = error.toString();
                          });
                        });

                        if (isAnyError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            showCustomSnackBar(
                              ctype: ContentType.failure,
                              message: msg,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            showCustomSnackBar(
                              ctype: ContentType.help,
                              message: "Check Your Email" + msg,
                            ),
                          );
                        }
                      },
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
                                    borderRadius: BorderRadius.circular(100))),
                      ),
                      child: const Text(
                        "Change Password",
                        style: TextStyle(
                          color: secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: _width * 11,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
