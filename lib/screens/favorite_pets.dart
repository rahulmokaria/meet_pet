// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/address.dart';
import '../models/pet.dart';
import '../models/user.dart' as model;
import '../utils/colors.dart';
import '../widgets/pet_card.dart';
import 'home_page.dart';

class FavoritePetScreen extends StatefulWidget {
  final model.User cUser;
  final String listType;
  const FavoritePetScreen({
    Key? key,
    required this.cUser,
    required this.listType,
  }) : super(key: key);

  @override
  State<FavoritePetScreen> createState() => _FavoritePetScreenState();
}

class _FavoritePetScreenState extends State<FavoritePetScreen> {
  bool _isLoading = false;
  String category = "All";
  int _selectedCategory = 1;

  Map petListdb = {};
  List<Pet> petList = [];
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
      List<dynamic> petList = (widget.listType == "Favorite Pets")
          ? widget.cUser.favPetList
          : (widget.listType == "Pets For Adoption")
              ? widget.cUser.petsForAdoption
              : widget.cUser.petsAdopted;
      for (var p in petList) {
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

        petList.add(curPet);
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

  Widget filterOption(
    int index,
    String type,
    String img,
  ) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedCategory = index;
          category = type;
        });
      },
      child: Neumorphic(
        style: NeumorphicStyle(
          shape: NeumorphicShape.concave,
          surfaceIntensity: .1,
          color: _selectedCategory == index ? primary : secondary,
          shadowLightColor: secondaryLight,
          shadowDarkColor: secondaryDark,
          depth: 18,
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(right: 10),
        child: Row(
          children: [
            Image.asset(
              img,
              width: 30,
              color: _selectedCategory == index ? white : black,
            ),
            const SizedBox(width: 10),
            Text(
              type,
              style: TextStyle(
                color: _selectedCategory == index ? white : black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showPetList() {
    int len = 0;

    for (var pet in petList) {
      if (category == 'All' || category.toLowerCase() == (pet.type + "s")) {
        len++;
      }
    }
    if (len == 0) {
      return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
              "No pet found",
              textScaleFactor: 1.5,
              style: TextStyle(
                color: black,
              ),
            ),
          ));
    } else {
      return Column(
        children: [
          for (var pet in petList) ...[
            if (category == 'All' || category.toLowerCase() == (pet.type + "s"))
              landscapePetCard(pet, widget.cUser, context),
          ]
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(petList);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          widget.listType,
          // (widget.listType == "favPetList")
          //     ? "Favorite Pets"
          //     : (widget.listType == "petsForAdoption")
          //         ? "Pets For Adoption"
          //         : "Pets Adopted",
          style: TextStyle(
            color: primary,
          ),
          textAlign: TextAlign.center,
        ),
        // elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.barsStaggered,
            color: primary,
          ),
          onPressed: () {
            zoomDrawerController.toggle!();
          },
        ),
        // shadowColor: secondaryLight,
        shadowColor: Colors.transparent,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: white,
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: secondary,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              filterOption(
                                  1, 'All', 'assets/images/animal-shelter.png'),
                              filterOption(2, 'Dogs', 'assets/images/dog.png'),
                              filterOption(3, 'Cats', 'assets/images/cat.png'),
                              filterOption(
                                  4, 'Birds', 'assets/images/bird.png'),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    // const SizedBox(
                    //   height: 20,
                    // ),c
                    showPetList(),
                  ],
                ),
              ),
            ),
    );
  }
}
