import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../customWidgets/noteCard.dart';
import 'logic.dart';

class SearchScreenPage extends StatefulWidget {
  SearchScreenPage({Key? key}) : super(key: key);

  @override
  State<SearchScreenPage> createState() => _SearchScreenPageState();
}

class _SearchScreenPageState extends State<SearchScreenPage> {
  final logic = Get.put(SearchScreenLogic());

  final state = Get
      .find<SearchScreenLogic>()
      .state;

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

          body:
          Obx(() {
            return logic.isLoading.value ?
            Center(
                child: CupertinoActivityIndicator())
                : Column(
              children: [
                SizedBox(height: kToolbarHeight,),
                Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18),
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
                    onChanged: (value) {
                      logic.SearchNote(searchText: value).then((value) {
                        setState(() {

                        });
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Obx(() {
                    return logic.searchList.value.length==0
                    ?Center(child: Icon(CupertinoIcons.search_circle,color: Colors.white,size: 100),)
          :ListView.builder(
                      itemCount: logic.searchList.length,
                      itemBuilder: (context, index) =>
                          NoteCard(
                            noteModelList: logic.searchList.value,
                              noteModel:logic.searchList.value [index],
                              // notecardstate: Notecardstate.onEdit,
                              // noteModel: logic.searchList[index],
                              // onEdit: false
                          ),
                    )
                    ;
                  }),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}
