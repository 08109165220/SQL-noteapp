import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/sockets/src/socket_notifier.dart';
import 'package:get/get_connect/sockets/src/socket_notifier.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mynoteapp/add_notes/state.dart';
import 'package:mynoteapp/homepage/model.dart';

import '../customWidgets/nocategory.dart';
import '../navigation.dart';
import 'logic.dart';

enum AddNoteStatus { ADD, UPDATE }

enum Addcategory { oncomfirmcate, oncancelcate }

class AddNotesPage extends StatefulWidget {
  AddNotesPage({
    Key? key,
    this.addNoteStatus = AddNoteStatus.ADD,
    this.noteModel,
    this.addCategory = Addcategory.oncomfirmcate,
  }) : super(key: key);
  final AddNoteStatus addNoteStatus;
  final NoteModel? noteModel;
  final Addcategory? addCategory;
  var data;

  @override
  State<AddNotesPage> createState() => _AddNotesPageState();
}

class _AddNotesPageState extends State<AddNotesPage> {
  final logic = Get.put(AddNotesLogic());

  final state = Get.find<AddNotesLogic>().state;

  String get getDate {
    if (widget.addNoteStatus == AddNoteStatus.UPDATE) {
      return "${DateFormat("MMM dd EEE yyyy / h:mm:ss a").format(DateTime.parse(widget.noteModel!.dateTime!))}";
    } else {
      return "${DateFormat("MMM dd EEE yyyy / h:mm:ss a").format(DateTime.now())}";
    }
  }

  @override
  void initState() {
    if (widget.addNoteStatus == AddNoteStatus.UPDATE) {
      logic.titleController.text = widget.noteModel!.title!;
      logic.noteController.text = widget.noteModel!.description!;
    } // TODO: implement initState
    super.initState();
  }

  // @override
  // void dispose() {
  //   setState(() {
  //     logic.allcategoryControllers.close();
  //     // logic.timer!.cancel();
  //     print('timmer have stoped ${logic.timer!.isActive}');
  //   });
  //   // TODO: implement dispose
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.addNoteStatus == AddNoteStatus.ADD) {
          logic.createNotes();
        } else {
          logic.updateNotes(id: int.parse(widget.noteModel!.id!));
        }
        logic.titleController.clear();
        logic.noteController.clear();
        return true;
      },
      child: Scaffold(
        backgroundColor: Color(0xFF010909),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                if (widget.addNoteStatus == AddNoteStatus.ADD) {
                  logic.createNotes().whenComplete(() {
                    Get.back();
                  });
                  logic.titleController.clear();
                  logic.noteController.clear();
                } else {
                  logic
                      .updateNotes(id: int.parse(widget.noteModel!.id!))
                      .whenComplete(() {
                    Get.back();
                  });

                  logic.titleController.clear();
                  logic.noteController.clear();
                }
              },
              icon: const Icon(
                Icons.arrow_back_sharp,
                color: Colors.white,
              )),
          elevation: 0,
          title: Text(
            'Notes',
            style: GoogleFonts.actor(fontSize: 27, color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 17,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(child: Obx(() {
                    return Nocategorybubble(
                      categoryName: logic.selectedCartegory.value,
                      onTap: () async {

                        // logic.startTimer();
                        Map<String, dynamic>? retunsValue =
                            await showModalBottomSheet<Map<String, String>>(
                          constraints: BoxConstraints(
                              minHeight: 400, minWidth: Get.width),
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            logic.selectAllcategory();
                            return Container(
                              height: 500,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20)),
                                  color: Colors.brown),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 10,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 350,
                                    width: Get.width,
                                    child: ListView(
                               physics:BouncingScrollPhysics(),
                                      children: [
                                        ListTile(
                                          leading: Text("ALL Categories",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white)),
                                          trailing: Icon(
                                              Icons.line_style_outlined,
                                              size: 20,
                                              color: Colors.white),
                                        ),
                                        ListTile(
                                          leading: Text("Folder",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white30)),
                                          trailing: Text("MANAGE",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.blue)),
                                        ),

                                        LimitedBox(
                                          maxHeight: Get.height,
                                          child: StreamBuilder<List<catemodel>>(
                                            stream: logic
                                                .allcategoryControllers.stream,
                                            builder: (
                                              context,
                                              snapshot,
                                            ) {
                                              if (snapshot.hasData) {
                                                //List<catemodel>? data = snapshot.data;
                                                // logic.timer;
                                                return ListView.builder(
                                                  padding: EdgeInsets.only(bottom: 20),
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemCount: logic
                                                      .cateModelList.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Wrap(
                                                      children: [
                                                        ListTile(
                                                          leading: Icon(
                                                            Icons
                                                                .folder_copy_outlined,
                                                            color: Colors.white,
                                                            size: 20,
                                                          ),
                                                          title: Text(
                                                            snapshot.data![
                                                                    index]
                                                                .categoryname!,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          trailing: Text(
                                                            snapshot.data![
                                                                    index]
                                                                .id
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context, {
                                                              "id": snapshot.data![
                                                                      index]
                                                                  .id
                                                                  .toString(),
                                                              "Category": snapshot.data![
                                                                      index]
                                                                  .categoryname
                                                            });
                                                          },
                                                        ),
                                                        // Obx(() {
                                                        //   return Visibility(
                                                        //     visible: logic.visibility.value,
                                                        //     child: TextFormField(
                                                        //       decoration: InputDecoration(
                                                        //           enabledBorder: OutlineInputBorder(
                                                        //             borderSide: BorderSide(
                                                        //               color: Color(0xff51FF7A),
                                                        //             ),
                                                        //             borderRadius: BorderRadius.circular(29),
                                                        //           ),
                                                        //           prefixIcon: Icon(
                                                        //             Icons.create_new_folder,
                                                        //             color: Colors.grey,
                                                        //             size: 28,
                                                        //           ),
                                                        //           hintText: "Create category",
                                                        //           fillColor: Color(0xFF2E2E2E),
                                                        //           filled: true,
                                                        //           border: OutlineInputBorder(
                                                        //             borderRadius: BorderRadius.circular(29),
                                                        //             borderSide: BorderSide.none,
                                                        //           )),
                                                        //     ),
                                                        //   );
                                                        // })
                                                      ],
                                                    );
                                                  },
                                                );
                                              } else {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                            },
                                          ),
                                        ),

                                        // SizedBox(
                                        //   height: 10,
                                        // ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () async {
                                        Addcategory? returncategory =
                                            await showDialog<Addcategory>(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text("New folder",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              backgroundColor: Colors.brown,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              actions: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      TextFormField(
                                                        decoration: InputDecoration(
                                                            border:
                                                                UnderlineInputBorder()),
                                                        autofocus: true,
                                                        controller: logic
                                                            .catetitleController,
                                                      ),
                                                      SizedBox(
                                                        height: 35,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          InkWell(
                                                            child: Text(
                                                                "Cancel",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                            onTap: () {
                                                              Navigator.pop(
                                                                context,
                                                                Addcategory
                                                                    .oncancelcate,
                                                              );
                                                            },
                                                          ),
                                                          InkWell(
                                                            child: Text(
                                                                "Comfirm",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blue)),
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context,
                                                                  Addcategory
                                                                      .oncomfirmcate);
                                                            },
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            );
                                          },
                                        );

                                        if (returncategory ==
                                            Addcategory.oncomfirmcate) {
                                          logic.createCategory();
                                        }
                                        // logic.visibility.value=!logic.visibility.value;
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "+ Newfolder",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.blue),
                                            ),
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            );
                          },
                        );
                        logic.selectedCartegory.value =
                            retunsValue!["Category"]!;
                      },
                    );
                  })),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 11,
                ),
                child: TextField(
                  smartDashesType: SmartDashesType.disabled,
                  controller: logic.titleController,
                  autocorrect: true,
                  autofocus: false,
                  style: GoogleFonts.actor(fontSize: 27, color: Colors.white),
                  cursorHeight: 23,
                  cursorWidth: 1,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(
                          fontSize: 27, color: Colors.grey.withOpacity(.4)),
                      hintText: "Title",
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 25,
                  ),
                  Text(
                    getDate,
                    style: TextStyle(
                        fontSize: 16, color: Colors.white.withOpacity(0.9)),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 11, right: 11),
                child: TextField(
                  maxLines: 200,
                  controller: logic.noteController,
                  autofocus: false,
                  smartDashesType: SmartDashesType.disabled,
                  autocorrect: true,
                  style: GoogleFonts.actor(fontSize: 14, color: Colors.white),
                  cursorHeight: 23,
                  cursorWidth: 1,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                      hintText: "Note something down",
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
