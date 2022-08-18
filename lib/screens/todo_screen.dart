import 'dart:convert';

import "package:flutter/material.dart";
import 'package:noto/internal/hex_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  final TextEditingController _taskName = TextEditingController();
  final TextEditingController _newTaskName = TextEditingController();
  bool isDarkTheme = false;
  List tasks = [];

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
      if (encodedList!.isNotEmpty) {
        tasks = json.decode(encodedList);
      }
    });
  }

  _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString("today_tasks", json.encode(tasks));
    });
  }

  _switchChecked(int index) async {
    setState(() {
      tasks[index]["isChecked"] = !tasks[index]["isChecked"];
    });

    _saveTasks();
  }

  _removeTask(int index) async {
    setState(() {
      tasks.removeAt(index);
    });
    _saveTasks();
  }

  _addTask(String name) async {
    setState(() {
      tasks.add({"name": name, "isChecked": false});
    });
    _saveTasks();
  }

  _editTask(String newName, int index) async {
    setState(() {
      tasks[index]["name"] = newName;
    });
    _saveTasks();
  }

  showEditTaskDiaglog(BuildContext context, int index) {
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Edit"),
      onPressed: () {
        _editTask(_newTaskName.text, index);
        _newTaskName.clear();
        Navigator.of(context).pop();
      },
    );

    AlertDialog addNewTask = AlertDialog(
      title: const Text("Editing a task"),
      content: TextField(
        controller: _newTaskName,
        decoration: const InputDecoration(hintText: "New task name"),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return addNewTask;
      },
    );
  }

  showAddNewTaskDialog(
    BuildContext context,
  ) {
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
        _taskName.clear();
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

    AlertDialog addNewTask = AlertDialog(
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
        return addNewTask;
      },
    );
  }

  _themePicker(String obj) {
    switch (isDarkTheme) {
      case true:
        switch (obj) {
          case "scaffold":
            return Colors.black;
          case "image":
          case "text":
            return Colors.white;
        }
        break;
      default:
        switch (obj) {
          case "scaffold":
            return Colors.white;
          case "image":
          case "text":
            return Colors.black;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _themePicker("scaffold"),
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
                    color: _themePicker("image"),
                    width: 35,
                  ),
                ),
                GestureDetector(
                  onTap: () => {Navigator.of(context).pushNamed("/credits")},
                  child: Image(
                    image: const AssetImage("assets/images/coffe_black.png"),
                    color: _themePicker("image"),
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
                    color: _themePicker("text"),
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
                            onLongPress: () =>
                                showEditTaskDiaglog(context, index),
                            onDoubleTap: () => _removeTask(index),
                            onTap: () => _switchChecked(index),
                            child: Text(
                              tasks[index]["name"],
                              textAlign: TextAlign.center,
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
                showAddNewTaskDialog(context);
              },
              child: Text(
                "Add a new task",
                style: TextStyle(
                  color: _themePicker("text"),
                  fontSize: 25,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Tap - change status;\nDouble tap - delete task.\nLong press - edit task.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: HexColor.fromHex("#9C9C9C"),
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
