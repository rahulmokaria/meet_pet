// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:meet_pet/resources/chat_methods.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   bool isShowSticker = true;
//   bool _isLoading = false;
//   final TextEditingController _textEditingController = TextEditingController();
//   late final ChatMethods _chatMethods;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     focusNode.addListener(onFocusChange);
//     _chatMethods = ChatMethods(
//         firestore: FirebaseFirestore.instance,
//         storage: FirebaseStorage.instance);
//   }

//   FocusNode focusNode = FocusNode();
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: onBackpress,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Chat"),
//         ),
//         body: Column(
//           children: [
//             // Text("hii"),
//             // buildMessageList(),
//             // (isShowSticker ? buildSticker() : Container()),
//             buildInput(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildInput() {
//     return Container(
//       child: Row(
//         children: [
//           Material(
//             color: Colors.white,
//             child: Container(
//               margin: const EdgeInsets.symmetric(horizontal: 1),
//               child: IconButton(
//                 icon: Icon(Icons.image),
//                 onPressed: () {
//                   getImage(ImageSource.gallery);
//                 },
//               ),
//             ),
//           ),
//           Material(
//             color: Colors.white,
//             child: IconButton(
//               icon: Icon(FontAwesomeIcons.faceSmile),
//               onPressed: getSticker,
//             ),
//           ),
//           TextField(
//             textCapitalization: TextCapitalization.sentences,
//             maxLines: 1,
//             controller: _textEditingController,
//           )
//         ],
//       ),
//     );
//   }

//   void getSticker() {
//     // Hide keyboard when sticker appear
//     focusNode.unfocus();
//     setState(() {
//       isShowSticker = !isShowSticker;
//     });
//   }

//   getImage(ImageSource source) async {
//     ImagePicker imagePicker = ImagePicker();
//     var imageFile = await imagePicker.pickImage(
//       source: source,
//     );
//     if (imageFile != null) {
//       setState(
//         () {
//           _isLoading = true;
//         },
//       );
//       uploadImage(imageFile);
//     }
//   }

//   uploadImage(XFile imageFile) async {
//     _chatMethods.uploadFile(
//         file: File(imageFile.path), fileName: ChatMethods.randomString());
//   }

//   void onFocusChange() {
//     if (focusNode.hasFocus) {
//       // Hide sticker when keyboard appear
//       setState(() {
//         isShowSticker = false;
//       });
//     }
//   }

//   Widget buildMessageList() {
//     return ListView.builder(
//       itemBuilder: (context, index) {
//         print(index);
//         return ListTile(
//           title: Text("hii"),
//         );
//       },
//       itemCount: 5,
//     );
//   }

//   Future<bool> onBackpress() async {
//     if (isShowSticker) {
//       setState(() {
//         isShowSticker = false;
//       });
//       return false;
//     } else {
//       return true;
//     }
//   }

//   buildSticker() {
//     return Text("Sticker bar");
//   }
// }
