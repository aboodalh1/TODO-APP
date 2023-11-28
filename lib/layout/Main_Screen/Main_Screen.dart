import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:newtodo/modules/Cubit/cubit.dart';
import 'package:newtodo/modules/Cubit/states.dart';
import '../../modules/Archived_Screen/Archive_Screen.dart';
import '../../modules/Done_Screen/Done_Screen.dart';
import '../../modules/Title_Screen/Title_Screen.dart';
class MainScreen extends StatelessWidget {
  var scaffoldKey=GlobalKey<ScaffoldState>();
  List<Widget> a = [
    Tasks(),
    Done(),
    Archived(),
  ];
  var TitleController = TextEditingController();
  var DateController = TextEditingController();
  var TimeController = TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>AppCubit()..createDataBase(),
      child: BlocConsumer <AppCubit,AppState>(
      listener: ( context, state){
        if(state is InsertToDataBaseState) Navigator.pop(context);
      },
        builder: (context,  state){
          AppCubit Cubit=AppCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
              title: Text(
                'To Do App',
                style: TextStyle(
                  fontFamily: 'CoconLight',

                ),
              ),
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
              ]),
          body: ConditionalBuilder(
            condition: state is GetDataBaseLoadingState,
            builder: (context)=> Center(child: CircularProgressIndicator(),),
            fallback: (context) =>   Container(
              child: a[Cubit.currentIndex],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(

            currentIndex: Cubit.currentIndex,
            onTap: (index) {
              Cubit.changeBottomNavBar(index);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.title), label: 'New'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_rounded), label: 'Done'),
              BottomNavigationBarItem(icon: Icon(Icons.archive), label: 'Done')
            ],

          ),

          floatingActionButton: Padding(
            padding: const EdgeInsets.fromLTRB(20,10,20,30),
            child: FloatingActionButton(
                child: Cubit.floatingIcon,
                onPressed: (){

                  if(!Cubit.isBottomSheetShown) {
                      scaffoldKey.currentState!.showBottomSheet((context) {
                        Cubit.showBottomSheet(
                            isBottomSheetShown: true,
                            floatingIcon: Icon(Icons.add));
                        return Form(
                          key: formKey,
                          child: Container(
                            color: Colors.grey[100],
                            height: 300,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 40),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: [
                                  TextFormField(

                                    onFieldSubmitted: (String value) {
                                      if (formKey.currentState!.validate()) {}
                                    },

                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Title must not be empty";
                                      }
                                      else
                                        return null;
                                    },
                                    controller: TitleController,
                                    decoration: InputDecoration(
                                      fillColor: Colors.grey,

                                      border: OutlineInputBorder(),
                                      label: Text('Title',
                                       ),
                                      prefixIcon: Icon(Icons.title),
                                    ),
                                    keyboardType: TextInputType.text,
                                  ),
                                  SizedBox(height: 20),
                                  TextFormField(
                                      onFieldSubmitted: (String value) {
                                        if (formKey.currentState!.validate()) {
                                          print('gfd');
                                        }
                                      },
                                      onChanged: (String value) {
                                        print(value);
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Time must not be empty";
                                        }
                                        else
                                          return null;
                                      },
                                      controller: TimeController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        label: Text('Time',

                                        ),
                                        prefixIcon: Icon(
                                            Icons.watch_later_outlined),
                                      ),

                                      keyboardType: TextInputType.datetime,
                                      onTap: () {
                                          showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          ).then((value) {

                                              TimeController.text =
                                                  value!.format(context).toString();

                                          });

                                      }),
                                  SizedBox(height: 20),
                                  TextFormField(
                                      validator: (value){
                                        if(value!.isEmpty){
                                          return 'Date must not be empty';
                                        }
                                        else return null;
                                      },
                                      controller: DateController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        label: Text('Date',
                                        ),
                                        prefixIcon: Icon(Icons.calendar_month,
                                          color: Colors.grey,),
                                      ),
                                      keyboardType: TextInputType.datetime,
                                      onTap: () {

                                          showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime.parse('2030-05-30')
                                          ).then((value) {
                                            DateController.text =
                                                DateFormat.yMMMd().format(value!);
                                          });

                                      }),
                                ],
                              ),
                            ),
                          ),
                        );

                      }).closed.then((value) {
                      Cubit.showBottomSheet(
                        floatingIcon: Icon(Icons.edit),
                        isBottomSheetShown: false
                      );
                      });

                  }
                  else {
                    if(formKey.currentState!.validate()) {
                        Cubit.insertToDataBase(
                          status: 'new',
                        date: DateController.text,
                          time: TimeController.text,
                             title: TitleController.text,
                          );
                            TitleController.clear();
                            TimeController.clear();
                            DateController.clear();

                    }


                  }
                }),
          ),
        );
        },
      ),
    );


  }



}
