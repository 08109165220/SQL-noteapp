import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mynoteapp/constants/imports.dart';
import 'package:mynoteapp/utils/databases.dart';

import '../homepage/model.dart';
import 'state.dart';

class AddNotesLogic extends GetxController {
  final AddNotesState state = AddNotesState();
  List<catemodel> cateModelList = [];

  // List<catemodel> modellist = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController catetitleController = TextEditingController();
  var isCreateNotes = true.obs;

  // var visibility = false.obs;
  var selectedCartegory = "No category".obs;

  StreamController<List<catemodel>> allcategoryControllers =
      StreamController<List<catemodel>>.broadcast();
  // Timer? timer;

  // startTimer() {
  //   timer = Timer.periodic(Duration(seconds: 1), (timer) {
  //     selectAllcategory();
  //   });
  // }

  Future<void> createNotes() async {
    if (titleController.text.isNotEmpty || noteController.text.isNotEmpty) {
      // String dateTime=  DateFormat("mm:ss a").format(DateTime.now());
      String dateTime = DateTime.now().toString();

      DB!.execute(
          "INSERT INTO ${DatabaseConst.noteTable} (${DatabaseConst.noteTitle},${DatabaseConst.cateId},${DatabaseConst.noteDescription}, ${DatabaseConst.noteDateTime}) VALUES(?,?,?,?)",
          [
            titleController.text.isEmpty ? "" : titleController.text,
            0,
            noteController.text.isEmpty ? "" : noteController.text,
            dateTime
          ]).whenComplete(() {
        print('done inserting into ${DatabaseConst.noteTable}');
        titleController.clear();
        noteController.clear();

        selectAllNotes();
      });
    }
  }

  Future<void> updateNotes({required int id}) async {
    DB!.execute(
        "UPDATE ${DatabaseConst.noteTable} SET ${DatabaseConst.noteTitle} = ?,${DatabaseConst.cateId} = ?,${DatabaseConst.noteDescription} = ? WHERE ${DatabaseConst.noteId} = ?",
        [
          titleController.text,
          0,
          noteController.text,
          id
        ]).whenComplete(() => print('updated successfully '));
  }

  Future<void> selectAllNotes() async {
    var result = await DB!.rawQuery("SELECT * FROM ${DatabaseConst.noteTable}");
    print('result $result');
  }

  Future<void> createCategory() async {
    // String dateTime=  DateFormat("mm:ss a").format(DateTime.now());
    String dateTime = DateTime.now().toString();

    DB!.execute(
        "INSERT INTO ${DatabaseConst.categoryTable} (${DatabaseConst.categoryTitle},${DatabaseConst.categoryDateTime}) VALUES(?,?)",
        [catetitleController.text, dateTime]).whenComplete(() {
          selectAllcategory();
      print('done inserting into ${DatabaseConst.categoryTable}');

      catetitleController.clear();

      selectAllcategory();
    });
  }

  Future<List<catemodel>> selectAllcategory() async {
    cateModelList.clear();
    var result =
        await DB!.rawQuery("SELECT * FROM ${DatabaseConst.categoryTable}");
    print('result $result');

    for (var element in result) {
      Map<String, dynamic> resultMap = element;
      cateModelList.add(catemodel.fromjson(resultMap));
    }
    allcategoryControllers.sink.add(cateModelList);
    return cateModelList;
  }

// List<catemodel> modellist = [
//
//   catemodel(id: 12, categoryname: "vic"),
//   catemodel(id: 15, categoryname: "major"),
//   catemodel(id: 20, categoryname: "general"),
//   catemodel(id: 35, categoryname: "virge"),
//   catemodel(id: 18, categoryname: "unlimited"),
//   catemodel(id: 20,categoryname: "vicrory"),
//
// ];

}
