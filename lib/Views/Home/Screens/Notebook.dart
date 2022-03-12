import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ilearn/Global/constants.dart';
import 'package:ilearn/Views/Home/Home.dart';
import 'package:ilearn/Views/Home/Models/NoteModel.dart';

class NoteBook extends StatefulWidget {
  final String noteTitle;
  const NoteBook({Key? key, required this.noteTitle}) : super(key: key);

  @override
  State<NoteBook> createState() => _NoteBookState();
}

class _NoteBookState extends State<NoteBook> {
  @override
  void initState() {
    super.initState();
  }

  bool showSave = false;
  var notedController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          toolbarHeight: size.height / 9,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            fontSize: 20,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) {
                    return const Home();
                  }),
                );
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded)),
          title: Text(widget.noteTitle),
        ),
        body: SafeArea(
          child: Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Type here..",
                  ),
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  controller: notedController,
                  maxLines: 200,
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: kPrimaryColor,
          onPressed: () {
            int id = 0;
            setState(() {
              id += 1;
            });
            NoteModel(message: notedController.text, title: widget.noteTitle)
                .saveToCloud(context, id);
          },
          icon: const Icon(Icons.check),
          label: const Text("Save"),
          extendedIconLabelSpacing: 10,
        ));
  }
}
