class AddNotesState {
  AddNotesState() {
    ///Initialize variables
  }
}
class catemodel {
  String? id;
  String? categoryname;
  catemodel(
      {  this.id,
         this.categoryname,}
      );
  catemodel.fromjson(Map<String,dynamic> json){

    this.id =json["Id"].toString() ;
    this.categoryname =json["Title"]??"" ;

  }
    ///Initialize variables

}