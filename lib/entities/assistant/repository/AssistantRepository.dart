import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flopps/utils/Strings.dart';
import 'package:get/get.dart';

class AssistantRepository extends GetxController {
  static AssistantRepository get instance => Get.find();
  final _uid = FirebaseAuth.instance.currentUser?.uid;
  final _db = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>?> getUserAssistant() async {
    try {
      final assistantDoc = await _db
          .collection("${Collections.users}/$_uid/${Collections.assistant}")
          .doc(_uid)
          .get();
      return await _db
          .collection(Collections.availableAssistants)
          .doc(assistantDoc.data()?["uid"])
          .get();
    } on FirebaseException catch (_) {
      return null;
    } catch (_) {
      return null;
    }
  }
}
