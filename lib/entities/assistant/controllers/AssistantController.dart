

import 'package:flopps/entities/assistant/models/model.dart';
import 'package:flopps/entities/assistant/repository/AssistantRepository.dart';
import 'package:flopps/entities/users/widgets/userSnackBar.dart';
import 'package:flopps/utils/Strings.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class AssistantController extends GetxController {
  static AssistantController get instance => Get.find();
  static late AssistantModel _assistantModel;
  static AssistantModel get assistant => _assistantModel;

  void getUserAssistant() {
    AssistantRepository.instance.getUserAssistant().then((result) {
      if (result != null) {
        _assistantModel = AssistantModel.fromFirebase(result);
      }
      Get.showSnackbar(genericSnackBar(Strings.errorGetAssistant));
    });
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
}
