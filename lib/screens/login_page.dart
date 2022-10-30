import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../widgets/text_field_ui.dart';
import 'sign_up_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondary,
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: Container(),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 35, top: 30),
            child: Text(
              "Login",
              textScaleFactor: 3,
              style: TextStyle(
                color: primary,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            padding: const EdgeInsets.only(
              right: 35,
              left: 35,
            ),
            child: Column(children: [
              textFieldUi('Email', Icons.person, false, _emailTextController),
              const SizedBox(
                height: 20,
              ),
              textFieldUi('Password', Icons.lock_outline, true,
                  _passwordTextController),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'forgotPasswordPage');
                      },
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                          fontSize: 18,
                          color: primary,
                        ),
                      ))
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(90)),
                child: ElevatedButton(
                  onPressed: () {},
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
                            borderRadius: BorderRadius.circular(10))),
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
              Row(children: <Widget>[
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(right: 20.0),
                      child: Divider(
                        color: primary,
                        // height: 36,
                      )),
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
                      )),
                ),
              ]),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(90)),
                child: ElevatedButton(
                  onPressed: () {
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
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
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
            ]),
          ),
          Flexible(
            flex: 1,
            child: Container(),
          ),
        ],
      ),
    );
  }

  void openSignUp() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const SignUpPage()));
  }
}
