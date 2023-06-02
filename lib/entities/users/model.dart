import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{

  late final String uid;
  late String? userName;
  late final String email;
  late String? profilePhoto;
  late final String? authMethod;
  late List<UserModel>? friends;



  UserModel({ required this.uid, this.userName, required this.email, this.profilePhoto, this.authMethod, this.friends});

  factory UserModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      ) {
    final data = snapshot.data();
    return UserModel(
      uid: data?['uid'],
      email: data?['email'],
      userName: data?['userName'],
      profilePhoto: data?['profilePhoto'],
      authMethod: data?['authMethod'],
      friends: data?["friends"]
    );
  }

  toJson(){
    return {
      "uid": uid,
      "userName": userName,
      "email": email,
      if(profilePhoto != null) "profilePhoto": profilePhoto
    };
  }
}