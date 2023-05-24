import 'dart:async';

import 'package:get/get.dart';
import 'package:mynoteapp/homepage/model.dart';
import 'package:mynoteapp/utils/databases.dart';

import '../constants/imports.dart';
import 'state.dart';

class HomepageLogic extends GetxController {
  final HomepageState state = HomepageState();
  List<NoteModel> NoteModelList = [];
  StreamController<List<NoteModel>> allNoteControllers =
      StreamController<List<NoteModel>>.broadcast();
  Timer? timer;

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      selectAllNotes();
    });
  }

  Future<List<NoteModel>> selectAllNotes() async {

    NoteModelList.clear();
    List result =
        await DB!.rawQuery("SELECT * FROM ${DatabaseConst.noteTable}");

    // lets get the map out of  the result
    result.forEach((element) {
      Map<String, dynamic> resultMap = element;
      NoteModelList.add(NoteModel.fromjson(resultMap));
    });
    allNoteControllers.sink.add(NoteModelList);
    return NoteModelList;
  }
}
