import 'package:flutter/material.dart';
import 'package:sqlit/Db/db_helper.dart';
import 'package:sqlit/view/add_note.dart';

class ViewnoteScreen extends StatefulWidget {
  ViewnoteScreen({super.key});

  @override
  State<ViewnoteScreen> createState() => _ViewnoteScreenState();
}

class _ViewnoteScreenState extends State<ViewnoteScreen> {
  List<Map<String, dynamic>> listnote = [];
 
  Future<void> getData() async {
    listnote = await DbHelper.getNote();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getData();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          "Keep Note",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: listnote.length,
        itemBuilder: (context, index) {
          final note = listnote[index];
          int id = listnote[index]['id'];
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Dismissible(
              key: Key(index.toString()),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                DbHelper.deleteNote(id);
              },
              background: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${note["position"]}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("${note["skill"]}"),
                          Spacer(),
                          Text("${note["date"]}"),
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Text("${note["category"]}"),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              // show dialog
                              showDialog(
                                context: context,
                                builder: (context) {
                                  TextEditingController OldPosition =
                                      TextEditingController();
                                  TextEditingController OldSkill =
                                      TextEditingController();
                                  String selected = note['category'];
                                  OldPosition.text = note['position'];
                                  OldSkill.text = note['skill'];
                                  return StatefulBuilder(
                                    builder: (context, setState) => AlertDialog(
                                      title: Container(
                                        width: 400,
                                        height: 400,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Update"),
                                            SizedBox(height: 10),
                                            Text(
                                              "Position",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            TextField(
                                              controller: OldPosition,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              "Skill",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            TextField(
                                              controller: OldSkill,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Category",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                Spacer(),
                                                IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      selected = "Personal";
                                                    });
                                                  },
                                                  icon: (selected == 'Personal')
                                                      ? Icon(
                                                          Icons
                                                              .radio_button_checked,
                                                        )
                                                      : Icon(
                                                          Icons
                                                              .radio_button_off,
                                                        ),
                                                ),
                                                Text(
                                                  "personal",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      selected = "Work";
                                                    });
                                                  },
                                                  icon: (selected == 'Work')
                                                      ? Icon(
                                                          Icons
                                                              .radio_button_checked,
                                                        )
                                                      : Icon(
                                                          Icons
                                                              .radio_button_off,
                                                        ),
                                                ),
                                                Text(
                                                  "Work",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            DbHelper.update(
                                              id,
                                              OldPosition.text,
                                              OldSkill.text,
                                              selected,
                                              DateTime.now().toString(),
                                            );
                                            Navigator.pop(context);
                                          },
                                          child: Text("Update"),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.edit, color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNote()),
          );
        },
        child: Icon(Icons.add, color: Colors.red),
      ),
    );
  }
}
