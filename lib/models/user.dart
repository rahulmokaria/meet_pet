// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

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
  List<String> favPetList;
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
  });

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
    List<String>? favPetList,
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
      'dob': dob.millisecondsSinceEpoch,
      'emailId': emailId,
      'contactNo': contactNo,
      'address': address.toMap(),
      'favPetList': favPetList,
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
      favPetList: List<String>.from(
        (map['favPetList'] as List<String>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(uid: $uid, userName: $userName, firstName: $firstName, lastName: $lastName, profileImg: $profileImg, backCoverImg: $backCoverImg, dob: $dob, emailId: $emailId, contactNo: $contactNo, address: $address, favPetList: $favPetList)';
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
        listEquals(other.favPetList, favPetList);
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
        favPetList.hashCode;
  }
}

class Address {
  String addLine1;
  String addLine2;
  String city;
  String state;
  String country;
  int zipCode;
  Address({
    required this.addLine1,
    required this.addLine2,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
  });

  Address copyWith({
    String? addLine1,
    String? addLine2,
    String? city,
    String? state,
    String? country,
    int? zipCode,
  }) {
    return Address(
      addLine1: addLine1 ?? this.addLine1,
      addLine2: addLine2 ?? this.addLine2,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      zipCode: zipCode ?? this.zipCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'addLine1': addLine1,
      'addLine2': addLine2,
      'city': city,
      'state': state,
      'country': country,
      'zipCode': zipCode,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      addLine1: map['addLine1'] as String,
      addLine2: map['addLine2'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      country: map['country'] as String,
      zipCode: map['zipCode'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Address(addLine1: $addLine1, addLine2: $addLine2, city: $city, state: $state, country: $country, zipCode: $zipCode)';
  }

  @override
  bool operator ==(covariant Address other) {
    if (identical(this, other)) return true;

    return other.addLine1 == addLine1 &&
        other.addLine2 == addLine2 &&
        other.city == city &&
        other.state == state &&
        other.country == country &&
        other.zipCode == zipCode;
  }

  @override
  int get hashCode {
    return addLine1.hashCode ^
        addLine2.hashCode ^
        city.hashCode ^
        state.hashCode ^
        country.hashCode ^
        zipCode.hashCode;
  }
}

User cUser = User(
  address: Address(
    addLine1: "P-131 Near Shivam Appt",
    addLine2: "RajivNagar",
    city: "Porbandar",
    state: "Gujarat",
    country: "India",
    zipCode: 360575,
  ),
  favPetList: [],
  backCoverImg: 'assets/images/cutebirt.jpg',
  contactNo: '8707022722',
  dob: DateTime.now(),
  emailId: 'rahulmokaria.rm@gmail.com',
  firstName: 'Rahul',
  lastName: 'Mokaria',
  profileImg: 'assets/images/owl.jpg',
  uid: 'dfsebzdhlgvuighaliSA7tg',
  userName: 'rahulMokaria',
);
