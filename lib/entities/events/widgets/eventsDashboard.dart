import 'package:flopps/entities/events/widgets/closestEvent.dart';
import 'package:flutter/material.dart';

import '../../../utils/ProjectColors.dart';

class EventsDashboard extends StatefulWidget {
  const EventsDashboard({Key? key}) : super(key: key);

  @override
  State<EventsDashboard> createState() => _EventsDashboardState();
}

class _EventsDashboardState extends State<EventsDashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 500,
      decoration: const BoxDecoration(
        color: Color(ProjectColors.white),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: ClosestEvent(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
