import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{

  final String uid;
  String? userName;
  final String email;
  String? profilePhoto;
  late  String? authMethod;



  UserModel({ required this.uid, this.userName, required this.email, this.profilePhoto, this.authMethod});

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