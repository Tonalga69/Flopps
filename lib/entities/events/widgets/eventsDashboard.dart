import 'package:flopps/entities/events/widgets/closestEvent.dart';
import 'package:flopps/entities/events/widgets/event_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/ProjectColors.dart';
import '../../../utils/Strings.dart';
import '../controllers/eventController.dart';

class EventsDashboard extends StatefulWidget {
  const EventsDashboard({Key? key}) : super(key: key);

  @override
  State<EventsDashboard> createState() => _EventsDashboardState();
}

class _EventsDashboardState extends State<EventsDashboard> {
  final _eventController = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventController>(builder: (controller) {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          color: Color(ProjectColors.white),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: _eventController.invitedEvents.isNotEmpty
            ? CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: GetBuilder<EventController>(
                      initState: (_) => _eventController.getAllEvents(),
                      builder: (controller) =>
                          controller.invitedEvents.isNotEmpty
                              ? ClosestEvent(
                                  events: controller.invitedEvents.first,
                                )
                              : Container(),
                    ),
                  ),
                  GetBuilder<EventController>(builder: (controller) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: controller.invitedEvents.length + 1,
                        (context, index) {
                          if (index == 0) {
                            return Container();
                          }
                          if (index == controller.invitedEvents.length) {
                            return Container(
                              height: 50,
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: const Text(
                                Strings.noMoreEvents,
                                style: TextStyle(color: Colors.grey),
                              ),
                            );
                          }
                          return EventItem(
                            events: controller.invitedEvents[index],
                          );
                        },
                      ),
                    );
                  }),
                ],
              )
            : Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text.rich(
                      TextSpan(text: "No events yet?", children: [
                        TextSpan(
                          text: "\nCreate one!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(ProjectColors.strongBlue),
                          ),
                        ),
                      ]),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: FontFamily.sourceSansPro,
                      )),
                  Lottie.asset("lib/assets/lotties/noEvents.json",
                      repeat: false)
                ],
              )),
      );
    });
  }
}
