import 'package:get/get.dart';

import '../homepage/model.dart';
import 'state.dart';

class SearchScreenLogic extends GetxController {
  final SearchScreenState state = SearchScreenState();
  List<NoteModel> totalList = [];
  var searchList = RxList<NoteModel>();
  var isLoading = false.obs;

  Future SearchNote({
    required String searchText,
  }) async {
    searchList.value = totalList
        .where((noteModel) =>
            noteModel.title!.toLowerCase().contains(searchText.toString()) ||
            noteModel.title!.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
  }
}
