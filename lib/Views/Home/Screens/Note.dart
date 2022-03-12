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
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference<Map<String, dynamic>> store =
        FirebaseFirestore.instance.collection(doc.toString());
    //     ;
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        leading: const Text(""),
        centerTitle: true,
        toolbarHeight: size.height / 7,
        titleTextStyle: const TextStyle(fontSize: 24),
        title: const Text("Available Notes"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          color: Colors.white,
        ),
        child: StreamBuilder(
          stream: store.snapshots(),
          builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
            var document = snapshot.data?.docs;
            if (snapshot.connectionState == ConnectionState.waiting)
              // ignore: curly_braces_in_flow_control_structures
              return Center(
                child: Column(
                  children: [
                    SizedBox(height: size.height / 3),
                    const CircularProgressIndicator.adaptive(),
                    SizedBox(height: size.height * 0.03),
                    const Text("Fetching your saved records.. Please wait"),
                    SizedBox(height: size.height * 0.03),
                  ],
                ),
              );
            // return const NoRecord();
            return snapshot.data!.docs.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: document!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 2.6,
                          child: ListTile(
                            onTap: () =>
                                displayDetails(document[index].get('note')),
                            trailing: IconButton(
                              onPressed: () {
                                db.runTransaction(
                                    (Transaction myTransaction) async {
                                  myTransaction
                                      .delete(document[index].reference);
                                });
                              },
                              icon: const Icon(Icons.delete_rounded),
                            ),
                            title: Text(
                              document[index].get('title'),
                            ),
                            subtitle: Text(
                              document[index].get('note'),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const NoRecord();
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: kPrimaryColor,
        icon: const Icon(Icons.add),
        onPressed: () => displayOptions(),
        label: const Text("Add Note"),
      ),
    );
  }

  displayDetails(String data) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          Size size = MediaQuery.of(context).size;
          return BottomSheet(
              backgroundColor: Colors.transparent,
              onClosing: () {},
              builder: (context) {
                return Container(
                  width: size.width,
                  height: size.height,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                    color: Colors.white,
                  ),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: Align(
                          child: Text(data),
                          alignment: Alignment.center,
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
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
