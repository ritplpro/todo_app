




CheckboxListTile(
controlAffinity: ListTileControlAffinity.leading,
tileColor: tData[index].isCompleted ? Colors.green.shade400:Colors.grey.shade200,
value:tData[index].isCompleted,
onChanged: (value){
setState(() {
//blank

});
},
title: Text(tData[index].title,style: TextStyle(
decoration:tData[index].isCompleted ? TextDecoration.lineThrough :TextDecoration.none,
),),
subtitle: Text(tData[index].subtitle,style: TextStyle(
decoration:tData[index].isCompleted ? TextDecoration.lineThrough :TextDecoration.none,
),),

);