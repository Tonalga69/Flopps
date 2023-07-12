import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/ProjectColors.dart';
import '../../../utils/Strings.dart';

class GetMoreAssistantItem extends StatefulWidget {
  const GetMoreAssistantItem({
    super.key,
  });

  @override
  State<GetMoreAssistantItem> createState() => _GetMoreAssistantItemState();
}

class _GetMoreAssistantItemState extends State<GetMoreAssistantItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 120,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black26.withOpacity(0.1),
                  blurRadius: 1,
                  spreadRadius: 1,
                  offset: const Offset(5, 5))
            ],
            borderRadius: const BorderRadius.all(Radius.elliptical(10, 10)),
            color: const Color(ProjectColors.strongBlue)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              FontAwesomeIcons.plus,
              color: Color(ProjectColors.white),
              size: 48,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              textAlign: TextAlign.center,
              "Get more!",
              style: TextStyle(
                  color: Colors.white, fontFamily: FontFamily.sourceSansPro),
            )
          ],
        ),
      ),
    );
  }
}
