import 'package:flopps/utils/ProjectColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class FloatingActionButtonEvents extends StatelessWidget {
  const FloatingActionButtonEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return  SpeedDial(
      animatedIcon: AnimatedIcons.menu_arrow,
      animatedIconTheme: const IconThemeData(size: 22.0, color: Colors.white),
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      children: [
        SpeedDialChild(
          child: const Icon(FontAwesomeIcons.plus),
          backgroundColor: const Color(ProjectColors.strongBlue),
          onTap: () => null,
          label: 'Add Event',
          labelStyle: const TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: const Color(ProjectColors.blackBackground),
        ),
        SpeedDialChild(
          child: const Icon(FontAwesomeIcons.calendar),
          backgroundColor: const Color(ProjectColors.strongBlue),
          onTap: () => null,
          label: 'Show Calendar',
          labelStyle: const TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: const Color(ProjectColors.blackBackground),
        ),
      ],
    );
  }
}
