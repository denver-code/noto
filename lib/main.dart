import 'package:flutter/material.dart';
import 'package:noto/screens/todo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'NOTO',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: ThemeData(
          fontFamily: "Open Sans",
          primarySwatch: Colors.blue,
        ),
        home: const ToDoScreen());
  }
}
