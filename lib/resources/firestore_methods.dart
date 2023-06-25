import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meet_pet/models/address.dart';
import 'package:meet_pet/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

import '../models/pet.dart';
import '../models/request.dart';
import '../models/user.dart' as model;

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPet({
    required double age,
    required String breed,
    required String desc,
    required String gender,
    required List<XFile> imgs,
    // required List<String> imgs,
    required GeoPoint location,
    required String name,
    required String oldOwner,
    required String oldOwnerUID,
    required String type,
    required String city,
    required String state,
    required String country,
    required int zipCode,
  }) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    try {
      print(1);
      List<String> photoUrls = [];
      for (var petPhoto in imgs) {
        Uint8List photo = await petPhoto.readAsBytes();

        String photoUrl = await StorageMethods()
            .uploadImageToStorage(childName: 'pets', file: photo, isPet: true);

        photoUrls.add(photoUrl);
      }
      print(2);
      String petId = const Uuid().v1(); // creates unique id based on time

      Pet pet = Pet(
        address: Address(
            location: location,
            city: city,
            state: state,
            country: country,
            zipCode: zipCode),
        age: age,
        breed: breed,
        datePosted: DateTime.now(),
        desc: desc,
        gender: gender,
        imgs: photoUrls,
        name: name,
        oldOwner: oldOwner,
        oldOwnerUID: oldOwnerUID,
        petId: petId,
        type: type,
      );

      var uploadPetData = pet.toMap();
      print(3);
      print(uploadPetData);
      await _firestore
          .collection('petsForAdoption')
          .doc(petId)
          .set(uploadPetData);
      print(4);
      await _firestore.collection('users').doc(oldOwnerUID).update({
        'petsForAdoption': FieldValue.arrayUnion([petId])
      });
      print(5);
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    print(6);
    return res;
  }

  Future<String> AddFavPet({
    required String petId,
    required model.User user,
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

  Future<model.User> getUserDetails({String? userId}) async {
    var userSnap = (userId == null)
        ? await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
        : await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();
    var userData = {};
    userData = userSnap.data()!;

    model.User cUser = model.User(
      address: Address(
        location: userData['address']['location'],
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
      petsForAdoption: userData['petsForAdoption'],
      // petsForAdoption: [],
      petsAdopted: userData['petsAdopted'],
      // petsAdopted: [],
    );
    return cUser;
  }

  Future<List<Pet>> getPetList(String currentUserUid) async {
    var petListdb = [];
    List<Pet> petList = [];
    QuerySnapshot<Map<String, dynamic>> petSnap =
        await FirebaseFirestore.instance
            .collection('petsForAdoption') //add the below comment
            .where("oldOwnerUID", isNotEqualTo: currentUserUid)
            .get();
    petListdb = petSnap.docs;
    for (var pet in petListdb) {
      var curPet = Pet(
        address: Address(
          location: pet["address"]['location'],
          city: pet["address"]["city"],
          state: pet["address"]["state"],
          country: pet["address"]["country"],
          zipCode: pet["address"]["zipCode"],
        ),
        age: (pet["age"] * 1.0), //problem
        breed: pet["breed"],
        datePosted: pet["datePosted"].toDate(), //problem
        desc: pet["desc"],
        gender: pet["gender"],
        imgs: pet["imgs"], // problem
        name: pet["name"],
        oldOwner: pet["oldOwner"],
        oldOwnerUID: pet["oldOwnerUID"],
        petId: pet["petId"],
        type: pet["type"],
      );
      // print(curPet);
      petList.add(curPet);
    }
    // print(petList);
    return petList;
  }

  Future<Pet> getPet(String petId) async {
    DocumentSnapshot<Map<String, dynamic>> petSnap = await FirebaseFirestore
        .instance
        .collection('petsForAdoption')
        .doc(petId)
        .get();

    if (petSnap.data() == null) {
      petSnap = await FirebaseFirestore.instance
          .collection('petsAdopted')
          .doc(petId)
          .get();
    }
    Map<String, dynamic> pet = petSnap.data()!;

    Pet curPet = Pet(
      age: (pet["age"] * 1.0),
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
        location: pet['address']['location'],
        city: pet["address"]["city"],
        state: pet["address"]["state"],
        country: pet["address"]["country"],
        zipCode: pet["address"]["zipCode"],
      ),
    );

    return curPet;
  }

  Future<List<Pet>> getCustomPetList(
      String petListType, List<dynamic> petIdList) async {
    List<Pet> petList = [];
    for (var p in petIdList) {
      DocumentSnapshot<Map<String, dynamic>> petSnap =
          await FirebaseFirestore.instance.collection(petListType).doc(p).get();

      if (petSnap.data() == null) {
        petSnap = await FirebaseFirestore.instance
            .collection('petsAdopted')
            .doc(p)
            .get();
      }

      Map<String, dynamic> pet = petSnap.data()!;
      Pet curPet = Pet(
        age: (pet["age"] * 1.0),
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
          location: pet['address']['location'],
          city: pet["address"]["city"],
          state: pet["address"]["state"],
          country: pet["address"]["country"],
          zipCode: pet["address"]["zipCode"],
        ),
      );
      petList.add(curPet);
    }
    // print(petList);
    return petList;
  }

//query for user uploaded pets
// Future<List<Pet>> getPetList()async{
//       var petForAdoptionSnap = await FirebaseFirestore.instance
//           .collection('petsforAdoption')
//           .where('oldOwnerUID',
//               isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//           .get();

  Future<String> changeFavList(
      model.User cUser, String petId, bool isFavPet) async {
    String res = "Some error occured, please try again";
    cUser.favPetList.remove(petId);

    if (isFavPet) {
      cUser.favPetList.remove(petId);
      FirebaseFirestore.instance
          .collection("users")
          .doc(cUser.uid)
          .set(cUser.toMap());
      res = "success";
    } else {
      cUser.favPetList.add(petId);
      FirebaseFirestore.instance
          .collection("users")
          .doc(cUser.uid)
          .set(cUser.toMap());
      res = "success";
    }
    return res;
  }

  Future<String> sendAdoptionRequest(Pet pet, model.User sender) async {
    String res = "Some error occurred, please try again.";
    try {
      String requestId = const Uuid().v1();
      Request request = Request(
        ownerName: pet.oldOwner,
        ownerUid: pet.oldOwnerUID,
        petId: pet.petId,
        petName: pet.name,
        requestId: requestId,
        senderName: sender.firstName + " " + sender.lastName,
        senderUid: sender.uid,
        status: "Pending",
      );

      var uploadRequest = request.toMap();

      await _firestore.collection('requests').doc(requestId).set(uploadRequest);
      res = "success";
      print(res);
    } catch (e) {
      print(e);
    }
    return res;
  }

  Future<List<Request>> getSentRequests(String userId) async {
    List<Request> sentRequests = [];

    var sentdb = [];
    QuerySnapshot<Map<String, dynamic>> requestSnap = await _firestore
        .collection("requests")
        .where("senderUid", isEqualTo: userId)
        .get();

    sentdb = requestSnap.docs;
    for (var r in sentdb) {
      var req = Request(
        ownerName: r['ownerName'],
        ownerUid: r['ownerUid'],
        petId: r['petId'],
        petName: r['petName'],
        requestId: r['requestId'],
        senderName: r['senderName'],
        senderUid: r['senderUid'],
        status: r['status'],
      );
      sentRequests.add(req);
    }
    return sentRequests;
  }

  Future<List<Request>> getReceivedRequests(String userId) async {
    List<Request> rRequests = [];
    var requestdb = [];
    QuerySnapshot<Map<String, dynamic>> requestSnap = await _firestore
        .collection("requests")
        .where("ownerUid", isEqualTo: userId)
        .get();

    requestdb = requestSnap.docs;
    for (var r in requestdb) {
      var req = Request(
        ownerName: r['ownerName'],
        ownerUid: r['ownerUid'],
        petId: r['petId'],
        petName: r['petName'],
        requestId: r['requestId'],
        senderName: r['senderName'],
        senderUid: r['senderUid'],
        status: r['status'],
      );
      rRequests.add(req);
    }
    return rRequests;
  }

  Future<String> cancelRequestFromSender(Request request) async {
    String res = "Some error occured. Try again later.";

    try {
      await _firestore.collection('requests').doc(request.requestId).delete();
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    print(6);

    return res;
  }

  Future<String> cancelRequestByOwner(Request request) async {
    String res = "Some error occurred";
    try {
      request.status = "Rejected";
      await _firestore
          .collection('requests')
          .doc(request.requestId)
          .set(request.toMap());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> confirmRequest(Request request) async {
    String res = "Some error occurred";
    try {
      request.status = "Accepted";
      await _firestore
          .collection('requests')
          .doc(request.requestId)
          .set(request.toMap());

      Pet pet = await getPet(request.petId);

      await _firestore.collection("petsForAdoption").doc(pet.petId).delete();

      await _firestore
          .collection('petsAdopted')
          .doc(pet.petId)
          .set(pet.toMap());

      model.User sender = await getUserDetails(userId: request.senderUid);
      sender.petsAdopted.add(pet.petId);
      await _firestore.collection("users").doc(sender.uid).set(sender.toMap());

      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
