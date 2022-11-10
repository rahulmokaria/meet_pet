// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/address.dart';
import '../models/pet.dart';
import '../models/user.dart';
import '../utils/colors.dart';
import '../widgets/pet_card.dart';
import 'home_page.dart';

class AdoptPetScreen extends StatefulWidget {
  final User cUser;
  final List<Pet> petList;
  const AdoptPetScreen({
    Key? key,
    required this.cUser,
    required this.petList,
  }) : super(key: key);

  @override
  State<AdoptPetScreen> createState() => _AdoptPetScreenState();
}

class _AdoptPetScreenState extends State<AdoptPetScreen> {
  bool _isLoading = false;
  String category = "All";
  int _selectedCategory = 1;
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

    for (var pet in widget.petList) {
      if (category == 'All' ||
          category.toLowerCase() == (pet.type + "s").toLowerCase()) {
        len++;
      }
    }
    if (len == 0) {
      return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
              "No pet found for adoption",
              textScaleFactor: 1.5,
              style: TextStyle(
                color: black,
              ),
            ),
          ));
    } else {
      return Column(
        children: [
          for (var pet in widget.petList) ...[
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
          "Adoption",
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
