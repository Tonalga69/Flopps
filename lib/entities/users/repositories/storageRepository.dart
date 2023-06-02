import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flopps/entities/users/widgets/userSnackBar.dart';
import 'package:flopps/utils/Strings.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class StorageRepository extends GetxController {
  static StorageRepository get instance => Get.find();
  final _reference = FirebaseStorage.instance.ref();
  final String? _uid = FirebaseAuth.instance.currentUser?.uid;

  Future<String?> uploadImage(Uint8List file) async {

    try {
      await _reference.child("/users/$_uid/profilePhoto.jpg").putData(file);
      return await _reference
          .child("/users/$_uid/profilePhoto.jpg")
          .getDownloadURL();
    } on FirebaseException catch (_) {
      Get.showSnackbar(genericSnackBar(Strings.genericError));
      return null;
    }
  }
}
