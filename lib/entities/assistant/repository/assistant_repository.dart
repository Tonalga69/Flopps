import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flopps/utils/Strings.dart';
import 'package:get/get.dart';
import 'package:localstore/localstore.dart';

class AssistantRepository extends GetxController {
  static AssistantRepository get instance => Get.find();
  final _uid = FirebaseAuth.instance.currentUser?.uid;
  final _db = FirebaseFirestore.instance;
  final _localDB = Localstore.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>?> selectAssistant(
      String assistantUID) async {
    try {
      final doc = await _db
          .collection("${Collections.users}/$_uid/${Collections.assistant}")
          .doc(assistantUID)
          .get();
      final data = doc.data();

      if (doc.exists && data != null) {
        await _localDB
            .collection(Collections.availableAssistants)
            .doc(_uid)
            .set(data);
      }
      return doc;
    } on FirebaseException catch (_) {
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getOwnedAssistants() async {
    return await _db
        .collection("${Collections.users}/$_uid/${Collections.assistant}")
        .get();
  }

  Future<void> setInitialAssistant() async {
    final hasInitialAssistant = await _db
        .collection("${Collections.users}/$_uid/${Collections.assistant}")
        .doc("Initial")
        .get();

    if (hasInitialAssistant.exists) {
      return;
    }
    final initialAssistant = await _db
        .collection(Collections.assistant)
        .doc("Initial")
        .get();
    final data = initialAssistant.data();
    if (data != null) {
      await _localDB
          .collection(Collections.availableAssistants)
          .doc(_uid)
          .set(data);
     await _db
          .collection("${Collections.users}/$_uid/${Collections.assistant}")
          .doc("Initial")
          .set(data);
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> getSelectedAssistant() async {
    final doc = await _localDB
        .collection(Collections.availableAssistants)
        .doc(_uid)
        .get();
    return await _db
        .collection("${Collections.users}/$_uid/${Collections.assistant}")
        .doc(doc?["uid"])
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getShopAssistants() async {
    return await _db.collection(Collections.shopAsistants).get();
  }
}
