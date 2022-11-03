import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'user.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Pet {
  double age;
  String breed;
  String desc;
  String gender;
  List<String> imgs;
  String name;
  String oldOwner;
  String oldOwnerUID;
  String petId;
  String type;
  DateTime datePosted;
  Address address;
  Pet({
    required this.age,
    required this.breed,
    required this.desc,
    required this.gender,
    required this.imgs,
    required this.name,
    required this.oldOwner,
    required this.oldOwnerUID,
    required this.petId,
    required this.type,
    required this.datePosted,
    required this.address,
  });

  Pet copyWith({
    double? age,
    String? breed,
    String? desc,
    String? gender,
    List<String>? imgs,
    String? name,
    String? oldOwner,
    String? oldOwnerUID,
    String? petId,
    String? type,
    DateTime? datePosted,
    Address? address,
  }) {
    return Pet(
      age: age ?? this.age,
      breed: breed ?? this.breed,
      desc: desc ?? this.desc,
      gender: gender ?? this.gender,
      imgs: imgs ?? this.imgs,
      name: name ?? this.name,
      oldOwner: oldOwner ?? this.oldOwner,
      oldOwnerUID: oldOwnerUID ?? this.oldOwnerUID,
      petId: petId ?? this.petId,
      type: type ?? this.type,
      datePosted: datePosted ?? this.datePosted,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'age': age,
      'breed': breed,
      'desc': desc,
      'gender': gender,
      'imgs': imgs,
      'name': name,
      'oldOwner': oldOwner,
      'oldOwnerUID': oldOwnerUID,
      'petId': petId,
      'type': type,
      'datePosted': datePosted.millisecondsSinceEpoch,
      'address': address.toMap(),
    };
  }

  factory Pet.fromMap(Map<String, dynamic> map) {
    return Pet(
      age: map['age'] as double,
      breed: map['breed'] as String,
      desc: map['desc'] as String,
      gender: map['gender'] as String,
      name: map['name'] as String,
      oldOwner: map['oldOwner'] as String,
      oldOwnerUID: map['oldOwnerUID'] as String,
      petId: map['petId'] as String,
      type: map['type'] as String,
      datePosted: DateTime.fromMillisecondsSinceEpoch(map['datePosted'] as int),
      address: Address.fromMap(map['address'] as Map<String, dynamic>),
      imgs: List<String>.from((map['imgs'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Pet.fromJson(String source) =>
      Pet.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Pet(age: $age, breed: $breed, desc: $desc, gender: $gender, imgs: $imgs, name: $name, oldOwner: $oldOwner, oldOwnerUID: $oldOwnerUID, petId: $petId, type: $type, datePosted: $datePosted, address: $address)';
  }

  @override
  bool operator ==(covariant Pet other) {
    if (identical(this, other)) return true;

    return other.age == age &&
        other.breed == breed &&
        other.desc == desc &&
        other.gender == gender &&
        listEquals(other.imgs, imgs) &&
        other.name == name &&
        other.oldOwner == oldOwner &&
        other.oldOwnerUID == oldOwnerUID &&
        other.petId == petId &&
        other.type == type &&
        other.datePosted == datePosted &&
        other.address == address;
  }

  @override
  int get hashCode {
    return age.hashCode ^
        breed.hashCode ^
        desc.hashCode ^
        gender.hashCode ^
        imgs.hashCode ^
        name.hashCode ^
        oldOwner.hashCode ^
        oldOwnerUID.hashCode ^
        petId.hashCode ^
        type.hashCode ^
        datePosted.hashCode ^
        address.hashCode;
  }
}

List<Pet> petList = [
  Pet(
    age: 2.0,
    breed: 'Labrador',
    desc:
        "Everything is so expensive.Going to a bar is a fun thing to do.Here's my big brother. Doesn't he look good?",
    gender: 'M',
    imgs: [
      "assets/images/dumbdog.jpg",
    ],
    name: 'Duggu',
    petId: '',
    type: 'dog',
    oldOwner: 'Rahul Mokara',
    oldOwnerUID: '',
    datePosted: DateTime.now(),
    address: Address(
      addLine1: "P-131 Near Shivam Appt",
      addLine2: "RajivNagar",
      city: "Porbandar",
      state: "Gujarat",
      country: "India",
      zipCode: 360575,
    ),
  ),
  Pet(
    age: 1,
    breed: 'Ginger',
    desc:
        "It's not a big room, but it's beautiful.I don't know where the list of my friends went.I am filthy rich.",
    gender: 'F',
    imgs: [
      "assets/images/catbee.jpg",
      "assets/images/dumbdog.jpg",
      "assets/images/cutebirt.jpg",
    ],
    name: 'Pussy Cat',
    petId: '',
    type: 'cat',
    oldOwner: 'Rahul Mokaria',
    oldOwnerUID: '',
    datePosted: DateTime.now(),
    address: Address(
      addLine1: "P-131 Near Shivam Appt",
      addLine2: "RajivNagar",
      city: "Porbandar",
      state: "Gujarat",
      country: "India",
      zipCode: 360575,
    ),
  ),
  Pet(
    age: 1.5,
    breed: 'Parrot',
    desc:
        "It's not a big room, but it's beautiful.I don't know where the list of my friends went.I am filthy rich.",
    gender: 'F',
    imgs: [
      "assets/images/cutebirt.jpg",
    ],
    name: 'Mithoo',
    petId: '',
    type: 'bird',
    oldOwner: 'Rahul Moaria',
    oldOwnerUID: '',
    datePosted: DateTime.now(),
    address: Address(
      addLine1: "P-131 Near Shivam Appt",
      addLine2: "RajivNagar",
      city: "Porbandar",
      state: "Gujarat",
      country: "India",
      zipCode: 360575,
    ),
  ),
  Pet(
    age: 4,
    breed: 'Pug',
    desc:
        "It's not a big room, but it's beautiful.I don't know where the list of my friends went.I am filthy rich.",
    gender: 'M',
    imgs: [
      "assets/images/dumbdog.jpg",
    ],
    name: 'Lucy',
    petId: '',
    type: 'dog',
    oldOwner: 'Rhul Mokaria',
    oldOwnerUID: '',
    datePosted: DateTime.now(),
    address: Address(
      addLine1: "P-131 Near Shivam Appt",
      addLine2: "RajivNagar",
      city: "Porbandar",
      state: "Gujarat",
      country: "India",
      zipCode: 360575,
    ),
  ),
  Pet(
    age: 2.0,
    breed: 'Ginger',
    desc:
        "It's not a big room, but it's beautiful.I don't know where the list of my friends went.I am filthy rich.",
    gender: 'F',
    imgs: [
      "assets/images/catbee.jpg",
    ],
    name: 'Pussy Cat',
    petId: '',
    type: 'cat',
    oldOwner: 'Rahul Moaria',
    oldOwnerUID: '',
    datePosted: DateTime.now(),
    address: Address(
      addLine1: "P-131 Near Shivam Appt",
      addLine2: "RajivNagar",
      city: "Porbandar",
      state: "Gujarat",
      country: "India",
      zipCode: 360575,
    ),
  ),
];
