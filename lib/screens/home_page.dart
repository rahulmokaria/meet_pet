import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meet_pet/models/address.dart';
import 'package:meet_pet/resources/firestore_methods.dart';
import 'package:meet_pet/screens/chat/chat_screen.dart';
import 'package:meet_pet/screens/favorite_pets.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';

import '../models/pet.dart';
import '../models/user.dart' as model;
import '../providers/user_provider.dart';
import '../resources/auth_methods.dart';
import '../utils/colors.dart';
import '../widgets/menu_screen.dart';
import '../widgets/show_snackbar.dart';
import 'add_pet.dart';
import 'adopt_pet_screen.dart';
import 'chat/all_chats.dart';
import 'notification_page.dart';
import 'user_profile.dart';

int menuItemSelected = 1;
final ZoomDrawerController zoomDrawerController = ZoomDrawerController();
// User cUser = AuthMethods.getUserDetails() as User;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _menuItemSelected = 1;
  GeoPoint currLocation = GeoPoint(0, 0);
  bool _isLoading = true;
  // var userData = {};
  // var petListdb = [];
  late model.User cUser;
  // List<Pet> petList = [];
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
      cUser = await FireStoreMethods().getUserDetails();
      // print(cUser);
    } catch (e) {
      //  ScaffoldMessenger.of(context).showSnackBar(showCustomSnackBar(
      //   ctype: ContentType.failure,
      //   message: e.toString() + "Please contact admin to resolve",
      // ));
    }
    setState(() {
      _isLoading = false;
    });
  }

  // getData() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   try {
  //     var userSnap = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .get();
  //     // get post lENGTH
  //     var petForAdoptionSnap = await FirebaseFirestore.instance
  //         .collection('petsForAdoption')
  //         .where('oldOwnerUID',
  //             isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //         .get();

  //     userData = userSnap.data()!;

  //     QuerySnapshot<Map<String, dynamic>> petSnap =
  //         await FirebaseFirestore.instance.collection('petsforAdoption').get();
  //     petListdb = petSnap.docs;
  //     print("${petListdb.length} fox");
  //     for (var pet in petListdb) {
  //       var curPet = Pet(
  //         age: pet["age"],
  //         breed: pet["breed"],
  //         desc: pet["desc"],
  //         gender: pet["gender"],
  //         imgs: pet["imgs"], // problem
  //         name: pet["name"],
  //         oldOwner: pet["oldOwner"],
  //         oldOwnerUID: pet["oldOwnerUID"],
  //         petId: pet["petId"],
  //         type: pet["type"],
  //         datePosted: pet["datePosted"].toDate(), //problem
  //         address: Address(
  //           location: pet["address"]['location'],
  //           city: pet["address"]["city"],
  //           state: pet["address"]["state"],
  //           country: pet["address"]["country"],
  //           zipCode: pet["address"]["zipCode"],
  //         ),
  //       );

  //       petList.add(curPet);
  //     }
  //     print("${petListdb.length} fox");
  //   } catch (e) {
  //     // ScaffoldMessenger.of(context).showSnackBar(
  //     //   showCustomSnackBar(
  //     //     ctype: ContentType.failure,
  //     //     message: e.toString(),
  //     //   ),
  //     // );
  //   }
  //   setState(() {
  //     _isLoading = false;
  //   });
  //   // print(userData);
  // }

  getLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    setState(() async {
      currLocation = (await Geolocator.getCurrentPosition()) as GeoPoint;
    });
  }

  //  getLocation() async {
  //   Position curr = await Geolocator.getCurrentPosition();
  //   return curr;
  // }

  Widget currentScreen(model.User cUser) {
    if (menuItemSelected == 1) {
      return AdoptPetScreen(
        cUser: cUser,
      );
    } else if (menuItemSelected == 2) {
      return AddPet(
        cUser: cUser,
        setIndex: (index) {
          setState(() {
            menuItemSelected = index;
          });
        },
      );
    } else if (menuItemSelected == 3) {
      // return const FavoriteScreen();
      return FavoritePetScreen(
        cUser: cUser,
        listType: 'Favorite Pets',
      );
    } else if (menuItemSelected == 4) {
      return NotificationPage(
          cUser: cUser,
          );
    } else if (menuItemSelected == 5) {
      return AllChats(
        cUser: cUser,
      );
    } else if (menuItemSelected == 6) {
      return UserProfile(
        cUser: cUser,
      );
    }
    return AdoptPetScreen(
      cUser: cUser,
    );
  }

  @override
  Widget build(BuildContext context) {
    // getLocation();
    // model.User cUser = model.User(
    //   address: Address(
    //     location: userData['address']['location'],
    //     city: userData['address']['city'], //works
    //     country: userData['address']['country'], //works
    //     state: userData['address']['state'], //works
    //     zipCode: userData['address']['zipCode'],
    //   ),
    //   contactNo: userData['contactNo'],
    //   userName: userData['userName'],
    //   uid: userData['uid'],
    //   firstName: userData['firstName'],
    //   lastName: userData['lastName'],

    //   dob: userData['dob'].toDate(),
    //   emailId: userData['emailId'],
    //   profileImg: userData['profileImg'],
    //   backCoverImg: userData['backCoverImg'],
    //   favPetList: userData['favPetList'],
    //   // petsForAdoption: userData['petsForAdoption'],
    //   petsForAdoption: [],
    //   petsAdopted: userData['petsAdopted'],
    //   // petsAdopted: [],
    // );

    // for (var pet in petList) {
    //   pet.distance = findDistance(currLocation.latitude, currLocation.longitude,
    //       pet.address.location.latitude, pet.address.location.longitude);
    //   // pet.distance = findDistance(
    //   //     cUser.address.location.latitude,
    //   //     cUser.address.location.longitude,
    //   //     pet.address.location.latitude,
    //   //     pet.address.location.longitude);
    // }
    // petList.sort((p1, p2) => p1.distance.compareTo(p2.distance));

    // setState(() {
    //   _isLoading = false;
    // });
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: white,
            ),
          )
        : ZoomDrawer(
            // mainScreen: const Body(),
            mainScreen: currentScreen(cUser),
            menuScreen: MenuScreen(
              cUser: cUser,
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
