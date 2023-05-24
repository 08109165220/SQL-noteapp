

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mynoteapp/homepage/model.dart';
import 'package:flutter/material.dart';
import '../constants/src/database_const.dart';
import '../utils/databases.dart';
import 'state.dart';

class EditPageLogic extends GetxController {
  final EditPageState state = EditPageState();
  List<NoteModel> totalList = [];
  // var totalList=RxList<NoteModel>();
  List<NoteModel> editList = [];

  var  noselected=1.obs;
  RxInt selection({int i = 1}){
    noselected = i++ as RxInt ;
  return noselected;
  }


  var isLoading=false.obs;
  Future deleteNotelist()async{
    try {
      isLoading.value=true;
      editList.forEach((element) {
        deleteNote( id: int.parse(element.id!));
      });
      Get.showSnackbar(GetSnackBar(
        icon: Icon(Icons.delete_forever),
        isDismissible: true,barBlur: 12,
        duration: Duration(seconds: 2),
        animationDuration: Duration(seconds: 2),
        forwardAnimationCurve: Curves.bounceOut,
        title: "Deleted",
        message: "You have successfully deleted this note",
        backgroundColor: Colors.green,
      ));
      isLoading.value=false;
      editList.clear();
    } on Exception catch (e) {
      isLoading.value=false;
      Get.showSnackbar(GetSnackBar(
        icon: Icon(Icons.delete_forever),
        isDismissible: true,duration: Duration(seconds: 2),
        animationDuration: Duration(seconds: 2),
        forwardAnimationCurve: Curves.bounceOut,
        title: "Deleted",
        message: "You have successfully deleted this note",barBlur: 12,
      ));
      // TODO
    }
  }
  Future<void> deleteNote({ required int id}) async {

    try {
      await DB!.execute(
        "DELETE FROM ${DatabaseConst.noteTable} WHERE ${DatabaseConst
            .noteId} = ?",
        [id],
      );
      // editList.removeWhere((element) {
      //   return element.id== id.toString();
      // });
      totalList.removeWhere((element) {
        return element.id== id.toString();
      });
      print("$id is deleted");



      print("Todo item deleted with ID: $id");
    } catch (e) {
      print("Failed to delete todo item with ID: $id. Error: $e");
      // Handle the exception
    }
  }

}
