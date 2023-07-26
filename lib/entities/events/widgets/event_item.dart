import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../utils/ProjectColors.dart';
import '../../../utils/Strings.dart';

class EventItem extends StatefulWidget {
  const EventItem({super.key});

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  int status = 0;

  void changeStatus(int newStatus, BuildContext context) {
    setState(() {
      status = newStatus;
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomSheetModal = Container(
      height: 205,
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Color(ProjectColors.darkBackground),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      child: Column(
        children: [
          Container(
              height: 3,
              width: 15,
              margin: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color(ProjectColors.white),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              )),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.solidCircleCheck,
              color: Color(ProjectColors.blue),
            ),
            title: const Text(Strings.iWillAssist,
                style: TextStyle(
                    color: Color(ProjectColors.white),
                    fontSize: 12,
                    fontFamily: FontFamily.sourceSansPro)),
            onTap: () {
              changeStatus(1, context);
            },
          ),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.ban,
              color: Colors.red,
            ),
            title: const Text(Strings.iWillNotAssist,
                style: TextStyle(
                    color: Color(ProjectColors.white),
                    fontSize: 12,
                    fontFamily: FontFamily.sourceSansPro)),
            onTap: () {
              changeStatus(2, context);
            },
          ),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.exclamation,
              color: Colors.yellow,
            ),
            title: const Text(Strings.pending,
                style: TextStyle(
                    color: Color(ProjectColors.white),
                    fontSize: 12,
                    fontFamily: FontFamily.sourceSansPro)),
            onTap: () {
              changeStatus(0, context);
            },
          ),
        ],
      ),
    );
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      height: 150,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 7,
            child: Row(
              children: [
                Expanded(
                    flex: 7,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15)),
                              color: const Color(ProjectColors.white),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    offset: const Offset(-3, 3),
                                    spreadRadius: 0,
                                    blurRadius: 0.5)
                              ]),
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
                                          child: const Text(
                                              "Fiesta en la casa de nacho",
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontFamily:
                                                      FontFamily.sourceSansPro,
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
                                          child: const SizedBox(
                                            width: 36,
                                            height: 36,
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  Strings.defaultProfilePhoto2),
                                            ),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.topLeft,
                                          margin: const EdgeInsets.all(5),
                                          height: 30,
                                          child: const Text(
                                            "Sábado 11 de agosto 7:30 pm",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
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
                                          child: const Text(
                                            "jdjnfPQF IEQN C0IW  E F P 0er oer go oer ov ero og ekwo gkoreqweow qowkrg  wrokg e eor geg erogw ",
                                            textAlign: TextAlign.start,
                                            softWrap: true,
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Color(
                                                  ProjectColors.darkBackground),
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
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(15),
                              topRight: Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(-2, 3),
                                spreadRadius: 0,
                                blurRadius: 0.5)
                          ]),
                      child: GestureDetector(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(15)),
                                      color:
                                          Color(ProjectColors.darkBackground)),
                                  child: const Icon(
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
                      ),
                    )),
              ],
            ),
          ),
          Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) => bottomSheetModal);
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      color: const Color(ProjectColors.blackBackground),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(3, 3),
                            spreadRadius: 1,
                            blurRadius: 1)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: eventStatus[status] ?? [],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Map<int, List<Widget>> eventStatus = {
    0: [
      const Center(
          child: Icon(
        FontAwesomeIcons.exclamation,
        size: 36,
        color: Colors.yellow,
      )),
      Center(
          child: Container(
        margin: const EdgeInsets.only(top: 10),
        child: const Text(Strings.pending,
            style: TextStyle(
                color: Color(ProjectColors.white),
                fontSize: 12,
                fontFamily: FontFamily.sourceSansPro)),
      ))
    ],
    1: [
      const Center(
          child: Icon(
        FontAwesomeIcons.solidCircleCheck,
        size: 36,
        color: Color(ProjectColors.blue),
      )),
      Center(
          child: Container(
        margin: const EdgeInsets.only(top: 10),
        child: const Text(Strings.iWillAssist,
            style: TextStyle(
                color: Color(ProjectColors.white),
                fontSize: 12,
                fontFamily: FontFamily.sourceSansPro)),
      ))
    ],
    2: [
      const Center(
          child: Icon(
        FontAwesomeIcons.ban,
        size: 36,
        color: Colors.red,
      )),
      Center(
          child: Container(
        margin: const EdgeInsets.only(top: 10),
        child: const Text(Strings.iWillNotAssist,
            style: TextStyle(
                color: Color(ProjectColors.white),
                fontSize: 12,
                fontFamily: FontFamily.sourceSansPro)),
      ))
    ]
  };
}
