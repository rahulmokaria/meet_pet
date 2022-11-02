import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:meet_pet/screens/favorite_pets.dart';

import '../models/pet.dart';
import '../utils/colors.dart';
import '../widgets/menu_screen.dart';
import 'add_pet.dart';
import 'adopt_pet_screen.dart';
import 'all_chats.dart';
import 'user_profile.dart';

int menuItemSelected = 1;
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
      // mainScreen: const Body(),
      mainScreen: currentScreen(),
      menuScreen: MenuScreen(
        setIndex: (index) {
          setState(() {
            menuItemSelected = index;
          });
        },
      ),

      controller: zoomDrawerController,
      borderRadius: 24,
      style: DrawerStyle.defaultStyle,
      showShadow: true,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.fastOutSlowIn,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
      duration: const Duration(milliseconds: 500),
      angle: 0.0,
      menuBackgroundColor: primary,
    );
  }
}

Widget currentScreen() {
  if (menuItemSelected == 1) {
    return const AdoptPetScreen();
  } else if (menuItemSelected == 2) {
    return const AddPet();
  } else if (menuItemSelected == 3) {
    // return const FavoriteScreen();
    return const FavoritePetScreen();
  } else if (menuItemSelected == 4) {
    return const AllChats();
  } else if (menuItemSelected == 5) {
    return const UserProfile();
  }
  return const AdoptPetScreen();
}


// class Body extends StatefulWidget {
//   const Body({Key? key}) : super(key: key);

//   @override
//   State<Body> createState() => _BodyState();
// }

// class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
//   late AnimationController controller = AnimationController(
//     vsync: this,
//     duration: const Duration(milliseconds: 100),
//     value: -1.0,
//   );

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   bool get isPanelVisible {
//     final AnimationStatus status = controller.status;
//     return status == AnimationStatus.completed ||
//         status == AnimationStatus.forward;
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (menuItemSelected == 1) {
//       return const AdoptPetScreen();
//     } else if (menuItemSelected == 2) {
//       return const AddPet();
//     } else if (menuItemSelected == 3) {
//       // return const FavoriteScreen();
//       return Text("Favorite");
//     } else if (menuItemSelected == 4) {
//       return AllChats();
//     } else if (menuItemSelected == 5) {
//       return UserProfile();
//     }
//     return Container();
//   }
// }
