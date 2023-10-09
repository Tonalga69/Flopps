import 'package:flopps/entities/assistant/models/model.dart';
import 'package:flopps/entities/assistant/repository/assistant_repository.dart';
import 'package:flopps/entities/users/repositories/UserRepository.dart';
import 'package:flopps/entities/users/widgets/userSnackBar.dart';
import 'package:flopps/utils/Strings.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../users/repositories/storageRepository.dart';

class AssistantController extends GetxController {
  static AssistantController get instance => Get.find();

  AssistantModel? assistant;
  late List<AssistantModel> ownedAssistants;
  late List<AssistantModel> shopList;
  late bool isActive =false;

  @override
  void onReady() {
    setInitialAssistant();
    getSelectedAssistant();
    checkIfItsActive();
  }

  Future<bool> checkIfItsActive()async {
    isActive=await AssistantRepository.instance.isActive();
    return isActive;
  }
  Future<void> setIsActive(bool value)async{
    isActive= await AssistantRepository.instance.setActive(value);
  }

  void selectAssistant(String assistantUID, String userUid) {
    AssistantRepository.instance.selectAssistant(assistantUID).then((result) {
      if (result != null) {
        assistant = AssistantModel.fromFirebase(result);
        UserRepository.instance.setAssistant(assistantUID, userUid);
        return;
      }
      Get.showSnackbar(genericSnackBar(Strings.errorGetAssistant));
    });
  }

  Future<void> getSelectedAssistant() async {
    final data = await AssistantRepository.instance.getSelectedAssistant();
    if (data != null) {
      assistant = AssistantModel.fromFirebase(data);
    }
  }

  Future<void> downloadPicture(String url) async {
    await StorageRepository.instance.downloadPicture(url);
  }

  Future<void> setInitialAssistant() async {
    await AssistantRepository.instance.setInitialAssistant();
  }

  Future<List<AssistantModel>> getOwnedAssistants() async {
    final assistantList =
        await AssistantRepository.instance.getOwnedAssistants();
    ownedAssistants = assistantList.docs
        .map((doc) => AssistantModel.fromFirebase(doc))
        .toList();
    return ownedAssistants;
  }

  void getShopAssistant() async {
    final assistantList =
        await AssistantRepository.instance.getShopAssistants();
    shopList = assistantList.docs
        .map((doc) => AssistantModel.fromFirebase(doc))
        .toList();
  }

  Future<bool> requestOverlayPermission() async {
    final result = await Permission.systemAlertWindow.request().isGranted;
    return result;
  }

  Future<bool> getOverlayPermission() async {
    final result = await Permission.systemAlertWindow.isGranted;
    return result;
  }

  Future<bool> getNotificationPermission() async {
    final result = await Permission.notification.request().isGranted;
    return result;
  }

  Future<bool> getMicroPhonePermission() async {
    final result = await Permission.microphone.isGranted;
    return result;
  }

  Future<bool> requestMicrophonePermission() async {
    final result = await Permission.microphone.request().isGranted;
    return result;
  }

  Future<String> getAssistantPhoto(String uid) async {
    return await StorageRepository.instance.getAssistantUrl(uid) ??
        Strings.defaultProfilePhoto;
  }
}
