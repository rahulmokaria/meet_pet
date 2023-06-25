// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/user.dart';
import 'package:meet_pet/models/chatroom.dart';
import '../../utils/colors.dart';
import 'chat_screen.dart';
import '../home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meet_pet/resources/chat_methods.dart';

import 'add_friends.dart';

class ChatTile extends StatelessWidget {
  final String profileImg, firstName, lastName;
  final int unreads;
  void Function(BuildContext) onChatTap;
  ChatTile({
    super.key,
    required this.profileImg,
    required this.firstName,
    required this.lastName,
    required this.unreads,
    required this.onChatTap,
  });

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      // padding: const EdgeInsets.only(right: 10),
      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        surfaceIntensity: .1,
        color: secondary,
        shadowLightColor: secondaryLight,
        shadowDarkColor: secondaryDark,
        depth: 18,
      ),
      child: ListTile(
        leading: Image.network(profileImg),
        title: Text(
          "$firstName $lastName",
          maxLines: 1,
          style: TextStyle(color: black),
        ),
        trailing: (unreads > 0
            ? const Icon(Icons.mark_unread_chat_alt)
            : const Text("")),
        onTap: () {
          onChatTap(context);
        },
      ),
    );
  }
}

class ChatData {
  String profileImg, token, heading, name;
  late DateTime lastMessageAt;
  ChatData(
      {this.heading = "Loading...",
      this.profileImg = "",
      required this.token,
      lastMessageAt,
      this.name = "Loading..."}) {
    this.lastMessageAt =
        lastMessageAt ?? DateTime.fromMicrosecondsSinceEpoch(0);
  }
}

class AllChats extends StatefulWidget {
  final User cUser;
  const AllChats({
    Key? key,
    required this.cUser,
  }) : super(key: key);

  @override
  State<AllChats> createState() => _AllChatsState();
}

class _AllChatsState extends State<AllChats> {
  //store all chats according to token
  Map<String, ChatData> chatdb = {};

  late StreamSubscription usersQuery;
  List<String> friendList = [];

  @override
  void initState() {
    super.initState();
    //remember to check if user profile updates
    usersQuery = getUserData();
  }

  @override
  dispose() {
    super.dispose();
    usersQuery.cancel();
  }

  /// returns friend list
  StreamSubscription getUserData() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(widget.cUser.uid)
        .collection('friends')
        .snapshots()
        .listen(
      (snapshot) {
        friendList = [];
        for (var element in snapshot.docs) {
          friendList.add(element.id);
        }
        // print(friendList);
        if (mounted) {
          setState(() {});
        } else {
          print("not mounted");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          "Chats",
          style: TextStyle(
            color: primary,
          ),
          textAlign: TextAlign.center,
        ),
        // elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.barsStaggered,
            color: primary,
          ),
          onPressed: () {
            zoomDrawerController.toggle!();
          },
        ),
        // shadowColor: secondaryLight,
        shadowColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AddFriends(
                          cUser: widget.cUser, friends: friendList);
                    },
                  ),
                );
              },
              icon: Icon(
                FontAwesomeIcons.add,
                color: primary,
              ))
        ],
      ),
      body: (friendList.isEmpty
          ? Container(
              decoration: BoxDecoration(color: secondary),
              child: const Text("No friends"),
            )
          : Container(
              decoration: BoxDecoration(color: secondary),
              child: ListView.builder(
                itemBuilder: ((context, index) {
                  return FutureBuilder(
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      } else {
                        var userData = snapshot.data?.data();
                        return ChatTile(
                          profileImg: userData!["profileImg"],
                          firstName: userData["firstName"],
                          lastName: userData["lastName"],
                          unreads: 0,
                          onChatTap: (context) {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return ChatScreen(
                                    otherUser: userData, cUser: widget.cUser);
                              },
                            ));
                          },
                        );
                      }
                    },
                    future: FirebaseFirestore.instance
                        .collection("users")
                        .doc(friendList[index])
                        .get(),
                  );
                }),
                itemCount: friendList.length,
              ),
            )),
    );
  }
}
