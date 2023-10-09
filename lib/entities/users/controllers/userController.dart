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
    update();
    return user;

  }

  Future<UserModel> getUserByUid(String uid) async {
    return await UserRepository.instance.getDetailedUserData(uid: uid);
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
              statusBarColor: const Color(ProjectColors.blue),
              lockAspectRatio: false),
        ],
      );
      if (croppedFile != null) {
        final data = await croppedFile.readAsBytes();
        final String? urlPath =
            await StorageRepository.instance.uploadImage(data);
        UserRepository.instance.updateUserFields(
            uid: user.uid, map: {"profilePhoto": urlPath}).then((value) {
          if (value != null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(genericSnackBar(Strings.genericError));
            return Strings.defaultProfilePhoto;
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(genericSnackBar(Strings.genericSuccess));
             user.profilePhoto = urlPath;
            update();
            return urlPath;
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
    update();
  }

  void updateFriendsList(String uid, frienduid, friendMail) async {
    final data = await UserRepository.instance
        .updateFriendsList(uid, frienduid, friendMail);
    if (data != null) {
      user.friends = data;
      update();
    }
  }

  void sendFriendRequestTo(String uid, UserModel sender) async {
    await UserRepository.instance.sendFriendRequestTo(uid: uid, sender: sender);
  }

  void stopBeingFriends(UserModel me, UserModel friend) async {
    await UserRepository.instance.stopBeingFriends(me, friend);
    final index =
        user.friends!.indexWhere((element) => element.uid == friend.uid);
    user.friends!.removeAt(index);
    update();
  }

  void cancelFriendRequest(String frienduid, UserModel me) async {
    await UserRepository.instance.cancelFriendRequest(frienduid, me);
  }

  void acceptFriendRequest(UserModel userRequested) async {
    user.pendingRequests!.removeWhere((element) => element.uid == userRequested.uid);
    UserRepository.instance.acceptFriendRequest(userRequested, user);
    update();
    update(["friends"]); //update friends list
  }

  void declineFriendRequest(UserModel requestedUser) {
    user.pendingRequests!.removeWhere((element) => element.uid == requestedUser.uid);
    UserRepository.instance.declineFriendRequest(requestedUser, user);
    update( );

  }

  Future<List<UserModel>?> getUserQuery(String name) async {
    try {
      return await UserRepository.instance
          .getUserQuery(name, user.userName ?? "");
    } catch (e) {
      return null;
    }
  }

  Future<String> getProfileUrl(String uid) async {
    return await StorageRepository.instance.getProfileUrl(uid) ??
        Strings.defaultProfilePhoto;
  }


}
