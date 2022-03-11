import 'package:flutter/material.dart';
import 'package:ilearn/Views/Home/Home.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: const SafeArea(
          child: Center(
        child: Text("Notes"),
      )),
    );
  }
}
