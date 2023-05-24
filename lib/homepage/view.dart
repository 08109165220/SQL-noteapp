import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mynoteapp/add_notes/view.dart';
import 'package:mynoteapp/customWidgets/noteCard.dart';
import 'package:mynoteapp/edit_page/logic.dart';
import 'package:mynoteapp/edit_page/view.dart';
import 'package:mynoteapp/homepage/model.dart';

import '../search_screen/logic.dart';
import '../search_screen/view.dart';
import '../to_do/view.dart';
import 'logic.dart';

class HomepagePage extends StatefulWidget {
  HomepagePage({Key? key}) : super(key: key);

  @override
  State<HomepagePage> createState() => _HomepagePageState();
}

class _HomepagePageState extends State<HomepagePage> {
  final logic = Get.put(HomepageLogic());

  final state = Get.find<HomepageLogic>().state;
  int selectedIndex = 0;
  bool isSelected = false;
  final logicEdit = Get.put(EditPageLogic());
  final logicSearch = Get.put(SearchScreenLogic());
  @override
  initState() {
    logic.startTimer();

    super.initState();
  }

  @override
  void dispose() {
    setState(() {
      logic.timer!.cancel();
      print('timmer have stoped ${logic.timer!.isActive}');
    });
    // TODO: implement dispose
    super.dispose();
  }

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
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SizedBox(
            height: Get.height,
            width: Get.width,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverPadding(
                  padding: EdgeInsets.all(8),
                  sliver: SliverList(
                      delegate: SliverChildListDelegate([
                    SizedBox(
                      height: 54,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 14,
                        ),
                        Text(
                          "All notes",
                          style: GoogleFonts.actor(
                              fontSize: 40, color: Colors.white),
                        ),
                        IconButton(
                          color: Colors.grey,
                          onPressed: () {},
                          icon: Icon(Icons.arrow_drop_down_sharp),
                        )
                      ],
                    ),
                    SizedBox(height: 23),

                    Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: InkWell(
                        onTap: () {
                          logicSearch.totalList =logic.NoteModelList;
                          Get.to(SearchScreenPage());
                        },
                        child: IgnorePointer(ignoring: true,
                          child: TextFormField(
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xff51FF7A),
                                  ),
                                  borderRadius: BorderRadius.circular(29),
                                ),
                                prefixIcon: Icon(
                                  Icons.search_rounded,
                                  color: Colors.grey,
                                  size: 28,
                                ),
                                hintText: "Search for notes",
                                fillColor: Color(0xFF2E2E2E),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(29),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ])),
                )
              ],
              body: StreamBuilder<List<NoteModel>>(
                  stream: logic.allNoteControllers.stream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => GestureDetector(
                            onLongPress: () {
                              logicEdit.totalList =snapshot.data!;
                              logicEdit.editList.add(snapshot.data![index]);
                              /// w3e print this out to know the number of elements in the list
                              logicEdit.editList.forEach((element) { print  ("elemnttos "+element.title!);});
                           //
                              snapshot.data![index].edit=true;
                              logicEdit.editList.forEach((element) {print("index=${element.id}");});
                              logicEdit.noselected.value=1;
                              Get.to(() => EditPagePage());
                            },

                          child: NoteCard(
                              noteModel: snapshot.data![index],
                              noteModelList: snapshot.data!),
                        ),
                        itemCount: snapshot.data!.length,
                      );
                    } else {
                      return Center(child: Icon(Icons.hourglass_empty));
                    }
                  }),
            ),
          ),
        ),
      ],
    );
  }
}
