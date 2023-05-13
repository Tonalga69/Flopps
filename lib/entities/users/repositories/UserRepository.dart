import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flopps/entities/users/model.dart';
import 'package:flopps/entities/users/userSnackBar.dart';
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

  Future<void> createOrNotUser(UserModel user) async {
    DocumentSnapshot document =
        await db.collection(Collections.users).doc(user.uid).get();
    if (!document.exists) {
      createUser(user);
    }
  }
}
