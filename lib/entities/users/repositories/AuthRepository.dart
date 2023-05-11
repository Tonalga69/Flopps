import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flopps/screens/Dashboard/MainDashboard/DashBoard.dart';
import 'package:flopps/screens/loginScreen/LoginMain.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';



class AuthRepository extends GetxController {
  static AuthRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  late final UserCredential googleCredential;


  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _initialScreen);
  }

  _initialScreen(User? user) {
    user == null
        ? Get.offAll(() => const LoginMain())
        : Get.offAll(() => MainDashboard());
  }

  Future<void> createUserWithPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null? Get.offAll(()=>  MainDashboard()): Get.to(()=>const LoginMain());
    } on FirebaseAuthException catch (_) {
      if (kDebugMode) {
        print("Error");
      }
    } catch (_) {}
  }

  Future<void> loginWithPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null? Get.offAll(()=>  MainDashboard()): Get.to(()=>const LoginMain());
    } on FirebaseAuthException catch (_) {
      if (kDebugMode) {
        print("Error");
      }
    } catch (_) {}
  }

  Future<void> loginWithGoogle() async {
    try{
       googleCredential =await _signInWithGoogle();
      firebaseUser.value != null? Get.offAll(()=>  MainDashboard()): Get.to(()=>const LoginMain());
    }catch (e){
      if (kDebugMode) {
        print("Error $e");
      }
    }
    }


  Future<void> logout() async {
    await _auth.signOut();
    firebaseUser.value != null? Get.offAll(()=>  MainDashboard()): Get.to(()=>const LoginMain());
    await GoogleSignIn().signOut();

  }

  Future<UserCredential> _signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
