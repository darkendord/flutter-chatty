class MessageModel {
  String? id;
  String? name;
  String? email;
  String? message;
  final bool isCurrentUser;

  MessageModel(
      {this.id,
      this.name,
      this.email,
      this.message,
      required this.isCurrentUser});

  factory MessageModel.messageModelData(Map<String, dynamic> jsonMap) {
    return MessageModel(
        id: jsonMap["id"],
        name: jsonMap["name"],
        email: jsonMap["email"],
        message: jsonMap["message"],
        isCurrentUser: jsonMap["isCurrentUser"]);
  }
}
