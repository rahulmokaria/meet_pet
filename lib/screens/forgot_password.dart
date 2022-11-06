import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meet_pet/widgets/show_snackbar.dart';

import '../utils/colors.dart';
// import '../widgets/show_error.dart';
import '../widgets/text_field_ui.dart';

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
    return Scaffold(
      backgroundColor: secondary,
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 35, top: 80),
            child: Text(
              "Forgot\nPassword",
              style: TextStyle(
                color: primary,
                fontSize: 60,
              ),
            ),
          ),
          const SizedBox(
            height: 75,
          ),
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(
                right: 35,
                left: 35,
              ),
              child: Column(children: [
                textFieldUi('Email', Icons.person, false, _emailTextController,
                    TextInputType.emailAddress),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
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
                            showCustomSnackBar("Oh Snap!", msg, primary,
                                CupertinoIcons.exclamationmark_circle));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            showCustomSnackBar("Check Your Email", msg, primary,
                                CupertinoIcons.check_mark_circled));
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100))),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
