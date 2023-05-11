class UserModel{

  final String id;
  final String userName;
  final String email;
  final String? profilePhoto;


  UserModel({ required this.id, required this.userName, required this.email, this.profilePhoto});

  toJson(){
    return {
      "id": id,
      "userName": userName,
      "email": email,
      "profilePhoto": profilePhoto
    };
  }
}