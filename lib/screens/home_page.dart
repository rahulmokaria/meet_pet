import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meet_pet/screens/pet_description_page.dart';
import 'package:meet_pet/utils/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/pet.dart';
import '../utils/colors.dart';
import '../widgets/menu_screen.dart';

final ZoomDrawerController zoomDrawerController = ZoomDrawerController();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _menuItemSelected = 1;
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: zoomDrawerController,
      borderRadius: 24,
      style: DrawerStyle.defaultStyle,
      showShadow: true,
      openCurve: Curves.fastOutSlowIn,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
      duration: const Duration(milliseconds: 500),
      angle: 0.0,
      menuBackgroundColor: primary,
      mainScreen: const Body(),
      menuScreen: const MenuScreen(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
    value: -1.0,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool get isPanelVisible {
    final AnimationStatus status = controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

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

  Widget petCard(Pet pet) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => PetDescription(
                  cpet: pet,
                )));
      },
      child: Container(
        height: 150,
        padding: const EdgeInsets.only(),
        margin: const EdgeInsets.only(bottom: 20),
        child: Stack(
          children: [
            Neumorphic(
              padding: const EdgeInsets.only(right: 10),
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              // decoration: BoxDecoration(
              //   color: secondary,
              //   borderRadius: BorderRadius.circular(20),
              // ),

              style: NeumorphicStyle(
                shape: NeumorphicShape.concave,
                surfaceIntensity: .1,
                color: secondary,
                // color: pink,
                shadowLightColor: secondaryLight,
                shadowDarkColor: secondaryDark,
                depth: 18,
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 170,
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              pet.name,
                              textScaleFactor: 1.5,
                              style: TextStyle(
                                color: black,
                              ),
                            ),
                            Icon(
                              pet.gender == "M" ? Icons.male : Icons.female,
                              color: Colors.black.withOpacity(.40),
                            ),
                          ],
                        ),
                        Text(
                          pet.breed + " - " + pet.type,
                          style: TextStyle(color: black),
                        ),
                        Text(
                          pet.age.toString() + " years old",
                          textScaleFactor: 0.8,
                          style: TextStyle(color: black),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: black,
                              size: 20,
                            ),
                            Text(
                              pet.city,
                              style: TextStyle(color: black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 10,
              top: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  pet.imgs[0],
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          "Meet Pet",
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
      body: Container(
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
                        filterOption(4, 'Birds', 'assets/images/bird.png'),
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
              // ),
              for (var pet in petList) ...[
                petCard(pet),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
