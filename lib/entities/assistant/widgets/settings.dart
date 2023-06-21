import 'package:flopps/entities/assistant/controllers/AssistantController.dart';
import 'package:flopps/entities/assistant/widgets/styles.dart';
import 'package:flopps/utils/ProjectColors.dart';
import 'package:flutter/material.dart';
import '../../../utils/Strings.dart';

class AssistantSettings extends StatefulWidget {
  const AssistantSettings({Key? key}) : super(key: key);

  @override
  State<AssistantSettings> createState() => _AssistantSettingsState();
}

class _AssistantSettingsState extends State<AssistantSettings> {
  final AssistantController _assistantController = AssistantController.instance;
  bool overlayPermission = false,
      notificationPermission = false,
      microphonePermission = false;

  setPermission() async {
    overlayPermission = await _assistantController.getOverlayPermission();
    notificationPermission =
        await _assistantController.getNotificationPermission();
    microphonePermission = await _assistantController.getMicroPhonePermission();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: setPermission(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Container(
          margin: const EdgeInsets.all(10),
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
              ]),
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
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(Strings.yourAssistant,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(ProjectColors.white),
                                fontFamily: FontFamily.sourceSansPro,
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                        const Padding(padding: EdgeInsets.all(10)),
                        const CircleAvatar(
                            radius: 45,
                            backgroundImage:
                                NetworkImage(Strings.defaultProfilePhoto)),
                        const Padding(padding: EdgeInsets.all(5)),
                        const Text("Smile-less",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(ProjectColors.blue),
                                fontFamily: FontFamily.sourceSansPro,
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                        const Padding(padding: EdgeInsets.all(10)),
                        OutlinedButton(
                            onPressed: () {},
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Icon(
                                    Icons.edit,
                                    color: Color(ProjectColors.white),
                                  ),
                                  Text(
                                    Strings.edit,
                                    style: TextStyle(
                                        color: Color(ProjectColors.white),
                                        fontFamily: FontFamily.sourceSansPro),
                                  )
                                ])),
                      ],
                    ),
                  )
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(Strings.active,
                            style: TextStyle(
                                fontFamily: FontFamily.sourceSansPro,
                                color: Color(ProjectColors.blackBackground))),
                        Switch(
                          value: true,
                          trackColor: const MaterialStatePropertyAll(
                              Color(ProjectColors.lightBlue)),
                          onChanged: (value) {},
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(padding: EdgeInsets.all(1)),
                        const Text(Strings.readNotifications,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: FontFamily.sourceSansPro,
                                color: Color(ProjectColors.blackBackground))),
                        OutlinedButton(
                            onPressed: () async {
                              final result = await _assistantController
                                  .getNotificationPermission();
                              setState(() {
                                notificationPermission = result;
                              });
                            },
                            style: enableButtonStyle,
                            child: Text(
                              notificationPermission
                                  ? Strings.enable
                                  : Strings.unable,
                              style: enableTextStyle,
                            )),
                        const Padding(padding: EdgeInsets.all(1)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(padding: EdgeInsets.all(1)),
                        const Text(Strings.overlayApp,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: FontFamily.sourceSansPro,
                                color: Color(ProjectColors.blackBackground))),
                        OutlinedButton(
                            onPressed: () async {
                              final result = await _assistantController
                                  .requestOverlayPermission();
                              setState(() {
                                overlayPermission = result;
                              });
                            },
                            style: enableButtonStyle,
                            child: Text(
                              overlayPermission
                                  ? Strings.enable
                                  : Strings.unable,
                              style: enableTextStyle,
                            )),
                        const Padding(padding: EdgeInsets.all(1)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(padding: EdgeInsets.all(1)),
                        const Text(Strings.activeVoiceListening,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: FontFamily.sourceSansPro,
                                color: Color(ProjectColors.blackBackground))),
                        OutlinedButton(
                            onPressed: () async {
                              final result = await _assistantController
                                  .requestMicrophonePermission();
                              setState(() {
                                microphonePermission = result;
                              });
                            },
                            style: enableButtonStyle,
                            child: Text(
                              microphonePermission
                                  ? Strings.enable
                                  : Strings.unable,
                              style: enableTextStyle,
                            )),
                        const Padding(padding: EdgeInsets.all(1)),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
