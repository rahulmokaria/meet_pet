class Request {
  String senderName;
  String senderUid;
  String ownerName;
  String ownerUid;
  String petId;
  String petName;
  String status = "Pending";
  String requestId;
  Request({
    required this.ownerName,
    required this.ownerUid,
    required this.petId,
    required this.petName,
    required this.requestId,
    required this.senderName,
    required this.senderUid,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ownerName': ownerName,
      'ownerUid': ownerUid,
      'petId': petId,
      'petName': petName,
      'requestId': requestId,
      'senderName': senderName,
      'senderUid': senderUid,
      'status': status,
    };
  }
}
