import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqlit/Db/db_helper.dart';

class AddNote extends StatefulWidget {
  AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController position = TextEditingController();

  TextEditingController skill = TextEditingController();

  String selected = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel", style: TextStyle(color: Colors.blue)),
            ),
            Text(
              "Add Note",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            TextButton(
              onPressed: () {
                DbHelper.intsetNote(
                  position.text,
                  skill.text,
                  selected,
                  DateTime.now().toString(),
                );
                //clear Textfiled
                position.clear();
                skill.clear();
                Navigator.pop(context);
              },
              child: Text("Save", style: TextStyle(color: Colors.blueAccent)),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextField(
                  controller: position,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Positon",
                    prefixIcon: Icon(Icons.title, size: 30),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextField(
                  controller: skill,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Skill",
                    prefixIcon: Icon(Icons.title, size: 30),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Text("Catagory", style: TextStyle(fontSize: 20)),
                Spacer(),
                IconButton(
                  onPressed: () {
                    setState(() {
                      selected = "Personal";
                    });
                    log("$selected");
                  },
                  icon: (selected == "Personal")
                      ? (Icon(Icons.radio_button_checked))
                      : Icon(Icons.radio_button_off),
                ),
                Text("Personal", style: TextStyle(fontSize: 20)),
                IconButton(
                  onPressed: () {
                    setState(() {
                      selected = "Work";
                    });
                    log("$selected");
                  },
                  icon: (selected == "Work")
                      ? (Icon(Icons.radio_button_checked))
                      : Icon(Icons.radio_button_off),
                ),
                Text("Work", style: TextStyle(fontSize: 20)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
