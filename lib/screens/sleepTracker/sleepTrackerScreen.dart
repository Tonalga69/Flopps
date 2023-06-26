import 'package:flopps/entities/sleepTracker/wigets/sleepTrackerModule.dart';
import 'package:flopps/utils/ProjectColors.dart';
import 'package:flutter/material.dart';

class SleepTrackerScreen extends StatefulWidget {
  const SleepTrackerScreen({Key? key}) : super(key: key);

  @override
  State<SleepTrackerScreen> createState() => _SleepTrackerScreenState();
}

class _SleepTrackerScreenState extends State<SleepTrackerScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: const Color(ProjectColors.darkBackground),
        child: Column(
          children: const [SleepTrackerModule()],
        ),
      ),
    );
  }
}
