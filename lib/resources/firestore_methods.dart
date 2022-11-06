import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meet_pet/models/address.dart';
import 'package:meet_pet/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

import '../models/pet.dart';
import '../models/user.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPet({
    required double age,
    required String breed,
    required String desc,
    required String gender,
    // required List<Uint8List> imgs,
    required List<String> imgs,
    required String name,
    required String oldOwner,
    required String oldOwnerUID,
    required String type,
    required DateTime datePosted,
    required String addLine1,
    required String addLine2,
    required String city,
    required String state,
    required String country,
    required int zipCode,
  }) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    try {
      List<String> photoUrls = [];
      // for (var petPhoto in imgs) {
      //   String photoUrl = await StorageMethods()
      //       .uploadImageToStorage(childName: 'pets', file: petPhoto);
      //   photoUrls.add(photoUrl);
      // }
      // print(photoUrls);
      String petId = const Uuid().v1(); // creates unique id based on time
      Pet pet = Pet(
        address: Address(
            addLine1: addLine1,
            addLine2: addLine2,
            city: city,
            state: state,
            country: country,
            zipCode: zipCode),
        age: age,
        breed: breed,
        datePosted: DateTime.now(),
        desc: desc,
        gender: gender,
        // imgs: photoUrls,
        imgs: imgs,
        name: name,
        oldOwner: oldOwner,
        oldOwnerUID: oldOwnerUID,
        petId: petId,
        type: type,
      );
      _firestore.collection('pets').doc(petId).set(pet.toMap());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> AddFavPet({
    required String petId,
    required User user,
  }) async {
    String res = "Some error occurred";
    try {
      user.favPetList.add(petId);
      _firestore.collection('pets').doc(user.uid).set(user.toMap());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
