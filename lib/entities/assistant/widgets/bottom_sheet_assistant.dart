import 'package:flopps/entities/assistant/controllers/AssistantController.dart';
import 'package:flopps/entities/assistant/widgets/assistant_item_buttom_sheet.dart';
import 'package:flopps/utils/ProjectColors.dart';
import 'package:flopps/utils/Strings.dart';
import 'package:flutter/material.dart';

class BottomSheetAssistant extends StatefulWidget {
  const BottomSheetAssistant({Key? key}) : super(key: key);

  @override
  State<BottomSheetAssistant> createState() => _BottomSheetAssistantState();
}

class _BottomSheetAssistantState extends State<BottomSheetAssistant> {
  AssistantController assistantController = AssistantController.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
        color: Color(ProjectColors.darkBackground),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      child: FutureBuilder(
        future: assistantController.getOwnedAssistants(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text(
              "Something went wrong",
              style: TextStyle(
                  color: Colors.white, fontFamily: FontFamily.sourceSansPro),
            );
          }
          if (!snapshot.hasData) {
            return const Text(
              "Error, you shoud have at least one assistant, please contact support",
              style: TextStyle(
                  color: Colors.white, fontFamily: FontFamily.sourceSansPro),
            );
          }
          if (snapshot.hasData) {
            return Column(
              children: [
                ListView.builder(
                  itemBuilder: (context, index) {
                    return AssistantItem(
                        name: snapshot.data?[index].name,
                        photoUrl: snapshot.data?[index].profilePhoto,
                        onTap: () {
                          assistantController
                              .selectAssistant(snapshot.data?[index].uid ?? "Initial");
                        });
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data?.length,
                ),
                const Padding(padding: EdgeInsets.all(5)),
                OutlinedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Color(ProjectColors.blue)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))))),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Close",
                      style: TextStyle(
                          fontFamily: FontFamily.sourceSansPro,
                          color: Colors.white),
                    ))
              ],
            );
          }
          return const Placeholder();
        },
      ),
    );
  }
}
