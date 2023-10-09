import 'package:flopps/entities/events/controllers/eventController.dart';
import 'package:flopps/entities/events/models/events.dart';
import 'package:flopps/entities/users/controllers/userController.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../utils/ProjectColors.dart';
import '../../../utils/Strings.dart';

class ClosestEvent extends StatefulWidget {
  const ClosestEvent({Key? key, required this.events}) : super(key: key);
  final Events events;

  @override
  State<ClosestEvent> createState() => _ClosestEventState();
}

class _ClosestEventState extends State<ClosestEvent> {
  final userController = UserController.instance;
  final eventController = EventController.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 275,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(ProjectColors.blackBackground),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(3, 3),
                spreadRadius: 0,
                blurRadius: 1)
          ]),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: const Text(
                  Strings.nearestEvent,
                  style: TextStyle(
                    fontFamily: FontFamily.sourceSansPro,
                    color: Color(ProjectColors.white),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              decoration: const BoxDecoration(
                  color: Color(ProjectColors.darkBackground),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Row(
                children: [
                  Expanded(
                      flex: 7,
                      child: Stack(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15)),
                              color: Color(ProjectColors.white),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Stack(
                                      fit: StackFit.passthrough,
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15)),
                                              color: Color(
                                                  ProjectColors.strongBlue)),
                                          child: Container(
                                            alignment: Alignment.center,
                                            margin:
                                                const EdgeInsets.only(left: 60),
                                            child: Text(widget.events.name,
                                                softWrap: true,
                                                style: const TextStyle(
                                                    fontFamily: FontFamily
                                                        .sourceSansPro,
                                                    fontSize: 12)),
                                          ),
                                        ),
                                        Container(
                                          width: 60,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  bottomRight:
                                                      Radius.circular(50)),
                                              color: Color(ProjectColors.blue)),
                                          child: Container(
                                            alignment: Alignment.center,
                                            margin:
                                                const EdgeInsets.only(right: 7),
                                            child: SizedBox(
                                              width: 36,
                                              height: 36,
                                              child: GetBuilder<UserController>(
                                                  builder: (controller) {
                                                return FutureBuilder(
                                                    future: controller
                                                        .getProfileUrl(widget
                                                            .events.hostID),
                                                    builder:
                                                        (context, snapshot) {
                                                      return CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(snapshot
                                                                    .data ??
                                                                Strings
                                                                    .defaultProfilePhoto2),
                                                      );
                                                    });
                                              }),
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            margin: const EdgeInsets.all(5),
                                            height: 30,
                                            child: Text(
                                              "${weekDayMap[widget.events.date.toDate().weekday]}"
                                              " ${widget.events.date.toDate().day}/${widget.events.date.toDate().month}/${widget.events.date.toDate().year} "
                                              "${widget.events.date.toDate().hour}:${widget.events.date.toDate().minute < 10 ? "0${widget.events.date.toDate().minute}" : widget.events.date.toDate().minute}",
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Color(ProjectColors
                                                      .darkBackground),
                                                  fontFamily:
                                                      FontFamily.sourceSansPro,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            margin: const EdgeInsets.all(10),
                                            child: Text(
                                              widget.events.description,
                                              textAlign: TextAlign.start,
                                              softWrap: true,
                                              style: const TextStyle(
                                                fontSize: 10,
                                                color: Color(ProjectColors
                                                    .darkBackground),
                                                fontFamily:
                                                    FontFamily.sourceSansPro,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ))
                              ],
                            ),
                          )
                        ],
                      )),
                  Expanded(
                      flex: 3,
                      child: InkWell(
                        onTap: () {
                          eventController.openMaps(
                              widget.events.locationsUrl, context);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Expanded(
                              flex: 3,
                              child: Center(
                                  child: Icon(
                                FontAwesomeIcons.mapLocationDot,
                                size: 36,
                              )),
                            ),
                            Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(15)),
                                    color: Color(ProjectColors.gray)),
                                child: const Center(child: Text(Strings.open)),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(left: 10),
                      child: const Text(
                        textAlign: TextAlign.center,
                        Strings.otherGuests,
                        style: TextStyle(
                          fontFamily: FontFamily.sourceSansPro,
                          color: Color(ProjectColors.white),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      height: 24,
                      width: 116,
                      child: Row(
                        children: List.generate(widget.events.guestsIDs.length,
                            (index) {
                          if (index > 3) {
                            return Container();
                          }
                          return FutureBuilder(
                              future: userController.getProfileUrl(
                                  widget.events.guestsIDs[index]),
                              builder: (context, snapshot) {
                                return Container(
                                  width: 24,
                                  height: 24,
                                  margin: const EdgeInsets.only(right: 5),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        snapshot.data ??
                                            Strings.defaultProfilePhoto2),
                                  ),
                                );
                              });
                        }),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: const [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Ver",
                        style: TextStyle(
                            color: Color(ProjectColors.white),
                            fontFamily: FontFamily.sourceSansPro),
                      ),
                      Icon(
                        FontAwesomeIcons.chevronRight,
                        color: Color(ProjectColors.white),
                        size: 24,
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  final weekDayMap = {
    1: "Monday",
    2: "Tuesday",
    3: "Wednesday",
    4: "Thursday",
    5: "Friday",
    6: "Saturday",
    7: "Sunday"
  };
}
