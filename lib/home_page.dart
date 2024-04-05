import 'package:flutter/material.dart';
import 'package:todo_app/data_basehelper.dart';
import 'package:todo_app/modal_page.dart';
import 'dart:core';

class ToHomePage extends StatefulWidget {
  const ToHomePage({super.key});

  @override
  State<ToHomePage> createState() => _ToHomePageState();
}

class _ToHomePageState extends State<ToHomePage> {
  ToDoDataBase? TodoData;

  var titleController=TextEditingController();
  var subtitleController=TextEditingController();
  List<TodoModal>  tData=[];






   Future<void> getData()async{
     tData=await TodoData!.fetchAllData();
    setState(() {

    });

  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    TodoData=ToDoDataBase.TodoData;
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body:ListView.builder(
        itemCount: tData.length,
          itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color:Theme.of(context).colorScheme.inversePrimary,
              borderRadius: BorderRadius.only(topRight: Radius.circular(23),
                  bottomLeft: Radius.circular(23)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 1,
                  color: Colors.grey,
                )
              ]
            ),
            child: ListTile(
                title: Text(tData[index].title),
                subtitle: Text(tData[index].subtitle),
                leading: Text("${index+1}"),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(onPressed: (){
                      setState(() {

                        showModalBottomSheet(context: context,
                            builder: (context){
                              return bottomBar(isUpdated:true,upIndex:tData[index].id);
                            });

                        getData();

                      });
                    }, icon: Icon(Icons.edit)),
                    IconButton(onPressed: (){
                      setState(() {

                        TodoData!.deleteData(tData[index].id);

                        getData();


                      });


                    }, icon: Icon(Icons.delete)),
                  ],
                ),
              ),

              ),
          ),
        );

          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        hoverColor:Colors.blue,
        onPressed: (){
          titleController.clear();
          subtitleController.clear();

          showModalBottomSheet(context: context,
              builder: (context){
            return bottomBar();
         });
          getData();


        },child: Icon(Icons.add),),

    );
  }

  Widget bottomBar({bool isUpdated=false,int upIndex=-1 }){
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(isUpdated ? 'Update ToDo' :"Add ToDo",style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 10),
            Row(
              children: [
                Text('Enter Title Name',style: TextStyle(
                    fontWeight: FontWeight.w700
                ),),
              ],
            ),
            SizedBox(height: 10),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)
                  )
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text('Enter Subtitle',style: TextStyle(
                    fontWeight: FontWeight.w700
                )),
              ],
            ),
            SizedBox(height: 10),
            TextField(
              controller: subtitleController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)
                  )
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: (){

                  setState(() {
                    if(isUpdated!=true){
                      TodoData!.insertData(TodoModal(title: titleController
                          .text.toString(),
                          subtitle: subtitleController.text.toString()));
                      getData();

                    }else {

                      TodoData!.updateData(TodoModal(title:titleController
                          .text.toString(),
                          subtitle: subtitleController.text.toString(),
                          id: upIndex));
                      getData();
                    }



                  });
                  Navigator.pop(context);
                }, child:Text(isUpdated ? 'Update ToDo' :"Add ToDo")),
                ElevatedButton(onPressed: (){
                  setState(() {
                    Navigator.pop(context);
                  });
                }, child:Text('Cancel ')),
              ],
            )
          ],
        ),
      ),
    );
  }

}
