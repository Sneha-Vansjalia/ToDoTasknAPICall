// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:to_do_task/themedata.dart';

import 'add_task.dart';

class ToDoTask extends StatefulWidget {
  const ToDoTask({super.key});

  @override
  _ToDoTaskState createState() => _ToDoTaskState();
}

class _ToDoTaskState extends State<ToDoTask> {
  final fb = FirebaseDatabase.instance;
  TextEditingController searchTextController = TextEditingController();
  String searchQuerty = "";

  @override
  Widget build(BuildContext context) {
    final ref = fb.ref().child('todos');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ThemeClass.orangeColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddTask(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        backgroundColor: ThemeClass.orangeColor,
        elevation: 0,
        title: const Text("To Do List"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              cursorColor: ThemeClass.orangeColor,
              controller: searchTextController,
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
                hintText: 'Search your task here',
              ),
              onChanged: (val) {
                setState(() {
                  searchQuerty = val;
                });
              },
            ),
          ),
          FirebaseAnimatedList(
            query: ref,
            shrinkWrap: true,
            defaultChild: Center(
              child: CircularProgressIndicator(color: ThemeClass.orangeColor),
            ),
            itemBuilder: (context, snapshot, animation, index) {
              if (snapshot.value != null) {
                if (searchQuerty.isEmpty) {
                  return taskListTile(context, snapshot, ref);
                } else if (snapshot.value
                    .toString()
                    .toLowerCase()
                    .startsWith(searchQuerty.toLowerCase())) {
                  return taskListTile(context, snapshot, ref);
                }
              }
              // return SizedBox();

              return Center(
                child: CircularProgressIndicator(color: ThemeClass.orangeColor),
              );
            },
          ),
        ],
      ),
    );
  }

  Padding taskListTile(
      BuildContext context, DataSnapshot snapshot, DatabaseReference ref) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        tileColor: ThemeClass.orangeColor.withOpacity(0.2),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                Icons.edit_rounded,
                color: ThemeClass.orangeColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddTask(
                      isEdit: true,
                      task: snapshot.value.toString(),
                      taskKey: snapshot.key!.toString(),
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: ThemeClass.orangeColor,
              ),
              onPressed: () {
                _showMyDialog(onDeleteTap: () {
                  ref.child(snapshot.key!).remove();

                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        ),
        title: Text(
          snapshot.value.toString(),
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog({required Null Function() onDeleteTap}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'Do you sure want to delete the task?',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Delete',
                style: TextStyle(color: ThemeClass.orangeColor),
              ),
              onPressed: onDeleteTap,
            ),
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: ThemeClass.orangeColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
