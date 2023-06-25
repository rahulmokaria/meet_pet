import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  final String? token;
  final DateTime? lastMessageAt;
  ChatRoom({this.token, this.lastMessageAt});
  factory ChatRoom.fromFirestore(DocumentSnapshot<Map<String,dynamic>>snapshot,SnapshotOptions? snapshotOptions){
    final data=snapshot.data()!;
    return ChatRoom(lastMessageAt: data["lastMessageAt"],token: data["token"]);
  }
  Map<String,dynamic>toFireStore(){
    return {
      'token':token,
      'lastMessageAt':lastMessageAt,
    };
  }
}