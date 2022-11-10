// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'address.dart';

class User {
  String uid;
  String userName;
  String firstName;
  String lastName;
  String profileImg;
  String backCoverImg;
  DateTime dob;
  String emailId;
  String contactNo;
  Address address;
  List<dynamic> favPetList;
  List<dynamic> petsForAdoption;
  List<dynamic> petsAdopted;
  User({
    required this.uid,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.profileImg,
    required this.backCoverImg,
    required this.dob,
    required this.emailId,
    required this.contactNo,
    required this.address,
    required this.favPetList,
    required this.petsForAdoption,
    required this.petsAdopted,
  });

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
        address: Address(
          addLine1: snapshot['address'],
          addLine2: snapshot['address'],
          city: snapshot['address'],
          state: snapshot['address'],
          country: snapshot['address'],
          zipCode: snapshot['address'],
        ),
        backCoverImg: snapshot['backCoverImg'],
        contactNo: snapshot['contactNo'],
        dob: snapshot['dob'],
        emailId: snapshot['emailId'],
        favPetList: snapshot['favPetList'],
        firstName: snapshot['firstName'],
        lastName: snapshot['lastName'],
        profileImg: snapshot['profileImg'],
        uid: snapshot['uid'],
        userName: snapshot['userName'],
        petsForAdoption: snapshot['petsForAdoption'],
        petsAdopted: snapshot['petsAdopted']);
  }

  User copyWith({
    String? uid,
    String? userName,
    String? firstName,
    String? lastName,
    String? profileImg,
    String? backCoverImg,
    DateTime? dob,
    String? emailId,
    String? contactNo,
    Address? address,
    List<dynamic>? favPetList,
    List<dynamic>? petsForAdoption,
    List<dynamic>? petsAdopted,
  }) {
    return User(
      uid: uid ?? this.uid,
      userName: userName ?? this.userName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profileImg: profileImg ?? this.profileImg,
      backCoverImg: backCoverImg ?? this.backCoverImg,
      dob: dob ?? this.dob,
      emailId: emailId ?? this.emailId,
      contactNo: contactNo ?? this.contactNo,
      address: address ?? this.address,
      favPetList: favPetList ?? this.favPetList,
      petsForAdoption: petsForAdoption ?? this.petsForAdoption,
      petsAdopted: petsAdopted ?? this.petsAdopted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'userName': userName,
      'firstName': firstName,
      'lastName': lastName,
      'profileImg': profileImg,
      'backCoverImg': backCoverImg,
      'dob': Timestamp.fromDate(dob),
      'emailId': emailId,
      'contactNo': contactNo,
      'address': address.toMap(),
      'favPetList': favPetList,
      'petsForAdoption': petsForAdoption,
      'petsAdopted': petsAdopted,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] as String,
      userName: map['userName'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      profileImg: map['profileImg'] as String,
      backCoverImg: map['backCoverImg'] as String,
      dob: DateTime.fromMillisecondsSinceEpoch(map['dob'] as int),
      emailId: map['emailId'] as String,
      contactNo: map['contactNo'] as String,
      address: Address.fromMap(map['address'] as Map<String, dynamic>),
      favPetList: List<dynamic>.from(map['favPetList'] as List<dynamic>),
      petsForAdoption:
          List<dynamic>.from(map['petsForAdoption'] as List<dynamic>),
      petsAdopted: List<dynamic>.from(map['petsAdopted'] as List<dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(uid: $uid, userName: $userName, firstName: $firstName, lastName: $lastName, profileImg: $profileImg, backCoverImg: $backCoverImg, dob: $dob, emailId: $emailId, contactNo: $contactNo, address: $address, favPetList: $favPetList, petsForAdoption: $petsForAdoption, petsAdopted: $petsAdopted)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.userName == userName &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.profileImg == profileImg &&
        other.backCoverImg == backCoverImg &&
        other.dob == dob &&
        other.emailId == emailId &&
        other.contactNo == contactNo &&
        other.address == address &&
        listEquals(other.favPetList, favPetList) &&
        listEquals(other.petsForAdoption, petsForAdoption) &&
        listEquals(other.petsAdopted, petsAdopted);
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        userName.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        profileImg.hashCode ^
        backCoverImg.hashCode ^
        dob.hashCode ^
        emailId.hashCode ^
        contactNo.hashCode ^
        address.hashCode ^
        favPetList.hashCode ^
        petsForAdoption.hashCode ^
        petsAdopted.hashCode;
  }
}

// User cUser = User(
//   address: Address(
//     addLine1: "P-131 Near Shivam Appt",
//     addLine2: "RajivNagar",
//     city: "Porbandar",
//     state: "Gujarat",
//     country: "India",
//     zipCode: 360575,
//   ),
//   favPetList: [],
//   backCoverImg: 'assets/images/cutebirt.jpg',
//   contactNo: '8707022722',
//   dob: DateTime.now(),
//   emailId: 'rahulmokaria.rm@gmail.com',
//   firstName: 'Rahul',
//   lastName: 'Mokaria',
//   profileImg: 'assets/images/owl.jpg',
//   uid: 'dfsebzdhlgvuighaliSA7tg',
//   userName: 'rahulMokaria',
// );

// User cUser = FirebaseAuth.instance.currentUser.to
// Future<User> getUserDetails() async {
//   DocumentSnapshot<Map<String, dynamic>> userSnap = await FirebaseFirestore
//       .instance
//       .collection("users")
//       .doc(FirebaseAuth.instance.currentUser!.uid)
//       .get();
//   User cUser = User(
//       // address: Address(addLine1: userSnap['address'][]),
//       a
//   return cUser;
// }
