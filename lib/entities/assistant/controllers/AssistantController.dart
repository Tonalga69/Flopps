import 'package:flopps/entities/assistant/models/model.dart';
import 'package:flopps/entities/assistant/repository/AssistantRepository.dart';
import 'package:flopps/entities/users/widgets/userSnackBar.dart';
import 'package:flopps/utils/Strings.dart';
import 'package:get/get.dart';

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
}
