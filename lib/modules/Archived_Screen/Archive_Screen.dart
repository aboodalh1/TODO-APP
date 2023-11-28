import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/Components.dart';
import '../Cubit/cubit.dart';
import '../Cubit/states.dart';

class Archived extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppState>(
        listener:(context,state){
        },
        builder: (context,state) {
          AppCubit Cubit = AppCubit.get(context);
          return  ConditionalBuilder(
            condition: !Cubit.archivedTasks.isEmpty,
            builder: (context) =>
                ListView.separated(
                  itemBuilder: (context, index) =>
                      dafaultTask(
                          model: Cubit.archivedTasks[index], context: context),
                  separatorBuilder: (context, index) =>
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 25),
                        child: Container(
                          height: 1.0,
                          width: double.infinity,
                          color: Colors.grey[300],
                        ),
                      ),
                  itemCount: Cubit.archivedTasks.length,
                ),
            fallback: (context) =>
                Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.archive,
                          size: 150,
                          color: Theme
                              .of(context)
                              .primaryColor
                              .withOpacity(0.5),
                        ),
                        SizedBox(height: 20,),
                        Text('There isn\'t Archived Tasks yet!',
                          style: TextStyle(
                              fontFamily: 'CoconLight',
                              fontSize: 20,
                              color: Colors.grey,
                              fontWeight: FontWeight.w800

                          ),
                        )],

                    )),
          );

        });

  }
}
