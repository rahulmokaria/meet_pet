// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:meet_pet/widgets/show_snackbar.dart';

import '../models/user.dart';
import '../resources/firestore_methods.dart';
import '../utils/colors.dart';
import '../widgets/text_field_ui.dart';
import 'home_page.dart';

class AddPet extends StatefulWidget {
  final User cUser;
  final ValueSetter setIndex;
  const AddPet({
    Key? key,
    required this.cUser,
    required this.setIndex,
  }) : super(key: key);

  @override
  State<AddPet> createState() => _AddPetState();
}

class _AddPetState extends State<AddPet> {
  bool _isLoading = false;
  final TextEditingController _breedTextController = TextEditingController();
  final TextEditingController _ageTextController = TextEditingController();
  final TextEditingController _descTextController = TextEditingController();

  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _typeTextController = TextEditingController();
  final ImagePicker imgPicker = ImagePicker();
  List<XFile> imageFiles = [];

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

  @override
  dispose() {
    super.dispose();
    _breedTextController.dispose();
    _ageTextController.dispose();
    _descTextController.dispose();
    _nameTextController.dispose();
    _typeTextController.dispose();
    _addLine1TextController.dispose();
    _addLine2TextController.dispose();
    _cityTextController.dispose();
    _stateTextController.dispose();
    _countryTextController.dispose();
    _zipCodeTextController.dispose();
  }

  addPet() {
    setState(() {
      _isLoading = true;
    });
    var res = FireStoreMethods().uploadPet(
      age: double.parse(_ageTextController.text),
      breed: _breedTextController.text,
      desc: _descTextController.text,
      gender: dropdownGender[0],
      imgs: imageFiles,
      name: _nameTextController.text,
      type: _typeTextController.text,
      oldOwner: "${widget.cUser.firstName} ${widget.cUser.lastName}",
      oldOwnerUID: widget.cUser.uid,
      addLine1: _addLine1TextController.text,
      addLine2: _addLine2TextController.text,
      city: _cityTextController.text,
      state: _stateTextController.text,
      country: _countryTextController.text,
      zipCode: int.parse(_zipCodeTextController.text),
    );
    setState(() {
      _isLoading = false;
      menuItemSelected = 1;
    });
    if (res == "success") {
      showCustomSnackBar(
          "Awww, So Cute!!!",
          dropdownGender[0] == 'M'
              ? "Isn't he the cutest${_typeTextController.text} ever"
              : "Isn't she the cutest${_typeTextController.text} ever",
          primary,
          Icons.favorite);
      widget.setIndex(1);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => const HomePage()));
    } else {
      showCustomSnackBar("Some error occurred, Try again", "", pink,
          CupertinoIcons.exclamationmark_circle);
    }
  }

  responseImageSelection() async {
    String s = await openImages();
    if (s == "success")
      showCustomSnackBar("So Cute!!!", "", primary, Icons.favorite);
    else {
      showCustomSnackBar("Some error occurred, Try again", "", pink,
          CupertinoIcons.exclamationmark_circle);
    }
  }

  Future<String> openImages() async {
    try {
      var pickedFiles = await imgPicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedFiles != null) {
        imageFiles = pickedFiles;
        setState(() {});
        return "success";
      } else {
        return "No image is selected.";
      }
    } catch (e) {
      return "error while picking file.";
    }
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width * 0.01;
    double _height = MediaQuery.of(context).size.height * 0.01;
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
            MediaQuery.of(context).size.width * 0.05,
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
              if (imageFiles.isNotEmpty)
                Container(
                  padding: EdgeInsets.only(left: _width * 5),
                  child: Text(
                    "Pet Photos:",
                    style: TextStyle(color: black),
                  ),
                ),
              Wrap(
                children: imageFiles.map((imageone) {
                  return Container(
                      child: Card(
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Image.file(
                        File(imageone.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ));
                }).toList(),
              ),
              SizedBox(
                height: _width * 7,
              ),
              InkWell(
                onTap: () => responseImageSelection(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: _width * 15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(_width * 7.5),
                      color: white),
                  child: Center(
                    child: Text(
                      "Upload Pet's photos",
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.bold,
                        // fontSize: 16,
                      ),
                    ),
                  ),
                  // child: ElevatedButton(
                  //   // onPressed: () => responseImageSelection(),
                  //   // style: ButtonStyle(
                  //   //   backgroundColor:
                  //   //       MaterialStateProperty.resolveWith((states) {
                  //   //     if (states.contains(MaterialState.pressed)) {
                  //   //       return primary;
                  //   //     }
                  //   //     return white;
                  //   //   }),
                  //   //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  //   //       RoundedRectangleBorder(
                  //   //           borderRadius:
                  //   //               BorderRadius.circular(_width * 7.5))),
                  //   // ),

                  // ),
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
                  _breedTextController, TextInputType.emailAddress),
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
                  onPressed: () => addPet(),
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
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: white,
                          ),
                        )
                      : const Text(
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
