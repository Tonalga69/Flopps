import 'package:flutter/material.dart';

import '../../entities/events/widgets/eventsDashboard.dart';
import '../../utils/ProjectColors.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(ProjectColors.darkBackground),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Expanded(flex: 60, child: EventsDashboard()),
            ],
          ),
        ],
      ),
    );
  }
}
