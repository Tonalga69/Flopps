import 'package:flopps/entities/assistant/models/model.dart';
import 'package:flopps/entities/assistant/repository/assistant_repository.dart';
import 'package:flopps/entities/users/widgets/userSnackBar.dart';
import 'package:flopps/utils/Strings.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class AssistantController extends GetxController {
  static AssistantController get instance => Get.find();



  late AssistantModel assistant;
  late List<AssistantModel> ownedAssistants;
  late List<AssistantModel> shopList;


  void selectAssistant(String assistantUID) {
    AssistantRepository.instance.selectAssistant(assistantUID).then((result) {
      if (result != null) {
        assistant = AssistantModel.fromFirebase(result);
      }
      Get.showSnackbar(genericSnackBar(Strings.errorGetAssistant));
    });
  }

  void getSelectedAssistant() async{
    AssistantRepository.instance.getSelectedAssistant();
  }
  void setInitialAssistant() async {
    AssistantRepository.instance.setInitialAssistant();
  }

  void getOwnedAssistants() async {
    final assistantList =
    await AssistantRepository.instance.getOwnedAssistants();
    ownedAssistants = assistantList.docs
        .map((doc) => AssistantModel.fromFirebase(doc))
        .toList();
  }

  void getShopAssistant() async {
    final assistantList =
    await AssistantRepository.instance.getShopAssistants();
    shopList = assistantList.docs
        .map((doc) => AssistantModel.fromFirebase(doc))
        .toList();
  }

  Future<bool> requestOverlayPermission() async {
    final result = await Permission.systemAlertWindow
        .request()
        .isGranted;
    return result;
  }

  Future<bool> getOverlayPermission() async {
    final result = await Permission.systemAlertWindow.isGranted;
    return result;
  }

  Future<bool> getNotificationPermission() async {
    final result = await Permission.notification
        .request()
        .isGranted;
    return result;
  }

  Future<bool> getMicroPhonePermission() async {
    final result = await Permission.microphone.isGranted;
    return result;
  }

  Future<bool> requestMicrophonePermission() async {
    final result = await Permission.microphone
        .request()
        .isGranted;
    return result;
  }
}
