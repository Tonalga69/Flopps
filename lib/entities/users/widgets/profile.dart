import 'package:auth_buttons/auth_buttons.dart';
import 'package:flopps/entities/users/controllers/userController.dart';
import 'package:flopps/entities/users/model.dart';
import 'package:flopps/entities/users/widgets/userSnackBar.dart';
import 'package:flopps/utils/ProjectColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import '../../../utils/Strings.dart';
import '../repositories/authMethod.dart';
import 'package:screenshot/screenshot.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key, required this.padding}) : super(key: key);
  final EdgeInsets padding;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late Future<UserModel?> getData;
  final _screenShotController = ScreenshotController();
  final _textEditingController =
      TextEditingController(text: Strings.writeUserName);
  bool readonly = true;

  @override
  void initState() {
    super.initState();
    getData = UserController.instance.getUserData();
  }

  _takeScreenShot() async {
    final capture = await _screenShotController.capture(pixelRatio: 3);
    if (capture != null) {
      final newImage = XFile.fromData(capture, mimeType: "Image/png");
      Share.shareXFiles([newImage], text: Strings.addMeAsFriend);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData,
      builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data?.userName != null) {
            _textEditingController.value = TextEditingValue(
                text: snapshot.data?.userName ?? Strings.writeUserName);
          }
          if (_textEditingController.value.text
              .contains(Strings.writeUserName)) {}
          return Screenshot(
            controller: _screenShotController,
            child: Container(
              height: 390,
              margin: widget.padding,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color(0xffffffff),
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(-4, -4),
                      blurStyle: BlurStyle.normal),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    height: 120,
                    decoration: const BoxDecoration(
                        color: Color(ProjectColors.strongBlue),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    child: Row(
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          padding: const EdgeInsets.only(
                              right: 30, bottom: 40, top: 20, left: 20),
                          decoration: const BoxDecoration(
                            color: Color(ProjectColors.darkBackground),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(100),
                            ),
                          ),
                          child: Stack(children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  UserController.instance.user.profilePhoto??
                                      Strings.defaultProfilePhoto),
                              radius: 60,
                            ),
                            if (snapshot.data?.authMethod == AuthMethod.google)
                              Visibility(
                                visible: readonly,
                                child: Positioned(
                                    right: -10,
                                    bottom: -10,
                                    child: GoogleAuthButton(
                                      onPressed: () {},
                                      style: const AuthButtonStyle(
                                          iconType: AuthIconType.secondary,
                                          buttonType: AuthButtonType.icon,
                                          iconBackground: Colors.transparent,
                                          buttonColor: Colors.transparent,
                                          width: 24,
                                          height: 24,
                                          padding: EdgeInsets.all(0),
                                          separator: 0,
                                          elevation: 0,
                                          iconSize: 24),
                                    )),
                              )
                            else
                              Visibility(
                                  visible: readonly,
                                  child: const Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Icon(Icons.mail,
                                        color: Color(ProjectColors.blue)),
                                  )),
                            Visibility(
                              visible: !readonly,
                              child: Positioned(
                                  right: -10,
                                  bottom: -10,
                                  child: IconButton(
                                    icon: const Icon(
                                      FontAwesomeIcons.camera,
                                      color: Color(ProjectColors.blue),
                                      size: 24,
                                    ),
                                    onPressed: () {
                                      if (!readonly) {
                                        UserController.instance
                                            .uploadPhoto(context)
                                            .then((value) {
                                          if (value != null) {
                                            setState(() {
                                              snapshot.data?.profilePhoto =
                                                  value;
                                            });
                                          }
                                        });
                                      }
                                    },
                                  )),
                            )
                          ]),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 160,
                                    child: EditableText(
                                      style: const TextStyle(
                                          color: Color(0xffffffff),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "sourceSansPro"),
                                      textAlign: TextAlign.center,
                                      controller: _textEditingController,
                                      focusNode: FocusNode(),
                                      cursorColor:
                                          const Color(ProjectColors.blue),
                                      backgroundCursorColor:
                                          const Color(0xffffffff),
                                      maxLines: 1,
                                      textInputAction: TextInputAction.done,
                                      readOnly: readonly,
                                    ),
                                  ),
                                  Visibility(
                                      visible: !readonly,
                                      child: const Icon(
                                        FontAwesomeIcons.pencil,
                                        color: Color(0xffffffff),
                                        size: 18,
                                      ))
                                ],
                              ),
                              const Padding(padding: EdgeInsets.all(10)),
                              Text.rich(TextSpan(
                                  text: Strings.associatedEmail,
                                  style: const TextStyle(
                                      color: Color(0xffffffff),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: FontFamily.sourceSansPro),
                                  children: [
                                    TextSpan(
                                      text: snapshot.data?.email,
                                      style: const TextStyle(
                                          color: Color(0xffffffff),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: FontFamily.sourceSansPro),
                                    )
                                  ])),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(5)),
                  const Text(
                    Strings.inviteFriend,
                    style: TextStyle(
                      fontFamily: FontFamily.sourceSansPro,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(5)),
                  SizedBox(
                    height: 120,
                    child: SfBarcodeGenerator(
                      barColor: const Color(ProjectColors.darkBackground),
                      textStyle: const TextStyle(fontSize: 10, color: Colors.black),
                      value: snapshot.data?.uid,
                      symbology: QRCode(),
                      showValue: true,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    child: OutlinedButton(
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(
                              text: snapshot.data!.uid,
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        style: ButtonStyle(
                            fixedSize:
                                MaterialStateProperty.all(const Size(160, 19)),
                            side: MaterialStateProperty.all(const BorderSide(
                                color: Color(ProjectColors.grayBackground)))),
                        child: const Text(
                          Strings.copy,
                          style: TextStyle(
                            color: Color(ProjectColors.grayBackground),
                          ),
                        )),
                  ),
                  const Padding(padding: EdgeInsets.all(5)),
                  SizedBox(
                    height: 20,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(ProjectColors.lightBlue)),
                            fixedSize:
                                MaterialStateProperty.all(const Size(160, 20))),
                        onPressed: _takeScreenShot,
                        child: const Text(
                          Strings.share,
                          style: TextStyle(
                            color: Color(0xffffffff),
                          ),
                        )),
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            setState(() {
                              readonly = !readonly;
                              if (readonly &&
                                  !_textEditingController.value.text.contains(
                                      snapshot.data?.userName as Pattern)) {
                                if (_textEditingController
                                        .value.text.isNotEmpty &&
                                    _textEditingController.value.text.length >
                                        7) {
                                  UserController.instance.updateUser(map: {
                                    "userName":
                                        _textEditingController.value.text.trim()
                                  }, context: context);

                                  snapshot.data?.userName =
                                      _textEditingController.value.text.trim();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      genericSnackBar(
                                          Strings.userNameNotValid));
                                }
                              }
                            });
                          },
                          style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(
                                  const Size(100, 30)),
                              side: MaterialStateProperty.all(
                                  const BorderSide(color: Color(0xffffffff))),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(ProjectColors.darkBackground)),
                              shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: readonly
                                ? const [
                                    Icon(
                                      Icons.edit,
                                      color: Color(ProjectColors.white),
                                    ),
                                    Text(Strings.edit, style: TextStyle(
                                        color: Color(ProjectColors.white),
                                        fontFamily: FontFamily.sourceSansPro
                                    ),)
                                  ]
                                : const [
                                    Icon(
                                      Icons.save_as_rounded,
                                      color: Color(ProjectColors.white),
                                    ),
                                    Text(Strings.save, style: TextStyle(
                                      color: Color(ProjectColors.white),
                                      fontFamily: FontFamily.sourceSansPro
                                    ),)
                                  ],
                          ))
                    ],
                  ))
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Container();
        } else {
          return Container();
        }
      },
    );
  }

  var snackBar = const SnackBar(content: Text(Strings.textCopied));
}
