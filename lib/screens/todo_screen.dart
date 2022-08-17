import 'dart:convert';

import "package:flutter/material.dart";
import 'package:noto/internal/hex_color.dart';
import 'package:noto/internal/todo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  final TextEditingController _taskName = TextEditingController();
  bool isDarkTheme = false;
  List tasks = [
    // {"name": "wake up at 7am", "isChecked": true},
    // {"name": "brush your teeth", "isChecked": true},
    // {"name": "walk the dog", "isChecked": true},
    // {"name": "pay the bills", "isChecked": false},
    // {"name": "work on UI/UX", "isChecked": false},
  ];

  @override
  void initState() {
    super.initState();
    _loadTheme();
    _loadTasks();
  }

  _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkTheme = (prefs.getBool('isDarkTheme') ?? false);
    });
  }

  void _switchTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkTheme = !isDarkTheme;
      prefs.setBool("isDarkTheme", isDarkTheme);
    });
  }

  _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      var encodedList = (prefs.getString('today_tasks'));
      tasks = json.decode(encodedList!);
    });
  }

  _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString("today_tasks", json.encode(tasks));
    });
  }

  _switchChecked(int index) async {
    tasks[index]["isChecked"] = !tasks[index]["isChecked"];
    _saveTasks();
  }

  _removeTask(int index) async {
    tasks.removeAt(index);
    _saveTasks();
  }

  _addTask(String name) async {
    tasks.add({"name": name, "isChecked": false});
    _saveTasks();
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Add"),
      onPressed: () {
        _addTask(_taskName.text);
        _taskName.clear();
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Adding a new task"),
      content: TextField(
        controller: _taskName,
        decoration: const InputDecoration(hintText: "Task name"),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (() {
        if (isDarkTheme) {
          return Colors.black;
        }
        return Colors.white;
      }()),
      body: SafeArea(
          child: Padding(
        padding:
            const EdgeInsets.only(left: 35.0, right: 35.0, top: 45, bottom: 45),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: _switchTheme,
                  child: Image(
                    image: const AssetImage("assets/images/moon_black.png"),
                    color: (() {
                      if (isDarkTheme) {
                        return Colors.white;
                      }
                      return Colors.black;
                    }()),
                    width: 35,
                  ),
                ),
                GestureDetector(
                  onTap: () => {},
                  child: Image(
                    image: const AssetImage("assets/images/coffe_black.png"),
                    color: (() {
                      if (isDarkTheme) {
                        return Colors.white;
                      }
                      return Colors.black;
                    }()),
                    width: 35,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "ALL",
                  style: TextStyle(
                    color: (() {
                      if (isDarkTheme) {
                        return Colors.white;
                      }
                      return Colors.black;
                    }()),
                    fontWeight: FontWeight.w800,
                    fontSize: 35,
                  ),
                ),
                Text(
                  "FEATURES",
                  style: TextStyle(
                    color: HexColor.fromHex("#9C9C9C"),
                    fontWeight: FontWeight.w800,
                    decoration: TextDecoration.lineThrough,
                    fontSize: 24,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: (() {
                  if (tasks.isEmpty) {
                    return [
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "You don't have tasks!",
                        style: TextStyle(
                            fontSize: 20, color: HexColor.fromHex("#9C9C9C")),
                      )
                    ];
                  } else {
                    return List.generate(tasks.length, (index) {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onDoubleTap: () => _removeTask(index),
                            onTap: () => _switchChecked(index),
                            child: Text(
                              tasks[index]["name"],
                              style: TextStyle(
                                  color: (() {
                                    switch (isDarkTheme) {
                                      case true:
                                        if (tasks[index]["isChecked"] == true) {
                                          return HexColor.fromHex("#9C9C9C");
                                        }
                                        return Colors.white;
                                      default:
                                        if (tasks[index]["isChecked"] == true) {
                                          return HexColor.fromHex("#9C9C9C");
                                        }
                                    }
                                  }()),
                                  decoration: (() {
                                    if (tasks[index]["isChecked"] == true) {
                                      return TextDecoration.lineThrough;
                                    }
                                  }()),
                                  fontSize: 20,
                                  fontWeight: (() {
                                    if (tasks[index]["isChecked"] == true) {
                                      return FontWeight.w300;
                                    }
                                    return FontWeight.bold;
                                  }())),
                            ),
                          )
                        ],
                      );
                    });
                  }
                }()),
              ),
            )),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                showAlertDialog(context);
              },
              child: Text(
                "Add a new task",
                style: TextStyle(
                  color: (() {
                    if (isDarkTheme) {
                      return Colors.white;
                    }
                    return Colors.black;
                  }()),
                  fontSize: 25,
                  fontWeight: FontWeight.w300,
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
