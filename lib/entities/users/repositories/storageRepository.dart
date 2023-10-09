import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flopps/entities/users/widgets/userSnackBar.dart';
import 'package:flopps/utils/Strings.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart' as PermissionHandler;
import 'package:permission_handler/permission_handler.dart';

class StorageRepository extends GetxController {
  static StorageRepository get instance => Get.find();
  final _reference = FirebaseStorage.instance.ref();




  Future<String?> uploadImage(Uint8List file) async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;

    try {
      await _reference.child("/users/$uid/profilePhoto.jpg").putData(file);
      print("$uid-----------------------------------------------------");
      return await _reference
          .child("/users/$uid/profilePhoto.jpg")
          .getDownloadURL();
    } on FirebaseException catch (_) {
      Get.showSnackbar(genericSnackBar(Strings.genericError));
      return null;
    }
  }

  Future<bool> requestSaveImagePermission() async {
    // Check if the permission is already granted.
    if (await PermissionHandler.Permission.storage.isGranted) {
      return true;
    }
    // We didn't ask for permission yet.
    if (await PermissionHandler.Permission.storage.isPermanentlyDenied) {
      // The user opted to never again see the permission request dialog for this
      // app. The only way to change the permission's status now is to let the
      // user manually enable it in the system settings.
      return false;
    }
    // Must ask the user for permission.
    PermissionHandler.PermissionStatus permissionStatus =
        await PermissionHandler.Permission.storage.request();
    return permissionStatus == PermissionHandler.PermissionStatus.granted;
  }
  Future<void> downloadPicture(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final appDocDir = await path_provider.getApplicationDocumentsDirectory();
      final filePath = '${appDocDir.path}${DateTime.now().microsecond}.png';
      final file = File(filePath);
      if(!await requestSaveImagePermission()){
        return;
      }

      await file.writeAsBytes(response.bodyBytes);

      Get.showSnackbar(
        GetSnackBar(
           message:'Image downloaded and saved to $filePath',
          duration: const Duration(seconds: 1),
        ),
      );
    } else {
      throw Exception('Failed to download image');
    }
  }



  Future<String?> getProfileUrl(String uid) async {
    try {
      return await _reference
          .child("/users/$uid/profilePhoto.jpg")
          .getDownloadURL();
    } on FirebaseException catch (_) {
      Get.showSnackbar(genericSnackBar(Strings.genericError));
      return null;
    }
  }
  Future<String?> getAssistantUrl(String uid) async {
    try {

      return await _reference
          .child("/asisstant/$uid.jpg")
          .getDownloadURL();
      
    }  catch (_) {
      Get.showSnackbar(genericSnackBar(Strings.genericError));
      return null;
    }
  }
}
