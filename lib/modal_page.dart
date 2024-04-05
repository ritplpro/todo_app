
import 'data_basehelper.dart';

class  TodoModal{

  int id ;
  String title;
  String subtitle;






  TodoModal({this.id=0,required this.title,required this.subtitle});


  // from Map convert

  factory TodoModal.fromMap(Map<String,dynamic> map){
    return TodoModal(
        id: map[ToDoDataBase.Column_ID],
    title: map[ToDoDataBase.Column_TITLE],
        subtitle:map[ToDoDataBase.Column_DESC]);
  }

 // toMap convert
Map<String,dynamic> toMap(){
    return{
      ToDoDataBase.Column_DESC:subtitle,
      ToDoDataBase.Column_TITLE:title
    };
}



}

