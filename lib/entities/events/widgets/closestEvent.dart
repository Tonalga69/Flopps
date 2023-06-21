import 'package:flutter/material.dart';

import '../../../utils/ProjectColors.dart';

class ClosestEvent extends StatelessWidget {
  const ClosestEvent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    height: 200,
    margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(ProjectColors.darkBackground),
      ),
    );
  }
}
