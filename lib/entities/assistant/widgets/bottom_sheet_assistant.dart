import 'package:flopps/entities/assistant/controllers/AssistantController.dart';
import 'package:flopps/entities/assistant/models/model.dart';
import 'package:flopps/entities/assistant/widgets/assistant_item_buttom_sheet.dart';
import 'package:flopps/entities/assistant/widgets/get_more_assistant_item.dart';
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
      height: 250,

      width: double.infinity,
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
            return  Container();
          }
          if (snapshot.hasData) {
            final data= snapshot.data?? List<AssistantModel>.empty();
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 4,
                  width: 20,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(2))
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length+1,
                    itemBuilder: (context, index) {

                      if(index==data.length){
                        return const GetMoreAssistantItem();
                      }
                      return AssistantItem(
                          name: data[index].name,
                          photoUrl: data[index].profilePhoto,
                          onTap: () {
                            assistantController
                                .selectAssistant(data[index].uid);
                            Navigator.pop(context);
                          });
                    },

                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ],
            );
          }
          return const Placeholder();
        },
      ),
    );
  }
}
