import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserModel {
  late final String uid;
  late String? userName;
  late final String email;
  late String? profilePhoto;
  late String? authMethod;
  late List<UserModel>? friends;
  late List<UserModel>? pendingRequests;
  late String? assistantUid;

  UserModel(
      {required this.uid,
      this.userName,
      required this.email,
      this.profilePhoto,
      this.authMethod,
      this.friends,
      this.pendingRequests,
      this.assistantUid});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      userName: map['userName'],
      assistantUid: map['assistantUid'],
    );
  }

  factory UserModel.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    final friends = data?['friends'] as List<dynamic>?;
    final pendingRequests = data?['pendingRequests'] as List<dynamic>?;
    List<UserModel>? pendingRequestsList;
    List<UserModel>? friendsList;

    try {
      pendingRequestsList =
          pendingRequests?.map((e) => UserModel.fromMap(e)).toList();
      friendsList = friends?.map((e) => UserModel.fromMap(e)).toList();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return UserModel(
        uid: data?['uid'],
        email: data?['email'],
        userName: data?['userName'],
        profilePhoto: data?['profilePhoto'],
        authMethod: data?['authMethod'],
        friends: friendsList,
        pendingRequests: pendingRequestsList,
        assistantUid: data?['assistantUid']);
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
      "pendingRequests": pendingRequests,
      "assistantUid": assistantUid
    };
  }
}
