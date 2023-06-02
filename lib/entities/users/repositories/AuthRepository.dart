import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flopps/entities/users/model.dart';
import 'package:flopps/entities/users/repositories/authMethod.dart';
import 'package:flopps/screens/loginScreen/LoginMain.dart';
import 'package:flopps/screens/settings/Settings.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../widgets/userSnackBar.dart';

class AuthRepository extends GetxController {
  static AuthRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  late UserCredential googleCredential;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _initialScreen);
  }

  _initialScreen(User? user) {
    user == null
        ? Get.offAll(() => const LoginMain())
        : Get.offAll(() => const Settings());
  }

  UserModel getAuthUserData() {
    var user = _auth.currentUser;
    return UserModel(
        uid: user!.uid, email: user.email!, profilePhoto: user.photoURL!);
  }

  Future<UserModel?> createUserWithPassword(
      String email, String password) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .catchError((error) {
        Get.showSnackbar(errorPasswordSnackBar);
      });
      firebaseUser.value != null
          ? Get.offAll(() => const Settings())
          : Get.to(() => const LoginMain());

      return UserModel(
          uid: firebaseUser.value!.uid,
          email: firebaseUser.value!.email!,
          authMethod: AuthMethod.email);
    } on FirebaseAuthException catch (_) {
    } catch (_) {}

    return null;
  }

  Future<void> loginWithPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => const Settings())
          : Get.to(() => const LoginMain());
    } on FirebaseAuthException catch (_) {
      Get.showSnackbar(errorInvalidPasswordSnackBar);
    } catch (_) {}
  }

  Future<UserModel?> loginWithGoogle() async {
    try {
      googleCredential = await _signInWithGoogle();
      firebaseUser.value != null
          ? Get.offAll(() => const Settings())
          : Get.to(() => const LoginMain());
      return UserModel(
          uid: firebaseUser.value!.uid,
          email: firebaseUser.value!.email!,
          profilePhoto: firebaseUser.value!.photoURL);
    } catch (error) {
      Get.showSnackbar(errorSnackBar);
    }

    return null;
  }

  Future<void> logout() async {
    await _auth.signOut();
    firebaseUser.value != null
        ? Get.offAll(
            transition: Transition.rightToLeft,
            duration: const Duration(milliseconds: 500),
            () => const Settings())
        : Get.to(() => const LoginMain(),
            transition: Transition.leftToRight,
            duration: const Duration(milliseconds: 500));
    await GoogleSignIn().signOut();
  }

  Future<UserCredential> _signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
