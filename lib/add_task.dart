// ignore_for_file: must_be_immutable

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_do_task/main_screen.dart';
import 'package:to_do_task/themedata.dart';

class AddTask extends StatefulWidget {
  AddTask({
    super.key,
    this.isEdit = false,
    this.task,
    this.taskKey,
  });

  bool isEdit;
  String? task;
  String? taskKey;

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController title = TextEditingController();

  final firebaseInstance = FirebaseDatabase.instance;

  @override
  void initState() {
    if (widget.isEdit) {
      title.text = widget.task.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ref = firebaseInstance.ref().child('todos');

    print(widget.taskKey);

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Your Task"),
        backgroundColor: ThemeClass.orangeColor,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TextField(
              cursorColor: ThemeClass.orangeColor,
              controller: title,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                hintText: 'title',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              color: ThemeClass.orangeColor,
              onPressed: () async {
                if (title.text.isNotEmpty) {
                  if (!widget.isEdit) {
                    ref
                        .push()
                        .set(
                          title.text,
                        )
                        .asStream();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => MainScreen()));
                  } else {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => MainScreen()));
                    await ref.update({
                      widget.taskKey.toString(): title.text,
                    });
                  }
                } else {
                  showToast("Task is empty!");
                }
              },
              child: Text(
                "save",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: ThemeClass.blackColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
