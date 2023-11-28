import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newtodo/modules/Archived_Screen/Archive_Screen.dart';
import 'package:newtodo/modules/Cubit/states.dart';
import 'package:newtodo/modules/Done_Screen/Done_Screen.dart';
import 'package:sqflite/sqflite.dart';
import '../Title_Screen/Title_Screen.dart';

class AppCubit extends Cubit<AppState>{
  AppCubit() : super (AppInitialState());
  static AppCubit get(context)=> BlocProvider.of(context);

   //Variables
   List <Widget> a=[
     Tasks(),
     Done(),
     Archived(),
  ];
   List <Map> newTasks=[];
   List<Map> doneTasks=[];
   List <Map> archivedTasks=[];
   int currentIndex = 0;
   bool isBottomSheetShown=false;
   Icon floatingIcon=const Icon(Icons.edit);
   late Database dBB;


   void changeBottomNavBar(index){
     currentIndex=index;
     emit(ChangeBottomNavBarState());
   }
   void showBottomSheet({
   required isBottomSheetShown,
   required floatingIcon
}){
     this.isBottomSheetShown=isBottomSheetShown;
       this.floatingIcon=floatingIcon;

    emit(ShowBottomSheetState());
   }


  void createDataBase(){
    openDatabase('firstDataBase.db',
        version: 1,
        onCreate: (dBB,version) async{
          print('Data Base have Created successfully');
            dBB.execute('Create Table Task(id INTEGER PRIMARY KEY,title TEXT,time TEXT,date TEXT,status TEXT)')
              .then((value) {
            print('Tables Created Successfully');
          }).catchError((error) {
            print('error when tables Created ${error.toString()}');
          });
        },
        onOpen:(dBB) {
          getFromDB(dBB);
          print('Data Base Opened Successfully');
        },
    ).then((value) {
      dBB=value;
      emit(CreateDataBaseState());
    });
  }
   void insertToDataBase({
    required String title,
    required String time,
    required String date,
    required String status,
  }) {
      dBB.transaction((txn)async {
        txn.rawInsert('INSERT INTO Task(title,time,date,status) VALUES("$title","$time","$date","new")'
      ).then((value) {
        print('$value+ Gg');
        emit(InsertToDataBaseState());
        getFromDB(dBB);
      }).catchError((error) {
       print('${error.toString()}');
       });
    });
  }
     void getFromDB(DBB){
       newTasks=[];
       doneTasks=[];
       archivedTasks=[];
     emit(GetDataBaseLoadingState());
      DBB.rawQuery('SELECT * FROM Task').then((value) {
        value.forEach((element) {
          if(element['status']=='new') {
            newTasks.add(element);
          } else if(element['status']=='done'){
          doneTasks.add(element);}
          else {
            archivedTasks.add(element); }
        });
        emit(GetFromDataBaseState());
      });
      }
      void updateData({
       required String status,
       required int id
})
      {
       dBB.rawUpdate('UPDATE task SET status= ? WHERE id =?',
       ['$status','$id']).then((value) {
         getFromDB(dBB);
         emit(UpdateDataBaseState());
       });
      }
    void removeData({
      required int id
}){
     dBB.rawDelete(
         'DELETE FROM Task WHERE id = ?', ['$id']).then((value){
       getFromDB(dBB);
       emit(UpdateDataBaseState());
     });
}
}