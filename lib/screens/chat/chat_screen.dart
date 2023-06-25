
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../models/message.dart';
import '../../../resources/chat_methods.dart';
import '../../../widgets/chat_bubble.dart';
import '../../../models/user.dart';
import '../../../utils/colors.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ChatScreen extends StatefulWidget {
  Map<String, dynamic> otherUser;
  final User cUser;
  late final String token;
  ChatScreen({super.key, required this.otherUser, required this.cUser}) {
    token = ChatMethods.getToken(cUser.uid, otherUser["uid"]);
  }
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isSender = true;

  bool _isLoading = false;
  final chat_methods = ChatMethods();
  TextEditingController msgController = TextEditingController();

  final _chatMethods = ChatMethods();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          widget.otherUser["firstName"] + " " + widget.otherUser["lastName"],

          style: TextStyle(
            color: primary,
          ),
          textAlign: TextAlign.center,
        ),
        // elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.chevronLeft,
            color: primary,
          ),
          onPressed: () {

            Navigator.of(context).pop();

          },
        ),
        // shadowColor: secondaryLight,
        shadowColor: Colors.transparent,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: primary,
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: secondary,
              ),
              child: Column(
                children: [
                  Expanded(
                      child: StreamBuilder(
                    stream: _chatMethods.getMessageStream(widget.token),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      } else {
                        var messages = snapshot.data!.docs.map((e) {
                          return Message.fromFirestore(e, null);
                        }).toList();
                        return ListView.builder(
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            var message = messages[index];
                            return ChatBubble(
                                message: message.message,
                                isSender: message.senderID == widget.cUser.uid);
                          },
                        );
                      }
                    },
                  )
                      // ListView.builder(
                      //   itemCount: 10, // replace with actual data count
                      //   itemBuilder: (BuildContext context, int index) {
                      //     // replace with chat bubble widget
                      //     return ChatBubble(
                      //         message: "chat bubble", isSender: isSender ^= true);
                      //   },
                      // ),
                      ),
                  const Divider(height: 1),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: getImage,
                            icon: Icon(FontAwesomeIcons.image)),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: TextField(
                              controller: msgController,
                              keyboardType: TextInputType.multiline,
                              decoration: const InputDecoration(
                                hintText: 'Type a message...',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            sendMessage();
                          },
                          icon: Icon(
                            Icons.send,
                            color: primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

    );
  }

  void sendMessage() async {
    String messageTxt = msgController.text.trim();
    if (messageTxt.isEmpty) {
      msgController.clear();
      return;
    }
    var message = Message(
        senderID: widget.cUser.uid,
        receiverID: widget.otherUser["uid"],
        timestamp: DateTime.now(),
        message: messageTxt,
        messageType: MessageType.text);
    await _chatMethods.sendMessage(message);
    print("Sent");
    msgController.clear();
    // ChatMethods;
  }

  getImage({ImageSource source = ImageSource.gallery}) async {
    ImagePicker imagePicker = ImagePicker();
    var imageFile = await imagePicker.pickImage(
      source: source,
    );
    if (imageFile != null) {
      setState(
        () {
          _isLoading = true;
        },
      );
      _chatMethods.sendImage(
          path: imageFile.path,
          senderID: widget.cUser.uid,
          receiverID: widget.otherUser["uid"]);
    }
  }
}
