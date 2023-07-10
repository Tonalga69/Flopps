
import 'package:cloud_firestore/cloud_firestore.dart';

class AssistantModel{

  late final String uid;
  late final Map<String, dynamic> phrases;
  late final String profilePhoto;
  late final String name;



  AssistantModel({required this.uid, required this.profilePhoto, required this.phrases, required this.name});


  factory AssistantModel.fromFirebase( DocumentSnapshot<Map<String, dynamic>> snapshot){

    final data= snapshot.data();


    return AssistantModel(
      name: data?["name"],
      uid: data?["uid"],
      profilePhoto: data?["profilePhoto"],
      phrases: data?["phrases"],
    );
  }

}