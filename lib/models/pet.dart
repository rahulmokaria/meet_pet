// ignore_for_file: public_member_api_docs, sort_constructors_first
class Pet {
  double age;
  String breed;
  String city;
  String desc;
  String gender;
  List<String> imgs;
  String name;
  String oldOwner;
  String oldOwnerUID;
  String petId;
  String type;
  DateTime datePosted;
  Pet({
    required this.age,
    required this.breed,
    required this.city,
    required this.desc,
    required this.gender,
    required this.imgs,
    required this.name,
    required this.oldOwner,
    required this.oldOwnerUID,
    required this.petId,
    required this.type,
    required this.datePosted,
  });

  Map<String, dynamic> toJson() => {
        "age": age,
        "breed": breed,
        "city": city,
        "desc": desc,
        "gender": gender,
        "imgs": imgs,
        "name": name,
        "petId": petId,
        "type": type,
      };
}

List<Pet> petList = [
  Pet(
    age: 2.0,
    breed: 'Labrador',
    city: 'Porbandar',
    desc:
        "Everything is so expensive.Going to a bar is a fun thing to do.Here's my big brother. Doesn't he look good?",
    gender: 'M',
    imgs: [
      "assets/images/dumbdog.jpg",
    ],
    name: 'Duggu',
    petId: '',
    type: 'dog',
    oldOwner: 'Rahul Mokaria',
    oldOwnerUID: '',
    datePosted: DateTime.now(),
  ),
  Pet(
    age: 1,
    breed: 'Ginger',
    city: 'Allahabad',
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
  ),
  Pet(
    age: 1.5,
    breed: 'Parrot',
    city: 'Mumbai',
    desc:
        "It's not a big room, but it's beautiful.I don't know where the list of my friends went.I am filthy rich.",
    gender: 'F',
    imgs: [
      "assets/images/cutebirt.jpg",
    ],
    name: 'Mithoo',
    petId: '',
    type: 'bird',
    oldOwner: 'Rahul Mokaria',
    oldOwnerUID: '',
    datePosted: DateTime.now(),
  ),
  Pet(
    age: 4,
    breed: 'Pug',
    city: 'Allahabad',
    desc:
        "It's not a big room, but it's beautiful.I don't know where the list of my friends went.I am filthy rich.",
    gender: 'M',
    imgs: [
      "assets/images/dumbdog.jpg",
    ],
    name: 'Lucy',
    petId: '',
    type: 'dog',
    oldOwner: 'Rahul Mokaria',
    oldOwnerUID: '',
    datePosted: DateTime.now(),
  ),
  Pet(
    age: 2.0,
    breed: 'Ginger',
    city: 'Allahabad',
    desc:
        "It's not a big room, but it's beautiful.I don't know where the list of my friends went.I am filthy rich.",
    gender: 'F',
    imgs: [
      "assets/images/catbee.jpg",
    ],
    name: 'Pussy Cat',
    petId: '',
    type: 'cat',
    oldOwner: 'Rahul Mokaria',
    oldOwnerUID: '',
    datePosted: DateTime.now(),
  ),
];
