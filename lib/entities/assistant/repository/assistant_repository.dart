
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flopps/utils/Strings.dart';
import 'package:get/get.dart';
import 'package:localstore/localstore.dart' as deviceStorage;

class AssistantRepository extends GetxController {
  static AssistantRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _localDB = deviceStorage.Localstore.instance;




  Future<bool> isActive() async {
    final data = await _localDB.collection(Collections.users).doc("config").get();
    if (data == null) {
      await _localDB.collection(Collections.users).doc("config").set(
          {"active": false});
      return false;
    }
    return data["active"];
  }
  Future<bool> setActive(bool value) async {
    await _localDB.collection(Collections.users).doc("config").set({"active": value}, deviceStorage.SetOptions(merge: true));
    final updatedData= await _localDB.collection(Collections.users).doc("config").get();
    return updatedData?["active"];
  }


Future<DocumentSnapshot<Map<String, dynamic>>?> selectAssistant(
    String assistantUID) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  try {
    final doc = await _db
        .collection("${Collections.users}/$uid/${Collections.assistant}")
        .doc(assistantUID)
        .get();
    final data = doc.data();

    if (doc.exists && data != null) {
      await _localDB
          .collection(Collections.availableAssistants)
          .doc(uid)
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
  final uid = FirebaseAuth.instance.currentUser?.uid;
  return await _db
      .collection("${Collections.users}/$uid/${Collections.assistant}")
      .get();
}

Future<void> setInitialAssistant() async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  final hasInitialAssistant = await _db
      .collection("${Collections.users}/$uid/${Collections.assistant}")
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
        .doc(uid)
        .set(data);
    await _db
        .collection("${Collections.users}/$uid/${Collections.assistant}")
        .doc("Initial")
        .set(data);
  }
}

Future<DocumentSnapshot<Map<String, dynamic>>?> getSelectedAssistant() async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  final doc = await _localDB
      .collection(Collections.availableAssistants)
      .doc(uid)
      .get();



  return await _db
      .collection("${Collections.users}/$uid/${Collections.assistant}")
      .doc(doc?["uid"])
      .get();
}

Future<QuerySnapshot<Map<String, dynamic>>> getShopAssistants() async {
  return await _db.collection(Collections.shopAssistants).get();
}}
