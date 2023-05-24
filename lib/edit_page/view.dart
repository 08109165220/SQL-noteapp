import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynoteapp/customWidgets/noteCard.dart';
import 'package:mynoteapp/homepage/logic.dart';

import 'logic.dart';

class EditPagePage extends StatefulWidget {

  @override
  State<EditPagePage> createState() => _EditPagePageState();
}

class _EditPagePageState extends State<EditPagePage> {
  @override


  final logic = Get.put(EditPageLogic());

  final state = Get
      .find<EditPageLogic>()
      .state;
  // @override
  // void initState() {
  //   if ( logic.noselected == true){
  //    logic.totalList .clear();
  //   }else{ logic.editList[]}
  //
  //   // TODO: implement initState
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          height: Get.height,
          width: Get.width,
          "assets/back.jpeg",
          fit: BoxFit.cover,
        ),

        Scaffold(appBar: AppBar(title: Obx(() {
          return Text(logic.noselected.value==0?"":"${logic.noselected} selected");
        }),),
          backgroundColor: Colors.transparent,
          bottomSheet: ClipRRect(borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            child: Container(height: 60, color: Colors.green,
                child: Row(children: [
                  GestureDetector(
                    child: IconButton(onPressed: () {
                      showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: Text("Delete"),
                            content: Text("are yo sure you want to delete"),
                            actions: [
                              ElevatedButton(onPressed: () {
                                Navigator.pop(context, true);
                              }, child: Text("yes")),
                              ElevatedButton(onPressed: () {
                                Navigator.pop(context, false);
                              }, child: Text("No"))
                            ],
                          );
                        },).then((value) {
                        if (value == true) {
                          logic.deleteNotelist().then((value) {
                            setState(() {

                            });
                          });
                          print("Delete");
                        } else {}
                        return null;
                      });
                    }, icon: Icon(Icons.delete_forever, color: Colors.red),),
                  ),
                  SizedBox(width: 250,),
                  GestureDetector(
                    child: IconButton(onPressed: () {

                    }, icon: Icon(Icons.edit, color: Colors.white,)),
                  )
                ],

                )
            ),
          ),
          body:
          Obx(() {
            return logic.isLoading.value ?
            Center(
                child: CupertinoActivityIndicator())
                : ListView.builder(
              itemCount: logic.totalList.length,
              itemBuilder: (context, index) =>
                  NoteCard(notecardstate: Notecardstate.onEdit,
                      noteModel: logic.totalList[index],
                      onEdit: true),
            );
          }),
        ),
      ],
    );
  }
}
