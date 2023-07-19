import 'package:flopps/entities/sleepTracker/wigets/sleep_timer.dart';
import 'package:flopps/entities/sleepTracker/wigets/sleepTrackerChart.dart';
import 'package:flopps/utils/ProjectColors.dart';
import 'package:flopps/utils/Strings.dart';
import 'package:flutter/material.dart';
import 'package:switcher_button/switcher_button.dart';

class SleepTrackerModule extends StatefulWidget {
  const SleepTrackerModule({Key? key}) : super(key: key);

  @override
  State<SleepTrackerModule> createState() => _SleepTrackerModuleState();
}

class _SleepTrackerModuleState extends State<SleepTrackerModule> {
  bool trackerActive=true;
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 5),
                spreadRadius: 1,
                blurRadius: 5)
          ],
          color: const Color(ProjectColors.blackBackground),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                Strings.sleepCycle,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: FontFamily.sourceSansPro,
                    color: Color(ProjectColors.white)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 12),
                child: Row(
                  children: [
                     Text(trackerActive? Strings.active: Strings.notActive,
                        style: const TextStyle(
                            fontSize: 16,
                            fontFamily: FontFamily.sourceSansPro,
                            color: Color(ProjectColors.white))),
                    const SizedBox(width: 5),
                    SwitcherButton(
                      value: trackerActive,
                      offColor: const Color(ProjectColors.white),
                      size: 40,
                      onColor:
                      const Color(ProjectColors.blue),
                      onChange: (value) {
                        setState(() {
                          trackerActive=value;
                        });
                      },
                    ),
                  ],
                ),

              )
            ],
          ),
          const SleepTrackerChartMain(),
          const Padding(padding: EdgeInsets.only(top: 10)),
          const  SleepTimer(),

        ],
      ),
    );
  }
}
