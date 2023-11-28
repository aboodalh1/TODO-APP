import 'package:flutter/material.dart';
import 'package:newtodo/modules/Cubit/cubit.dart';

Widget defaultButton({
  Color background =Colors.red,
  required String text,
  required Function function,
})=>Container(
  width: double.infinity,

child: MaterialButton(
  onPressed: function()

),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10.0)
  ),


    );
Widget defaultTextForm({
  required Icon icon,
  required String text,
}) =>Container(
  child: TextFormField(
    decoration: InputDecoration(

      prefixIcon: icon,
      label: Text(text),
      border: OutlineInputBorder()
    )
    )
);
Widget dafaultTask({
  required Map model,
  context
}) =>  Dismissible(

  key: UniqueKey() ,
  child:   Padding(
  
    padding: const EdgeInsets.all(20.0),
  
    child: Row(
  
      mainAxisSize: MainAxisSize.min,
  
      children: [
  
        CircleAvatar(
  
          radius: 50,

        
  
          child: Text('${model['time']}',
  
          style: TextStyle(color: Colors.white),),
  
        ),
  
        SizedBox(width: 15,),
  
        Expanded(
  
          child: Column(
  
            mainAxisAlignment: MainAxisAlignment.start,
  
            crossAxisAlignment: CrossAxisAlignment.start,
  
            mainAxisSize: MainAxisSize.min,
  
            children: [
  
              Text('${model['title']}',
  
                maxLines: 2,

                style: TextStyle(



                  fontWeight: FontWeight.bold,

                  fontSize: 20,

                overflow: TextOverflow.ellipsis

              ),
  
              ),
  
              Text('${model['date']}',style: TextStyle(
  
                  fontWeight: FontWeight.normal,
  
                  fontSize: 15,
  
                  color: Colors.grey
  
              ),
  
              ),
  
            ],
  
          ),
  
        ),
  
        SizedBox(width: 60,),
  
        IconButton(
  
          color: Colors.green,
  
            onPressed: (){
  
            AppCubit.get(context).updateData(status: 'done', id: model['id']);
  
            },
  
            icon: Icon(Icons.check_box)),
  
        IconButton(
  
          color: Colors.black45,
  
            onPressed: (){
  
            AppCubit.get(context).updateData(status: 'archive', id: model['id']);
  
            }
  
            , icon: Icon(Icons.archive))

      ],
  
    )),
  onDismissed: (direction){
    AppCubit.get(context).removeData(id: model['id']);
  },
);

