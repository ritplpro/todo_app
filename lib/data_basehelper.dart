import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/modal_page.dart';

class ToDoDataBase{

  ToDoDataBase._();

  static final ToDoDataBase  TodoData=ToDoDataBase._();

  static const String Table_NAME="Todo_Note";
  static const String Column_TITLE="Note_title";
  static const String Column_DESC="Note_subtitle";
  static const String Column_ID="Note_id";


  Database? toDoDB;

  getDataBase() async {
    if(toDoDB!=null){
      return toDoDB;
    }else{
      var toDoDB= await initDatabase();
      return await toDoDB;
    }
  }

  initDatabase() async {
    var  createpath=await getApplicationDocumentsDirectory();
    var actualPath=join(createpath.path,"Todo.db");
    return await openDatabase(actualPath,version: 1,onCreate: (TodoData,version){
      TodoData?.execute("create table $Table_NAME($Column_ID  integer primary key "
          "autoincrement,$Column_TITLE text,$Column_DESC text )");
    });
  }

  // insert data in Database...

    insertData(TodoModal newNote) async {
    var idata=await getDataBase();
    idata.insert(Table_NAME,newNote.toMap());
}

  // Fetch data(get data ) in Database...

  Future<List<TodoModal>> fetchAllData() async {
    var fedata=await getDataBase();
    var fetvch=await fedata.query(Table_NAME);

    List<TodoModal> tData=[];

    for(Map<String,dynamic> eachModal in fetvch){
      var allData=TodoModal.fromMap(eachModal);
      tData.add(allData);
    }
    return tData;

  }

// update data in Database...

    updateData(TodoModal toNote) async {
    var udata=await getDataBase();
    udata.update(Table_NAME,toNote.toMap(),where:"$Column_ID = ${toNote.id}");

}

// Delete data in Database...

deleteData(int id) async {
  var dData=await getDataBase();
  dData.delete(Table_NAME,where:"$Column_ID=?",whereArgs:["$id"]);

}


}