class UserModel{

  final String uid;
  final String? userName;
  final String email;
  final String? profilePhoto;


  UserModel({ required this.uid, this.userName, required this.email, this.profilePhoto});

  toJson(){
    return {
      "uid": uid,
      "userName": userName,
      "email": email,
      if(profilePhoto != null) "profilePhoto": profilePhoto
    };
  }
}