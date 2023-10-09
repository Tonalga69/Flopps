import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flopps/entities/events/models/events.dart';
import 'package:get/get.dart';
class EventRepository extends GetxController{
  static EventRepository get instance  => Get.find();
  final _db= FirebaseFirestore.instance;

Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getAllEvents() async{
  final userId= FirebaseAuth.instance.currentUser?.uid;
    final events= await _db.collection('events').where("guestsIDs", arrayContains: userId).get();
    return events.docs;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getAllEventsHosted() async{
  final userId= FirebaseAuth.instance.currentUser?.uid;
    final events= await _db.collection('events').where("hostID", isEqualTo: userId).get();
    return events.docs;
  }

  Future<DocumentSnapshot>? addEvent(Map<String, dynamic> map ) async{
    final events= await _db.collection('events').add(map);
    final result= await events.get();
    return result;
  }

  Future<void> changeEventStatus(Events event, bool status) async{
    final userId= FirebaseAuth.instance.currentUser?.uid;
    if(status){
      await _db.collection('events').doc(event.id).update({"assistantsIDs": FieldValue.arrayUnion([userId])});
      return;
    }
    await _db.collection('events').doc(event.id).update({"assistantsIDs": FieldValue.arrayRemove([userId])});
    await _db.collection('events').doc(event.id).update({"guestsIDs": FieldValue.arrayRemove([userId])});
  }

}