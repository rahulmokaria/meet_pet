import 'package:flutter/material.dart';
import 'package:meet_pet/screens/home_page.dart';

import '../utils/colors.dart';
import '../widgets/text_field_ui.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  PageController page = PageController(initialPage: 0);
  int pageIndex = 0;

  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _contactNumberTextController =
      TextEditingController();
  final TextEditingController _firstNameTextController =
      TextEditingController();
  final TextEditingController _lastNameTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _addressTextController = TextEditingController();
  DateTime birthDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: birthDate,
        firstDate: DateTime(1950),
        lastDate: DateTime.now());
    if (picked != null && picked != birthDate) {
      setState(() {
        birthDate = picked;
        print(birthDate);
      });
    }
  }

  signUpUser() {
    gotoHome();
  }

  void openLoginPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const LoginPage()));
  }

  void gotoHome() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const HomePage()));
  }

  Container navigationButtons(String but1, String but2) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              color: primary,
            ),
            height: 55,
            child: InkWell(
              onTap: () {
                (but1 == 'Login')
                    ? Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const LoginPage()))
                    : page.animateToPage(--pageIndex,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.linearToEaseOut);
              },
              child: Center(
                child: Text(
                  but1,
                  style: const TextStyle(
                    color: white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: primary,
            ),
            height: 55,
            child: InkWell(
              onTap: () {
                (but2 == 'Register')
                    ? signUpUser()
                    : page.animateToPage(++pageIndex,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.linearToEaseOut);
              },
              child: Center(
                child: Text(
                  but2,
                  style: const TextStyle(
                    color: white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: page,
        scrollDirection: Axis.horizontal,
        // pageSnapping: false,
        children: [
          Container(
            padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.1,
              left: MediaQuery.of(context).size.width * 0.1,
            ),
            color: secondary,
            child: Column(
              children: [
                Flexible(
                  child: Container(),
                  flex: 2,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Register",
                    textScaleFactor: 3,
                    style: TextStyle(
                      color: primary,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                textFieldUi(
                    'User Name', Icons.person, false, _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                textFieldUi(
                    'Email', Icons.email_outlined, false, _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                textFieldUi('Password', Icons.lock_outline, true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                navigationButtons('Login', 'Next'),
                Flexible(
                  child: Container(),
                  flex: 1,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              right: 35,
              left: 35,
            ),
            color: secondary,
            child: Column(
              children: [
                Flexible(
                  child: Container(),
                  flex: 2,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Register",
                    textScaleFactor: 3,
                    style: TextStyle(
                      color: primary,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                textFieldUi('First Name', Icons.person, false,
                    _firstNameTextController),
                const SizedBox(
                  height: 20,
                ),
                textFieldUi(
                    'Last Name', Icons.person, false, _lastNameTextController),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: secondaryLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.fromLTRB(10, 20, 0, 20),
                  child: InkWell(
                    onTap: () => _selectDate(context),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          color: primary,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(
                          "Date Of Birth :",
                          style: TextStyle(
                            color: primary,
                          ),
                          textScaleFactor: 1.2,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "${birthDate.day} ${textMonth(birthDate.month)} ${birthDate.year}",
                          style: TextStyle(
                            color: primary,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                navigationButtons('Prev', 'Next'),
                Flexible(
                  child: Container(),
                  flex: 1,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              right: 35,
              left: 35,
            ),
            color: secondary,
            child: Column(
              children: [
                Flexible(
                  child: Container(),
                  flex: 2,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Register",
                    textScaleFactor: 3,
                    style: TextStyle(
                      color: primary,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                textFieldUi(
                    'User Name', Icons.person, false, _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                textFieldUi(
                    'Email', Icons.email_outlined, false, _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                textFieldUi('Password', Icons.lock_outline, true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                navigationButtons("Prev", "Register"),
                Flexible(
                  child: Container(),
                  flex: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

textMonth(num month) {
  switch (month) {
    case 1:
      return "January";
    case 2:
      return "February";
    case 3:
      return "March";
    case 4:
      return "April";
    case 5:
      return "May";
    case 6:
      return "June";
    case 7:
      return "July";
    case 8:
      return "August";
    case 9:
      return "September";
    case 10:
      return "October";
    case 11:
      return "November";
    case 12:
      return "December";
  }
}
