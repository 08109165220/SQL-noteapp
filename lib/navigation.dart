import 'package:animations/animations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter/material.dart';

import 'add_notes/view.dart';
import 'homepage/view.dart';
import 'to_do/view.dart';

class NavigationPage extends StatefulWidget {
  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int selected_Index = 0;
  List<Widget> slide = [HomepagePage(), To_doPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: slide[selected_Index],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.1,
        iconSize: 19.0,
        type: BottomNavigationBarType.fixed,
        currentIndex: selected_Index,
        onTap: (value) {
          setState(() {
            selected_Index = value;
          });
        },
        selectedItemColor: Color(0xFF51FF7A),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.vertical_split_sharp,
                color: Colors.white,
                semanticLabel: "Notes",
              ),
              label: "Notes",
              activeIcon: Icon(
                Icons.vertical_split_sharp,
                color: Color(0xFF51FF7A),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.check_circle_outlined,
                color: Colors.white,
                semanticLabel: "To do",
              ),
              label: "To do",
              activeIcon: Icon(
                Icons.check_circle,
                color: Color(0xFF51FF7A),
              )),
        ],
        backgroundColor: const Color(0xFF2E2E2E),
      ),
      floatingActionButton: GestureDetector(
          onTap: () {
            Get.to(AddNotesPage(addNoteStatus: AddNoteStatus.ADD),
                transition: Transition.rightToLeft);
          },
          child: OpenContainer(
            closedBuilder: (context, action) => CircleAvatar(
              radius: 30,
              backgroundColor: Color(0xFF114D1F),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            openBuilder: (context, action) =>
                AddNotesPage(addNoteStatus: AddNoteStatus.ADD),closedColor: Color(0xFF114D1F) ,
            closedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(3000))),
            transitionDuration: Duration(seconds: 1),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
