
import 'package:flopps/utils/ProjectColors.dart';
import 'package:flutter/material.dart';

import '../../../utils/Strings.dart';

class AssistantSettings extends StatefulWidget {
  const AssistantSettings({Key? key}) : super(key: key);

  @override
  State<AssistantSettings> createState() => _AssistantSettingsState();
}

class _AssistantSettingsState extends State<AssistantSettings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.all(10),
      height: 244,
      decoration: const BoxDecoration(
        color: Color(ProjectColors.white),
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(5, 0),
              blurStyle: BlurStyle.normal)
        ]
      ),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 112,
                height: 244,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  color: Color(ProjectColors.darkBackground),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(-5, 5),
                        blurStyle: BlurStyle.normal)
                  ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.network(Strings.defaultProfilePhoto),
                    OutlinedButton(
                        onPressed: () {
                        },
                        style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(
                                const Size(100, 30)),
                            side: MaterialStateProperty.all(
                                const BorderSide(color: Color(0x00ffffff))),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(ProjectColors.grayBackground)),
                            shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(50))))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Icon(
                              Icons.edit,
                              color: Color(ProjectColors.white),
                            ),
                            Text(Strings.edit, style: TextStyle(
                                color: Color(ProjectColors.white),
                                fontFamily: FontFamily.sourceSansPro
                            ),)
                          ]
                        )),
                  ],
                )
                ,
              )
            ],
          ),
          Column()
        ],
      ),
    );
  }
}
