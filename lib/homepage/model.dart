class  NoteModel {
  String? id;
  String? title;
  String? description;
  String? dateTime;
  bool? edit;

  NoteModel({this.id,this.title,this.description,this.dateTime,this.edit=false});

  NoteModel.fromjson(Map<String,dynamic> json){

   this.id =json["Id"].toString() ;
   this.description =json["Description"] ;
   this.title =json["Title"] ;
   this.dateTime =json["Date"] ;
   this.edit=false;
  }
}