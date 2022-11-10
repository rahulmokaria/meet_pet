// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../models/user.dart' as model;
import '../screens/login_page.dart';
import '../screens/home_page.dart';
import '../utils/colors.dart';

class MenuScreen extends StatefulWidget {
  final model.User cUser;
  final ValueSetter setIndex;
  const MenuScreen({
    Key? key,
    required this.cUser,
    required this.setIndex,
  }) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  signOutUser() {
    FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const LoginPage()));
  }

  // int _menuItemSelected = 1;
  Widget menuOption(int index, IconData icon, String optionName) {
    return GestureDetector(
      onTap: () {
        widget.setIndex(index);
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          children: [
            Icon(
              icon,
              size: (menuItemSelected == index) ? 20 : 15,
              color: white.withOpacity(menuItemSelected == index ? 1 : 0.7),
            ),
            const SizedBox(width: 10),
            Text(
              optionName,
              textScaleFactor: menuItemSelected == index ? 1.2 : 1,
              style: TextStyle(
                color: white.withOpacity(menuItemSelected == index ? 1 : 0.7),
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
                  child: Image.network(
                    widget.cUser.profileImg,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    "${widget.cUser.firstName} ${widget.cUser.lastName}",
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
            menuOption(2, Icons.add, "Add Pet"),
            menuOption(3, Icons.favorite, "Favorites"),
            menuOption(4, Icons.notifications, "Notifications"),
            menuOption(5, Icons.person, "Profile"),
            Flexible(
              flex: 1,
              child: Container(),
            ),
            InkWell(
              onTap: () => signOutUser(),
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
