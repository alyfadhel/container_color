import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/bmi/bmi_screen.dart';
import 'package:messenger/color/color_screen.dart';
import 'package:messenger/messenger/messenger.dart';
import 'package:messenger/todo_app/layout/observer.dart';
import 'package:messenger/todo_app/layout/todo_screen.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ColorScreen(),
    );
  }
}


