import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newtodo/modules/Cubit/cubit.dart';
import 'package:newtodo/modules/Cubit/states.dart';
import '../../shared/components/Components.dart';
import '../../shared/components/constants.dart';

class Tasks extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){},
      builder: (context,state){
        AppCubit Cubit=AppCubit.get(context);
        return ConditionalBuilder(
            condition: !Cubit.newTasks.isEmpty,
            builder: (context)=> ListView.separated(
              itemBuilder: (context,index)=> dafaultTask(model: Cubit.newTasks[index],context: context),
              separatorBuilder:(context,index)=> Padding(
                padding: const EdgeInsetsDirectional.only(start: 25),
                child: Container(
                  height: 1.0,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
              ),
              itemCount: Cubit.newTasks.length,
            ),
            fallback: (context){
              if(!Cubit.newTasks.isEmpty){
                return Center(
                  child: CircularProgressIndicator(),
                );}
              else return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.task_sharp,
                      size: 150,
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
                    SizedBox(height: 20,),
                    Text('There isn\'t Done Tasks yet!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey
                        )),
                  ],
                ),
              );
              },
    );
        },);
  }
}