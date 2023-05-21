

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flopps/entities/users/model.dart';
import 'package:flopps/entities/users/widgets/userSnackBar.dart';
import 'package:flopps/utils/Strings.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final db = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    await db
        .collection(Collections.users)
        .doc(user.uid)
        .set(user.toJson())
        .whenComplete(() => Get.showSnackbar(accountCreated))
        .catchError((error, stackTrace) {
      Get.showSnackbar(errorCreatingAccount);
    });
  }
  Future<Object?> updateUserFields({required String? uid, required Map<String, dynamic> map})async{
    try{
    await db.collection(Collections.users).doc(uid).update(map);
  } catch(e){
      return e;
    }
    return null;

  }

  Future<void> createOrNotUser(UserModel user) async {
    DocumentSnapshot document =
        await db.collection(Collections.users).doc(user.uid).get();
    if (!document.exists) {
      createUser(user);
    }
  }

  Future<UserModel> getDetailedUserData({required String uid}) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot= await db.collection(Collections.users).doc(uid).get();
    if(snapshot.exists){
      return UserModel.fromFirestore(snapshot);
    }
    return UserModel(uid: "", email: "");

  }
}
