import 'package:flopps/entities/sleepTracker/controllers/tracker_controller.dart';
import 'package:flopps/entities/sleepTracker/wigets/sleepTrackerModule.dart';
import 'package:flopps/utils/ProjectColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SleepTrackerScreen extends StatefulWidget {
  const SleepTrackerScreen({Key? key}) : super(key: key);

  @override
  State<SleepTrackerScreen> createState() => _SleepTrackerScreenState();
}

class _SleepTrackerScreenState extends State<SleepTrackerScreen> with AutomaticKeepAliveClientMixin<SleepTrackerScreen> {
  final _sleepTrackerController= Get.put(TrackerController());
  @override
  Widget build(BuildContext context) {
    super.build(context);
    _sleepTrackerController.onReady();
    return SingleChildScrollView(
      child: Container(
        color: const Color(ProjectColors.darkBackground),
        child: Column(
          children: const [SleepTrackerModule()],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
