import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../utils/ProjectColors.dart';
import '../../../utils/Strings.dart';

class ClosestEvent extends StatelessWidget {
  ClosestEvent({Key? key}) : super(key: key);

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
              child: event,
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
                        children: List.generate(
                            4,
                            (index) => Container(
                                  width: 24,
                                  height: 24,
                                  margin: const EdgeInsets.only(right: 5),
                                  child: const CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        Strings.defaultProfilePhoto2),
                                  ),
                                )),
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

  final event = Row(
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
                                  color: Color(ProjectColors.strongBlue)),
                              child: Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(left: 60),
                                child: const Text("Fiesta en la casa de nacho",
                                    softWrap: true,
                                    style: TextStyle(
                                        fontFamily: FontFamily.sourceSansPro,
                                        fontSize: 12)),
                              ),
                            ),
                            Container(
                              width: 60,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(50)),
                                  color: Color(ProjectColors.blue)),
                              child: Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(right: 7),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                      color:
                                          Color(ProjectColors.darkBackground),
                                      fontFamily: FontFamily.sourceSansPro,
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
                                    color: Color(ProjectColors.darkBackground),
                                    fontFamily: FontFamily.sourceSansPro,
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
          child: GestureDetector(
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
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(15)),
                        color: Color(ProjectColors.gray)),
                    child: const Center(child: Text(Strings.open)),
                  ),
                ),
              ],
            ),
          )),
    ],
  );
}
