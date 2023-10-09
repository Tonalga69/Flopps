import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/ProjectColors.dart';
import '../../../utils/Strings.dart';

class SenderWidget extends StatefulWidget {
  const SenderWidget({super.key});

  @override
  State<SenderWidget> createState() => _SenderWidgetState();
}

class _SenderWidgetState extends State<SenderWidget> {
  bool isNotEmpty = false;
  IconData icon = Icons.text_fields;
  double height = 60;
  double maxHeight = 150;


  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: height,
        maxHeight: maxHeight,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(ProjectColors.grayBackground),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  maxLines: null,
                  style: const TextStyle(
                    color: Color(ProjectColors.white),
                    fontFamily: FontFamily.sourceSansPro,
                    fontSize: 14,
                  ),
                  onChanged: (value) {
                    setState(() {
                      isNotEmpty = value.isNotEmpty;
                    });
                  },
                  autofocus: false,
                  focusNode: FocusNode(),
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                        onTap: () {},
                        child: const Icon(
                          size: 24,
                          FontAwesomeIcons.paperclip,
                          color: Color(ProjectColors.white),
                        ),
                      ),

                    hintText: Strings.typeHere,
                    hintStyle:  TextStyle(
                      color: const Color(ProjectColors.white).withOpacity(0.8),
                    ),
                    prefixIcon: DropdownButton<IconData>(
                      onChanged: (value) {
                        setState(() {
                          icon = value!;
                        });
                      },

                      value: icon,
                      selectedItemBuilder: (BuildContext context) {
                        return outputType.entries.map((map) {
                          return Row(

                            children: [
                              const Padding(padding: EdgeInsets.all(4.0)),
                              Icon(
                                outputType[map.key],
                                color: const Color(ProjectColors.strongBlue),
                              ),
                              const Padding(padding: EdgeInsets.all(4.0)),
                            ],
                          );
                        }).toList();
                      },
                      underline: Container(),
                      items: outputType.entries.map((map) {
                        return DropdownMenuItem<IconData>(
                          value: map.value,
                          child: Row(
                            children: [
                              Icon(
                                outputType[map.key],
                                color: const Color(ProjectColors.strongBlue),
                                size: 18,
                              ),
                              const Padding(padding: EdgeInsets.all(3.0)),
                              Text(
                                map.key,
                                style: const TextStyle(
                                  color: Color(ProjectColors.strongBlue),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
              Visibility(
                visible: isNotEmpty,
                maintainAnimation: true,
                maintainState: true,
                replacement: Container(),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    FontAwesomeIcons.solidPaperPlane,
                    size: 24,
                    color: Color(ProjectColors.strongBlue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Map<String, IconData> outputType = {
  "text": Icons.text_fields,
  "image": Icons.image,
  "audio": Icons.multitrack_audio,
};
