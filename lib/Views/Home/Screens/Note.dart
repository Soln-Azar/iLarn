import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ilearn/Global/constants.dart';

import 'package:ilearn/Views/Home/Models/round_btn.dart';
import 'package:ilearn/Views/Home/Models/round_input.dart';
import 'package:ilearn/Views/Home/Screens/Notebook.dart';
import 'package:ilearn/Views/Home/Screens/not_found.dart';

class Note extends StatefulWidget {
  const Note({Key? key}) : super(key: key);

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  var noteController = TextEditingController();

  var doc = FirebaseAuth.instance.currentUser?.email;
  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference<Map<String, dynamic>> store =
        FirebaseFirestore.instance.collection(doc.toString());
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: StreamBuilder(
        stream: store.snapshots(),
        builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            // ignore: curly_braces_in_flow_control_structures
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          // return const NoRecord();
          return snapshot.hasData
              ? ListView(
                  children: snapshot.data!.docs
                      .map((doc) => Card(
                            child: ListTile(
                              title: Text(
                                doc.get('title'),
                              ),
                            ),
                          ))
                      .toList())
              : const NoRecord();
        }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: kPrimaryColor,
        icon: const Icon(Icons.add),
        onPressed: () => displayOptions(),
        label: const Text("Add Note"),
      ),
    );
  }

  displayOptions() {
    // var noteFormKey = GlobalKey<FormState>();
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: SizedBox(
              width: 250,
              height: 220,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Add new note.",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      // key: noteFormKey,
                      child: RoundedInput(
                        hintText: 'Enter note name',
                        controller: noteController,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      RoundedBtn(
                        color: kPrimaryColor,
                        text: 'Create',
                        press: () {
                          if (/*noteFormKey.currentState!.validate() &&*/
                              (noteController.text.isNotEmpty)) {
                            // print(noteController.text);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return NoteBook(
                                    noteTitle: noteController.text,
                                  );
                                },
                              ),
                            );
                          }
                        },
                      ),
                      RoundedBtn(
                        color: Colors.red,
                        text: 'Cancel',
                        press: () {
                          setState(() {
                            noteController.clear();

                            Navigator.of(context).pop();
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
