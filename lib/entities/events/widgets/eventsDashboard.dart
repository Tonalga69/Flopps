import 'package:flopps/entities/events/widgets/closestEvent.dart';
import 'package:flopps/entities/events/widgets/event_item.dart';
import 'package:flutter/material.dart';

import '../../../utils/ProjectColors.dart';
import '../../../utils/Strings.dart';

class EventsDashboard extends StatefulWidget {
  const EventsDashboard({Key? key}) : super(key: key);

  @override
  State<EventsDashboard> createState() => _EventsDashboardState();
}

class _EventsDashboardState extends State<EventsDashboard> {
  //List of eventsItems with 20 of size
  Set<int> indexSet = {};
  List<EventItem> eventsItems = List.generate(20, (index) =>  const EventItem());

  void addIndexSet(index){

    setState(() {
      indexSet.add(index);
    });

  }

  void removeIndexSet(index){
    setState(() {
      indexSet.remove(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Color(ProjectColors.white),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ClosestEvent(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: eventsItems.length + 1,
              (context, index) {
                if (index == eventsItems.length) {
                  return Container(
                    height: 50,
                    width: double.infinity,
                    alignment: Alignment.center,

                    child:  const Text(
                      Strings.noMoreEvents,
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }
                return eventsItems[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}
