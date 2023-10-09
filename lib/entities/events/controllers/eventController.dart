import 'package:firebase_auth/firebase_auth.dart';
import 'package:flopps/entities/events/models/events.dart';
import 'package:flopps/entities/events/repositories/EventRepository.dart';
import 'package:flopps/utils/Strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../screens/events/addEventScreen.dart';
import '../../../utils/ProjectColors.dart';

class EventController extends GetxController {
  static EventController get instance => Get.find();
  List<Events> invitedEvents = List.empty(growable: true);
  List<Events> hostedEvents = List.empty(growable: true);

  void addEvent(Events event) async {
    await EventRepository.instance.addEvent(event.toMap());
    const GetSnackBar(
      messageText: Text("Uploading your Event",
          style: TextStyle(fontFamily: FontFamily.sourceSansPro)),
      duration: Duration(seconds: 2),
      dismissDirection: DismissDirection.endToStart,
      backgroundColor: Color(ProjectColors.darkBackground),
    );
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getAllEvents();
    getHostedEvents();
  }

  void getAllEvents() async {

    final events = await EventRepository.instance.getAllEvents();
    invitedEvents = events.map((e) => Events.fromFirebase(e)).toList();
    invitedEvents.sort((a, b) => a.date.toDate().compareTo(b.date.toDate()));
    update();
  }

  void getHostedEvents() async {
    final events = await EventRepository.instance.getAllEventsHosted();
    hostedEvents = events.map((e) => Events.fromFirebase(e)).toList();
    update();
  }

  void goAddEventScreen() {
    Get.to(() => const AddEventScreen());
  }

  void popScreen() {
    Get.back();
  }

  void changeEventStatus(Events event, bool status) async {
    await EventRepository.instance.changeEventStatus(event, status);
    if(status) {
      invitedEvents.firstWhere((element) => event.id==element.id).assistantsIDs?.add(FirebaseAuth.instance.currentUser?.uid??"");
      return;
    }
    invitedEvents.remove(invitedEvents.firstWhere((element) => event.id==element.id));

    update();
  }

  void openMaps(String locationsUrl, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Close")),
            TextButton(
              onPressed: () async {
                final Uri url =
                Uri.parse(locationsUrl);
                if (!await launchUrl(url)) {
                  throw Exception(
                      'Could not launch $url');
                }
              },
              child: const Text(Strings.open),
            )
          ],
          content: SizedBox(
            height: 100,
            width: 100,
            child: Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                      text:
                      "Are you sure you want to open "),
                  TextSpan(
                      text: locationsUrl,
                      style: const TextStyle(
                          color: Colors.blue)),
                  const TextSpan(
                      text: " in your browser?",
                      style: TextStyle(
                          fontFamily:
                          FontFamily.sourceSansPro,
                          color:
                          Color(ProjectColors.white)))
                ],
              ),
              style: const TextStyle(
                  color: Color(ProjectColors.white),
                  fontFamily: FontFamily.sourceSansPro,
                  fontSize: 14),
            ),
          ),
        );
      },
    );
  }
}
