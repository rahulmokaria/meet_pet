import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:meet_pet/models/address.dart';
import 'package:meet_pet/screens/favorite_pets.dart';
import 'package:provider/provider.dart';

import '../models/pet.dart';
import '../models/user.dart' as model;
import '../providers/user_provider.dart';
import '../resources/auth_methods.dart';
import '../utils/colors.dart';
import '../widgets/menu_screen.dart';
import 'add_pet.dart';
import 'adopt_pet_screen.dart';
import 'all_chats.dart';
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

  bool _isLoading = true;
  var userData = {};
  var petListdb = [];
  List<Pet> petList = [];
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    // UserProvider _userProvider =
    //     Provider.of<UserProvider>(context, listen: false);
    // await _userProvider.refreshUser();
    getData();
  }

  getData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      // get post lENGTH
      var petForAdoptionSnap = await FirebaseFirestore.instance
          .collection('pets')
          .where('oldOwnerUID',
              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      userData = userSnap.data()!;

      QuerySnapshot<Map<String, dynamic>> petSnap =
          await FirebaseFirestore.instance.collection('pets').get();
      petListdb = petSnap.docs;

      for (var pet in petListdb) {
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

  Widget currentScreen(model.User cUser, List<Pet> petList) {
    if (menuItemSelected == 1) {
      return AdoptPetScreen(
        cUser: cUser,
        petList: petList,
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
      return AllChats(
        cUser: cUser,
      );
    } else if (menuItemSelected == 5) {
      return UserProfile(
        cUser: cUser,
      );
    }
    return AdoptPetScreen(
      cUser: cUser,
      petList: petList,
    );
  }

  @override
  Widget build(BuildContext context) {
    model.User cUser = model.User(
      address: Address(
        addLine1: userData['address']['addLine1'], //works
        addLine2: userData['address']['addLine2'], //works
        city: userData['address']['city'], //works
        country: userData['address']['country'], //works
        state: userData['address']['state'], //works
        zipCode: userData['address']['zipCode'],
      ),
      contactNo: userData['contactNo'],
      userName: userData['userName'],
      uid: userData['uid'],
      firstName: userData['firstName'],
      lastName: userData['lastName'],
      dob: userData['dob'].toDate(),
      emailId: userData['emailId'],
      profileImg: userData['profileImg'],
      backCoverImg: userData['backCoverImg'],
      favPetList: userData['favPetList'],
      // petsForAdoption: userData['petsForAdoption'],
      petsForAdoption: [],
      petsAdopted: userData['petsAdopted'],
      // petsAdopted: [],
    );
    setState(() {
      _isLoading = false;
    });
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: white,
            ),
          )
        : ZoomDrawer(
            // mainScreen: const Body(),
            mainScreen: currentScreen(cUser, petList),
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
