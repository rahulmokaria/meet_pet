// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/user.dart';
import '../utils/colors.dart';
import 'home_page.dart';

class FavoritePetScreen extends StatefulWidget {
  final User cUser;
  const FavoritePetScreen({
    Key? key,
    required this.cUser,
  }) : super(key: key);

  @override
  State<FavoritePetScreen> createState() => _FavoritePetScreenState();
}

class _FavoritePetScreenState extends State<FavoritePetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          "Favorite Pets",
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
    );
  }
}
