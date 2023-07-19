import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flopps/utils/Strings.dart';
import 'package:get/get.dart';

class SleepTrackerFirebaseRepository extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static SleepTrackerFirebaseRepository get instance => Get.find();



  Future<DocumentSnapshot<Map<String, dynamic>>?> getData() async {
    return await _db.collection(Collections.sleepTracker).doc(
        _auth.currentUser?.uid).get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> updateTracker(Map<String, dynamic> data) async {
    await _db.collection(Collections.sleepTracker)
        .doc(_auth.currentUser?.uid)
        .set(data);
    return await _db.collection(Collections.sleepTracker).doc(_auth.currentUser?.uid).get();
  }

}