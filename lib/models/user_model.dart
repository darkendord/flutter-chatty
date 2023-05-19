class UserModel {
  String? id;
  String? name;
  String? email;
  String? photo;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.photo,
  });

  factory UserModel.userModelData(Map<String, dynamic> jsonMap) {
    return UserModel(
      id: jsonMap["id"],
      name: jsonMap["name"],
      email: jsonMap["email"],
      photo: jsonMap["phone"],
    );
  }
}
