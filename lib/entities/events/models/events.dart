import 'package:cloud_firestore/cloud_firestore.dart';

class Events {
  late String? id;
  late  String name;
  late  String description;
  late  List<String> guestsIDs;
  late  String locationsUrl;
  late  Timestamp date;
  late  List<String>? assistantsIDs;
  late  String hostName;
  late  String hostID;
  late  String? hostProfilePhoto;

  Events(
      {
         this.id,
        required this.name,
      required this.description,
      required this.guestsIDs,
      required this.locationsUrl,
      required this.date,
      this.assistantsIDs,
      required this.hostName,
      required this.hostID,
        this.hostProfilePhoto});

  factory Events.fromFirebase(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    final guestsIDs = data?['guestsIDs'] as List<dynamic>?;
    final assistantsIDs = data?['assistantsIDs'] as List<dynamic>?;
    return Events(
         id : snapshot.id,
        name: data?["name"],
        description: data?["description"],
        guestsIDs: guestsIDs?.map((e) => e.toString()).toList() ?? [],
        locationsUrl: data?["locationsUrl"],
        date: data?["date"],
        assistantsIDs: assistantsIDs?.map((e) => e.toString()).toList() ?? [],
        hostName: data?["hostName"],
        hostID: data?["hostID"],
        hostProfilePhoto: data?["hostProfilePhoto"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "description": description,
      "guestsIDs": guestsIDs,
      "locationsUrl": locationsUrl,
      "date": date,
      "assistantsIDs": assistantsIDs,
      "hostName": hostName,
      "hostID": hostID,
      "hostProfilePhoto": hostProfilePhoto
    };
  }
}
