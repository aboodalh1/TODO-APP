import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newtodo/bloc_observer.dart';
import 'layout/Main_Screen/Main_Screen.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        appBarTheme: AppBarTheme(
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.light,
            )),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            color: Colors.redAccent.shade100,
            fontWeight: FontWeight.w600,
          ),
          headlineLarge: const TextStyle(
              color: Colors.grey, fontSize: 20, fontWeight: FontWeight.normal),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Colors.red[200],
            unselectedItemColor: Colors.white,
            backgroundColor: Colors.red),
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData(

        primaryColor: Colors.black,
        primaryIconTheme: const IconThemeData(
          color: Colors.grey,
        ),
        appBarTheme: AppBarTheme(
            actionsIconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            color: Colors.grey,
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: Colors.grey[600]),
            iconTheme: const IconThemeData(color: Colors.grey)),
        iconTheme: const IconThemeData(color: Colors.grey),
        primarySwatch: Colors.grey,
        textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.grey)),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.black,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.black,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.grey,
        ),
        scaffoldBackgroundColor: Colors.black,
      ),
      themeMode: ThemeMode.dark,
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
