// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/user.dart';
import '../resources/firestore_methods.dart';
import '../utils/colors.dart';
import '../widgets/text_field_ui.dart';
import 'home_page.dart';

class AddPet extends StatefulWidget {
  final User cUser;
  const AddPet({
    Key? key,
    required this.cUser,
  }) : super(key: key);

  @override
  State<AddPet> createState() => _AddPetState();
}

class _AddPetState extends State<AddPet> {
  final TextEditingController _breedTextController = TextEditingController();
  final TextEditingController _ageTextController = TextEditingController();
  final TextEditingController _descTextController = TextEditingController();
  final TextEditingController _genderTextController = TextEditingController();
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _typeTextController = TextEditingController();

  var dropdownGender = 'Male';
  var genderCategories = [
    "Male",
    'Female',
  ];
  TextEditingController _addLine1TextController = TextEditingController();
  TextEditingController _addLine2TextController = TextEditingController();
  TextEditingController _cityTextController = TextEditingController();
  TextEditingController _stateTextController = TextEditingController();
  TextEditingController _countryTextController = TextEditingController();
  TextEditingController _zipCodeTextController = TextEditingController();
  DateTime datePosted = DateTime.now();

  @override
  void initState() {
    super.initState();
    _addLine1TextController =
        TextEditingController(text: widget.cUser.address.addLine1);
    _addLine2TextController =
        TextEditingController(text: widget.cUser.address.addLine2);
    _cityTextController =
        TextEditingController(text: widget.cUser.address.city);
    _stateTextController =
        TextEditingController(text: widget.cUser.address.state);
    _countryTextController =
        TextEditingController(text: widget.cUser.address.country);
    _zipCodeTextController =
        TextEditingController(text: widget.cUser.address.zipCode.toString());
  }

  addpet() {
    var res = FireStoreMethods().uploadPet(
      age: 2.0,
      breed: 'Labrador',
      desc:
          "Everything is so expensive.Going to a bar is a fun thing to do.Here's my big brother. Doesn't he look good?",
      gender: 'M',
      imgs: [
        "https://firebasestorage.googleapis.com/v0/b/meet-pet-c2294.appspot.com/o/BackCoverPics%2FFFFM2xvMslSoaPLqsPLkOTcfV803?alt=media&token=d9488c30-57d9-4c15-9d53-a5c9f2939a17",
        "https://firebasestorage.googleapis.com/v0/b/meet-pet-c2294.appspot.com/o/BackCoverPics%2FFFFM2xvMslSoaPLqsPLkOTcfV803?alt=media&token=d9488c30-57d9-4c15-9d53-a5c9f2939a17",
      ],
      name: 'Duggu',
      type: 'dog',
      oldOwner: 'Rahul Mokara',
      oldOwnerUID: '',
      datePosted: DateTime.now(),
      addLine1: "P-131 Near Shivam Appt",
      addLine2: "RajivNagar",
      city: "Porbandar",
      state: "Gujarat",
      country: "India",
      zipCode: 360575,
    );
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width * 0.01;
    double _height = MediaQuery.of(context).size.height * 0.01;
    // print(_width);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          "Add pet",
          style: TextStyle(
            color: primary,
          ),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.barsStaggered,
            color: primary,
          ),
          onPressed: () {
            zoomDrawerController.toggle!();
          },
        ),
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(
            MediaQuery.of(context).size.width * 0.02,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(_width * 10),
              topRight:
                  Radius.circular(MediaQuery.of(context).size.width * 0.1),
            ),
            color: secondary,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.only(left: _width * 5),
                  child: Text(
                    "Enter details about pet",
                    textScaleFactor: 1.2,
                    style: TextStyle(color: black),
                  ),
                ),
              ),
              SizedBox(
                height: _width * 7,
              ),
              Container(
                padding: EdgeInsets.only(left: _width * 5),
                child: Text(
                  "Pet Name:",
                  style: TextStyle(color: black),
                ),
              ),
              textFieldUi('Eg: Tommy', FontAwesomeIcons.paw, false,
                  _nameTextController, TextInputType.name),
              SizedBox(
                height: _width * 7,
              ),
              Container(
                padding: EdgeInsets.only(left: _width * 5),
                child: Text(
                  "Breed:",
                  style: TextStyle(color: black),
                ),
              ),
              textFieldUi('Eg: Labrador', Icons.person, false,
                  _breedTextController, TextInputType.name),
              SizedBox(
                height: _width * 7,
              ),
              Container(
                padding: EdgeInsets.only(left: _width * 5),
                child: Text(
                  "Pet Type:",
                  style: TextStyle(color: black),
                ),
              ),
              textFieldUi('Eg: Dog', FontAwesomeIcons.cat, false,
                  _typeTextController, TextInputType.name),
              SizedBox(
                height: _width * 7,
              ),
              Container(
                padding: EdgeInsets.only(left: _width * 5),
                child: Text(
                  "Description:",
                  style: TextStyle(color: black),
                ),
              ),
              textFieldUi('...', FontAwesomeIcons.pager, false,
                  _descTextController, TextInputType.name),
              SizedBox(
                height: _width * 7,
              ),
              Container(
                padding: EdgeInsets.only(left: _width * 5),
                child: Text(
                  "Age:",
                  style: TextStyle(color: black),
                ),
              ),
              textFieldUi('Eg: 2.5', FontAwesomeIcons.arrowUpRightDots, false,
                  _ageTextController, TextInputType.number),
              SizedBox(
                height: _width * 7,
              ),
              Container(
                decoration: BoxDecoration(
                  color: secondaryLight,
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                child: Row(
                  children: [
                    Icon(Icons.boy_outlined, color: primary),
                    const SizedBox(width: 5),
                    Text(
                      "Gender:",
                      style: TextStyle(
                        color: primary,
                      ),
                      textScaleFactor: 1.2,
                    ),
                    const SizedBox(
                      width: 70,
                    ),
                    DropdownButton(
                      value: dropdownGender,
                      underline: const SizedBox(),
                      dropdownColor: secondaryLight,
                      items: genderCategories
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            textScaleFactor: 1.2,
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownGender = newValue!;
                        });
                      },
                      icon: const Icon(Icons.keyboard_arrow_down),
                      style: TextStyle(
                        color: primary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: _width * 7,
              ),
              Container(
                padding: EdgeInsets.only(left: _width * 5),
                child: Text(
                  "Address Line 1:",
                  style: TextStyle(color: black),
                ),
              ),
              textFieldUi('Address Line 1', FontAwesomeIcons.locationArrow,
                  false, _addLine1TextController, TextInputType.streetAddress),
              SizedBox(
                height: _width * 7,
              ),
              Container(
                padding: EdgeInsets.only(left: _width * 5),
                child: Text(
                  "Address Line 2:",
                  style: TextStyle(color: black),
                ),
              ),
              textFieldUi('Address Line 2', FontAwesomeIcons.mapPin, false,
                  _addLine2TextController, TextInputType.name),
              SizedBox(
                height: _width * 7,
              ),
              Container(
                padding: EdgeInsets.only(left: _width * 5),
                child: Text(
                  "City:",
                  style: TextStyle(color: black),
                ),
              ),
              textFieldUi('City', FontAwesomeIcons.city, false,
                  _cityTextController, TextInputType.name),
              SizedBox(
                height: _width * 7,
              ),
              Container(
                padding: EdgeInsets.only(left: _width * 5),
                child: Text(
                  "State:",
                  style: TextStyle(color: black),
                ),
              ),
              textFieldUi('State', FontAwesomeIcons.locationDot, false,
                  _stateTextController, TextInputType.name),
              SizedBox(
                height: _width * 7,
              ),
              Container(
                padding: EdgeInsets.only(left: _width * 5),
                child: Text(
                  "Country:",
                  style: TextStyle(color: black),
                ),
              ),
              textFieldUi('Country', FontAwesomeIcons.globe, false,
                  _countryTextController, TextInputType.name),
              SizedBox(
                height: _width * 7,
              ),
              Container(
                padding: EdgeInsets.only(left: _width * 5),
                child: Text(
                  "Zip Code:",
                  style: TextStyle(color: black),
                ),
              ),
              textFieldUi('Zipcode', FontAwesomeIcons.mapLocationDot, false,
                  _zipCodeTextController, TextInputType.number),
              SizedBox(
                height: _width * 7,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: _width * 15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_width * 7.5)),
                child: ElevatedButton(
                  onPressed: () => addpet(),
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
                            borderRadius: BorderRadius.circular(_width * 7.5))),
                  ),
                  child: const Text(
                    "Add Pet for Adoption",
                    textScaleFactor: 1.2,
                    style: TextStyle(
                      color: secondary,
                      fontWeight: FontWeight.bold,
                      // fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
