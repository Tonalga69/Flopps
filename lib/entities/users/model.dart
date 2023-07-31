import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late final String uid;
  late String? userName;
  late final String email;
  late String? profilePhoto;
  late final String? authMethod;
  late List<UserModel>? friends;
  late List<UserModel>? pendingRequests;

  UserModel(
      {required this.uid,
      this.userName,
      required this.email,
      this.profilePhoto,
      this.authMethod,
      this.friends,
      this.pendingRequests});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
    );
  }

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    final friends = data?['friends'] as List<dynamic>?;
    final pendingRequests = data?['pendingRequests'] as List<dynamic>?;
    List<UserModel>? pendingRequestsList= pendingRequests?.map((e) => UserModel.fromMap(e)).toList();
    List<UserModel>? friendsList = friends?.map((e) => UserModel.fromMap(e)).toList();

    return UserModel(
        uid: data?['uid'],
        email: data?['email'],
        userName: data?['userName'],
        profilePhoto: data?['profilePhoto'],
        authMethod: data?['authMethod'],
        friends: friendsList,
        pendingRequests: pendingRequestsList);
  }

  toJson() {
    return {
      "uid": uid,
      "userName": userName,
      "email": email,
      if (profilePhoto != null) "profilePhoto": profilePhoto,
    };
  }

  toJsonDebug() {
    return {
      "uid": uid,
      "userName": userName,
      "email": email,
      "profilePhoto": profilePhoto,
      "authMethod": authMethod,
      "friends": friends,
      "pendingRequests": pendingRequests
    };
  }
}
