import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meet_pet/screens/home_page.dart';

import '../resources/auth_methods.dart';
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
  bool _isLoading = false;

  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _contactNumberTextController =
      TextEditingController();
  final TextEditingController _firstNameTextController =
      TextEditingController();
  final TextEditingController _lastNameTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _addLine1TextController = TextEditingController();
  final TextEditingController _addLine2TextController = TextEditingController();
  final TextEditingController _cityTextController = TextEditingController();
  final TextEditingController _stateTextController = TextEditingController();
  final TextEditingController _countryTextController = TextEditingController();
  final TextEditingController _zipCodeTextController = TextEditingController();
  DateTime birthDate = DateTime.now();
  Uint8List? _profilePicImage;
  Uint8List? _backCoverPicImage;

  @override
  dispose() {
    super.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _contactNumberTextController.dispose();
    _firstNameTextController.dispose();
    _lastNameTextController.dispose();
    _addLine1TextController.dispose();
    _addLine2TextController.dispose();
    _cityTextController.dispose();
    _stateTextController.dispose();
    _countryTextController.dispose();
    _zipCodeTextController.dispose();
    _userNameTextController.dispose();
  }

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

  signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
        email: _emailTextController.text,
        password: _passwordTextController.text,
        userName: _userNameTextController.text,
        firstName: _firstNameTextController.text,
        lastName: _lastNameTextController.text,
        contactNumber: _contactNumberTextController.text,
        dob: birthDate,
        addLine1: _addLine1TextController.text,
        addLine2: _addLine2TextController.text,
        city: _cityTextController.text,
        state: _stateTextController.text,
        country: _countryTextController.text,
        zipCode: int.parse(_zipCodeTextController.text),
        profilePicFile: _profilePicImage!,
        backCoverPicFile: _backCoverPicImage!);
    setState(() {
      _isLoading = false;
    });
    print(res);

    if (res == 'success') {
      gotoHome();
    } else {
      // showSnackBar(res, context);
    }
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
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
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
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              color: primary,
            ),
            height: 55,
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: white,
                    ),
                  )
                : InkWell(
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

  void selectProfilePicImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _profilePicImage = im;
    });
  }

  void selectBackCoverPicImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _backCoverPicImage = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.01;
    double height = MediaQuery.of(context).size.height * 0.01;
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
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
                  textFieldUi('User Name', Icons.person, false,
                      _userNameTextController, TextInputType.name),
                  const SizedBox(
                    height: 20,
                  ),
                  textFieldUi('Email', Icons.email_outlined, false,
                      _emailTextController, TextInputType.emailAddress),
                  const SizedBox(
                    height: 20,
                  ),
                  textFieldUi('Password', Icons.lock_outline, true,
                      _passwordTextController, TextInputType.visiblePassword),
                  const SizedBox(
                    height: 20,
                  ),
                  navigationButtons('Login', 'Next'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              right: 35,
              left: 35,
            ),
            color: secondary,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
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
                      _firstNameTextController, TextInputType.name),
                  const SizedBox(
                    height: 20,
                  ),
                  textFieldUi('Last Name', Icons.person, false,
                      _lastNameTextController, TextInputType.name),
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
                  textFieldUi('Contact No. ', Icons.call, false,
                      _contactNumberTextController, TextInputType.phone),
                  const SizedBox(
                    height: 20,
                  ),
                  navigationButtons('Prev', 'Next'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              right: 35,
              left: 35,
            ),
            color: secondary,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
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
                      'Address Line 1',
                      FontAwesomeIcons.locationArrow,
                      false,
                      _addLine1TextController,
                      TextInputType.streetAddress),
                  const SizedBox(
                    height: 20,
                  ),
                  textFieldUi('Address Line 2', FontAwesomeIcons.mapPin, false,
                      _addLine2TextController, TextInputType.name),
                  const SizedBox(
                    height: 20,
                  ),
                  textFieldUi('City', FontAwesomeIcons.city, false,
                      _cityTextController, TextInputType.name),
                  const SizedBox(
                    height: 20,
                  ),
                  textFieldUi('State', FontAwesomeIcons.locationDot, false,
                      _stateTextController, TextInputType.name),
                  const SizedBox(
                    height: 20,
                  ),
                  textFieldUi('Country', FontAwesomeIcons.globe, false,
                      _countryTextController, TextInputType.name),
                  const SizedBox(
                    height: 20,
                  ),
                  textFieldUi('Zipcode', FontAwesomeIcons.mapLocationDot, false,
                      _zipCodeTextController, TextInputType.number),
                  const SizedBox(
                    height: 20,
                  ),
                  navigationButtons("Prev", "Next"),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              right: 35,
              left: 35,
            ),
            color: secondary,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
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
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: width * 15,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(width * 7.5),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(flex: 1, child: Container()),
                          Text(
                            "Add Profile Picture",
                            textScaleFactor: 1.5,
                            style: TextStyle(
                              color: black,
                            ),
                          ),
                          Flexible(flex: 1, child: Container()),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.05,
                  ),
                  InkWell(
                    onTap: () => selectProfilePicImage(),
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.5,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width * 0.05,
                        ),
                        child: _backCoverPicImage != null
                            ? Image.memory(
                                _profilePicImage!,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: width * 15,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(width * 7.5),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(flex: 1, child: Container()),
                          Text(
                            "Add Back Cover Picture",
                            textScaleFactor: 1.5,
                            style: TextStyle(
                              color: black,
                            ),
                          ),
                          Flexible(flex: 1, child: Container()),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.05,
                  ),
                  InkWell(
                    onTap: () => selectBackCoverPicImage(),
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.4,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * 0.05,
                          ),
                          child: _backCoverPicImage != null
                              ? Image.memory(
                                  _backCoverPicImage!,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  color: black.withOpacity(0.3),
                                )),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.05,
                  ),
                  navigationButtons("Prev", "Register"),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                ],
              ),
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

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  }
  print("No image selected");
}
