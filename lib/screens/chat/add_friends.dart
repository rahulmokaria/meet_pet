import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meet_pet/models/chatroom.dart';
import 'package:meet_pet/models/user.dart';
import 'package:meet_pet/resources/chat_methods.dart';

import '../../utils/colors.dart';

class AddFriends extends StatelessWidget {
  User cUser;

  List<String> friends;
  AddFriends({super.key, required this.cUser, required this.friends});
  ChatMethods _chatMethods = ChatMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Friends")),
      body: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var docs = snapshot.data?.docs;
              return ListView.builder(
                itemBuilder: (context, index) {
                  var x = true;
                  var user = docs[index].data();
                  return ListTile(
                    title: Text("${user['firstName']}"),
                    trailing: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.plus,
                        color: black,
                      ),
                      onPressed: () {
                        if (x) {
                          x = false;
                          _chatMethods.sendFriendRequest(cUser.uid, user['uid']);
                        }
                      },
                    ),
                  );
                },
                itemCount: docs!.length,
              );
            } else
              return Container();
          },
          future: FirebaseFirestore.instance
              .collection('users')
              .where("uid", whereNotIn: friends)
              .get()),
    );
  }
}
