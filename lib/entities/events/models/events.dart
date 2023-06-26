import 'package:cloud_firestore/cloud_firestore.dart';

class Events {
  late final String name;
  late final String description;
  late final List<String> guestsIDs;
  late final String locationsUrl;
  late final Timestamp date;
  late final List<String>? assistantsIDs;
  late final String hostName;
  late final String hostID;
  late final String hostProfilePhoto;

  Events(
      {required this.name,
      required this.description,
      required this.guestsIDs,
      required this.locationsUrl,
      required this.date,
      this.assistantsIDs,
      required this.hostName,
      required this.hostID,
      required this.hostProfilePhoto});

  factory Events.fromFirebase(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return Events(
        name: data?["name"],
        description: data?["description"],
        guestsIDs: data?["guestsIDs"],
        locationsUrl: data?["locationsUrl"],
        date: data?["date"],
        hostName: data?["hostName"],
        hostID: data?["hostID"],
        hostProfilePhoto: data?["hostProfilePhoto"]);
  }
}
