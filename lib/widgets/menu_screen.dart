import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/colors.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _menuItemSelected = 1;
  Widget menuOption(int index, IconData icon, String optionName) {
    return InkWell(
      onTap: () {
        setState(() {
          _menuItemSelected = index;
        });
      },
      child: Row(
        children: [
          Icon(
            icon,
            size: (_menuItemSelected == index) ? 20 : 15,
            color: white.withOpacity(_menuItemSelected == index ? 1 : 0.7),
          ),
          const SizedBox(width: 10),
          Text(
            optionName,
            textScaleFactor: _menuItemSelected == index ? 1.2 : 1,
            style: TextStyle(
              color: white.withOpacity(_menuItemSelected == index ? 1 : 0.7),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Container(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset(
                    'assets/images/owl.jpg',
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                const Expanded(
                  child: Text(
                    'Rahul Mokaria',
                    textScaleFactor: 1.5,
                    style: TextStyle(
                      color: white,
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
              flex: 1,
              child: Container(),
            ),
            menuOption(1, FontAwesomeIcons.paw, "Adoption"),
            const SizedBox(
              height: 20,
            ),
            menuOption(2, Icons.add, "Add Pet"),
            const SizedBox(
              height: 20,
            ),
            menuOption(3, Icons.favorite, "Favorites"),
            const SizedBox(
              height: 20,
            ),
            menuOption(4, Icons.chat, "Chats"),
            const SizedBox(
              height: 20,
            ),
            menuOption(5, Icons.person, "Profile"),
            Flexible(
              flex: 1,
              child: Container(),
            ),
            InkWell(
              child: Row(
                children: [
                  Text(
                    'Sign Out',
                    textScaleFactor: 1.2,
                    style: TextStyle(color: white.withOpacity(0.70)),
                    // style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right_sharp,
                    color: white.withOpacity(0.7),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> petList = [
  {
    "index": 0,
    "img": "assets/images/dumbdog.jpg",
    "name": "Duggu",
    "type": "dog",
    "breed": "Labrador",
    "age": 2.0,
    "city": "Porbandar",
    "gender": "M,"
  },
  {
    "index": 1,
    "img": "assets/images/catbee.jpg",
    "name": "Pussy Cat",
    "type": "cat",
    "breed": "Ginger",
    "age": 1.5,
    "city": "Allahabad",
    "gender": "F"
  },
  {
    "index": 2,
    "img": "assets/images/cutebirt.jpg",
    "name": "Mithoo",
    "type": "bird",
    "breed": "Parrot",
    "age": 1.5,
    "city": "Mumbai",
    "gender": "F"
  },
  {
    "index": 3,
    "img": "assets/images/dumbdog.jpg",
    "name": "Lucy",
    "type": "dog",
    "breed": "Pug",
    "age": 5,
    "city": "Allahabad",
    "gender": "F"
  },
  {
    "index": 4,
    "img": "assets/images/catbee.jpg",
    "name": "Pussy Cat",
    "type": "cat",
    "breed": "Ginger",
    "age": 1.5,
    "city": "Allahabad",
    "gender": "F"
  }
];
