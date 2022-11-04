import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import 'storage_methods.dart';
import '../models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String userName,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required DateTime dob,
    required String contactNumber,
    required String addLine1,
    required String addLine2,
    required String city,
    required String state,
    required String country,
    required int zipCode,
    required Uint8List profilePicFile,
    required Uint8List backCoverPicFile,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          userName.isNotEmpty &&
          firstName.isNotEmpty &&
          lastName.isNotEmpty &&
          dob != DateTime.now() &&
          (int.parse(contactNumber) > 1000000000 &&
              int.parse(contactNumber) <= 9999999999) &&
          addLine1.isNotEmpty &&
          addLine2.isNotEmpty &&
          city.isNotEmpty &&
          state.isNotEmpty &&
          country.isNotEmpty &&
          (zipCode >= 100000 && zipCode <= 999999)) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String profilePicUrl = await StorageMethods().uploadImageToStorage(
            childName: "ProfilePics", file: profilePicFile);
        String backCoverPicUrl = await StorageMethods().uploadImageToStorage(
            childName: "BackCoverPics", file: backCoverPicFile);

        model.User user = model.User(
          userName: userName,
          firstName: firstName,
          lastName: lastName,
          dob: dob,
          emailId: email,
          contactNo: contactNumber.toString(),
          uid: cred.user!.uid,
          profileImg: profilePicUrl,
          backCoverImg: backCoverPicUrl,
          address: model.Address(
            addLine1: addLine1,
            addLine2: addLine2,
            city: city,
            state: state,
            country: country,
            zipCode: zipCode,
          ),
          favPetList: [],
        );

        print(user);

        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toMap());
        res = "success";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
