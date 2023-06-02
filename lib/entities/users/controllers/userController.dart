import 'package:flopps/entities/users/model.dart';
import 'package:flopps/entities/users/repositories/AuthRepository.dart';
import 'package:flopps/entities/users/repositories/UserRepository.dart';
import 'package:flopps/entities/users/repositories/storageRepository.dart';
import 'package:flopps/entities/users/widgets/userSnackBar.dart';
import 'package:flopps/utils/ProjectColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/Strings.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  UserModel user = AuthRepository.instance.getAuthUserData();

  Future<UserModel> getUserData() async {
    user = await UserRepository.instance.getDetailedUserData(uid: user.uid);
    return user;
  }

  Future<String?> uploadPhoto(BuildContext context) async {



    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {

      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Flopps',
              toolbarColor: const Color(ProjectColors.blue),
              toolbarWidgetColor: const Color(ProjectColors.grayBackground),
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
        ],
      );
      if(croppedFile!=null){
        final data= await croppedFile.readAsBytes();
        final String? urlPath = await StorageRepository.instance.uploadImage(data);
        UserRepository.instance.updateUserFields(
            uid: user.uid, map: {"profilePhoto": urlPath}).then((value) {
          if (value != null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(genericSnackBar(Strings.genericError));
            return Strings.defaultProfilePhoto;
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(genericSnackBar(Strings.genericSuccess));
            return user.profilePhoto = urlPath;
          }
        });
      }
    }
    return null;
  }

  void updateUser(
      {required Map<String, dynamic> map, required BuildContext context}) {
    UserRepository.instance
        .updateUserFields(uid: user.uid, map: map)
        .then((value) {});
  }
}
