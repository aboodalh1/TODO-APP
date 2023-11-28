import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/Components.dart';
import '../Cubit/cubit.dart';
import '../Cubit/states.dart';
class Done extends StatelessWidget {
  const Done({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener:(context,state){},
        builder: (context,state) {
          AppCubit cubit = AppCubit.get(context);
          return ConditionalBuilder(
            condition: !cubit.doneTasks.isEmpty,
            builder: (context) =>
                ListView.separated(
                  itemBuilder: (context, index) =>
                      dafaultTask(
                          model: cubit.doneTasks[index], context: context),
                  separatorBuilder: (context, index) =>
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 25),
                        child: Container(
                          height: 1.0,
                          width: double.infinity,
                          color: Colors.grey[300],
                        ),
                      ),
                  itemCount: cubit.doneTasks.length,
                ),
            fallback: (context) =>
                Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle_rounded,
                          size: 150,
                          color: Theme
                              .of(context)
                              .primaryColor
                              .withOpacity(0.5),
                        ),
                        const SizedBox(height: 20,),
                        const Text('There isn\'t Done Tasks yet!',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey
                            ),
                          )],

                    )),
          );
        });
}


  }
