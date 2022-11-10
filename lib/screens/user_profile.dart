import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:meet_pet/models/pet.dart';
import 'package:meet_pet/screens/add_pet.dart';
import 'package:meet_pet/screens/favorite_pets.dart';
import 'package:meet_pet/widgets/pet_card.dart';

import '../models/address.dart';
import '../models/user.dart' as model;
import '../resources/firestore_methods.dart';
import '../utils/colors.dart';
import 'home_page.dart';

class UserProfile extends StatefulWidget {
  final model.User cUser;
  const UserProfile({
    Key? key,
    required this.cUser,
  }) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool _isLoading = false;
  int _selectedCategory = 1;

  Map petListdb = {};
  List<Pet> petsForAdoptionList = [];
  List<Pet> petsAdoptedList = [];
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      for (var p in widget.cUser.petsForAdoption) {
        DocumentSnapshot<Map<String, dynamic>> petSnap =
            await FirebaseFirestore.instance.collection('pets').doc(p).get();

        var pet = petSnap.data()!;
        var curPet = Pet(
          age: pet["age"],
          breed: pet["breed"],
          desc: pet["desc"],
          gender: pet["gender"],
          imgs: pet["imgs"], // problem
          name: pet["name"],
          oldOwner: pet["oldOwner"],
          oldOwnerUID: pet["oldOwnerUID"],
          petId: pet["petId"],
          type: pet["type"],
          datePosted: pet["datePosted"].toDate(), //problem
          address: Address(
            addLine1: pet["address"]["addLine1"],
            addLine2: pet["address"]["addLine2"],
            city: pet["address"]["city"],
            state: pet["address"]["state"],
            country: pet["address"]["country"],
            zipCode: pet["address"]["zipCode"],
          ),
        );

        petsForAdoptionList.add(curPet);
      }
      for (var p in widget.cUser.petsAdopted) {
        DocumentSnapshot<Map<String, dynamic>> petSnap =
            await FirebaseFirestore.instance.collection('pets').doc(p).get();

        var pet = petSnap.data()!;
        var curPet = Pet(
          age: pet["age"],
          breed: pet["breed"],
          desc: pet["desc"],
          gender: pet["gender"],
          imgs: pet["imgs"], // problem
          name: pet["name"],
          oldOwner: pet["oldOwner"],
          oldOwnerUID: pet["oldOwnerUID"],
          petId: pet["petId"],
          type: pet["type"],
          datePosted: pet["datePosted"].toDate(), //problem
          address: Address(
            addLine1: pet["address"]["addLine1"],
            addLine2: pet["address"]["addLine2"],
            city: pet["address"]["city"],
            state: pet["address"]["state"],
            country: pet["address"]["country"],
            zipCode: pet["address"]["zipCode"],
          ),
        );

        petsAdoptedList.add(curPet);
      }
    } catch (e) {
      // showSnackBar(
      //   context,
      //   e.toString(),
      // );
    }
    setState(() {
      _isLoading = false;
    });
    // print(userData);
  }

  void navigateToAddPet() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AddPet(
          cUser: widget.cUser,
          setIndex: (index) {
            setState(() {
              menuItemSelected = index;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width * 0.01;
    double _height = MediaQuery.of(context).size.height * 0.01;
    print(_width);
    // model.User cUser = model.User.fromMap(userData);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          "Profile",
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
              Stack(
                children: [
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              MediaQuery.of(context).size.width * 0.1),
                          topRight: Radius.circular(
                              MediaQuery.of(context).size.width * 0.1),
                          // bottomLeft: Radius.circular(
                          // MediaQuery.of(context).size.width * 0.1),
                          // bottomRight: Radius.circular(
                          // MediaQuery.of(context).size.width * 0.1),
                        ),
                        child: Image.network(
                          widget.cUser.backCoverImg,
                          height: MediaQuery.of(context).size.width * 0.5,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.width * 0.25,
                      ),
                    ],
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.width * 0.3,
                    right: MediaQuery.of(context).size.width * 0.05,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width * 0.25),
                      child: Container(
                        color: secondary,
                        height: MediaQuery.of(context).size.width * 0.44,
                        width: MediaQuery.of(context).size.width * 0.44,
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.width * 0.32,
                    right: MediaQuery.of(context).size.width * 0.07,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width * 0.2),
                      child: Container(
                        color: secondary,
                        height: MediaQuery.of(context).size.width * 0.4,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Image.network(
                          widget.cUser.profileImg,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  // Positioned(
                  //   top: MediaQuery.of(context).size.width * 0.3,
                  //   right: MediaQuery.of(context).size.width * 0.35,
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(
                  //         MediaQuery.of(context).size.width * 0.2),
                  //     child: InkWell(
                  //       onTap: () => changeImageDropDown(),
                  //       child: Container(
                  //         color: secondary,
                  //         height: MediaQuery.of(context).size.width * 0.14,
                  //         width: MediaQuery.of(context).size.width * 0.14,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Positioned(
                    top: MediaQuery.of(context).size.width * 0.32,
                    right: MediaQuery.of(context).size.width * 0.37,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width * 0.2),
                      child: InkWell(
                        onTap: () => changeImageDropDown(),
                        child: Container(
                          color: primary,
                          height: MediaQuery.of(context).size.width * 0.1,
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: Icon(
                            FontAwesomeIcons.camera,
                            color: white,
                            size: MediaQuery.of(context).size.width * 0.05,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                widget.cUser.userName,
                textScaleFactor: 1.5,
                style: TextStyle(
                  color: black,
                ),
              ),
              Text(
                "${widget.cUser.firstName} ${widget.cUser.lastName}",
                textScaleFactor: 1.7,
                style: TextStyle(
                  color: black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${widget.cUser.address.addLine1}, ${widget.cUser.address.addLine2},",
                textScaleFactor: 1.2,
                style: TextStyle(
                  color: black,
                ),
              ),
              Text(
                "${widget.cUser.address.city}, ${widget.cUser.address.state}, ${widget.cUser.address.country}",
                textScaleFactor: 1,
                style: TextStyle(
                  color: black,
                ),
              ),
              Text(
                widget.cUser.emailId,
                textScaleFactor: 1.2,
                style: TextStyle(
                  color: black,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.cUser.contactNo,
                    textScaleFactor: 1.2,
                    style: TextStyle(
                      color: black,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // addpet();
                    },
                    child: Icon(
                      Icons.edit,
                      color: black,
                    ),
                  ),
                ],
              ),
              Container(
                child: Divider(
                  color: primary,
                  // height: 36,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: _width * 15,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(_width * 7.5),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(child: Container(), flex: 1),
                      Text(
                        "Pets added for adoption",
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          color: black,
                        ),
                      ),
                      Flexible(child: Container(), flex: 2),
                      InkWell(
                        onTap: () {
                          print("All pets put for adoption");
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => FavoritePetScreen(
                                  cUser: widget.cUser,
                                  listType: "Pets For Adoption"),
                            ),
                          );
                        },
                        child: Icon(
                          FontAwesomeIcons.chevronDown,
                          color: black,
                        ),
                      ),
                      Flexible(child: Container(), flex: 1),
                    ],
                  ),
                ),
              ),
              (petsForAdoptionList.isEmpty)
                  ? SizedBox(
                      height: _width * 0.8,
                      width: _width,
                      child: Center(
                        child: Text(
                          "No Pets put for adoption",
                          style: TextStyle(
                            color: black,
                          ),
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (var pet in petsForAdoptionList) ...[
                            portraitPetCard(pet, widget.cUser, context),
                          ]
                        ],
                      ),
                    ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: _width * 15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_width * 7.5)),
                child: ElevatedButton(
                  onPressed: () => navigateToAddPet(),
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
              Container(
                child: Divider(
                  color: primary,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: _width * 15,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(_width * 7.5),
                ),
                child: Center(
                  child: Row(
                    children: [
                      Flexible(child: Container(), flex: 1),
                      Text(
                        "Pets adopted",
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          color: black,
                        ),
                      ),
                      Flexible(child: Container(), flex: 3),
                      InkWell(
                        onTap: () {
                          print("All pets adopted");
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => FavoritePetScreen(
                                  cUser: widget.cUser,
                                  listType: "Pets Adopted"),
                            ),
                          );
                        },
                        child: Icon(
                          FontAwesomeIcons.chevronDown,
                          color: black,
                        ),
                      ),
                      Flexible(child: Container(), flex: 1),
                    ],
                  ),
                ),
              ),
              (petsAdoptedList.isEmpty)
                  ? SizedBox(
                      width: _width,
                      height: _width * 0.8,
                      child: Center(
                        child: Text(
                          "No Pets adopted",
                          style: TextStyle(
                            color: black,
                          ),
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (var pet in petsAdoptedList) ...[
                            portraitPetCard(pet, widget.cUser, context),
                          ]
                        ],
                      ),
                    ),
              Container(
                child: Divider(
                  color: primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

changeImageDropDown() {
  print("Change Image");
}
