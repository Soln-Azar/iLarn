import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ilearn/Auth/Auth.dart';
import 'package:ilearn/Views/Home/Home.dart';

class NoteModel {
  final String title;
  final String message;
  NoteModel({required this.message, required this.title});

  saveToCloud(BuildContext context, int i) {
    FirebaseAuth auth = FirebaseAuth.instance;
    var cloudStore = Auth().storeSession(auth.currentUser!.email);
    cloudStore.add({'title': title, 'note': message, 'uid': i}).whenComplete(
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: ((context) => const Home()),
        ),
      ),
    );
  }
}
