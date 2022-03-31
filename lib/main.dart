import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ilearn/Auth/Auth.dart';
import 'package:ilearn/Views/Home/Home.dart';
import 'package:ilearn/Views/Intro.dart';
import 'package:ilearn/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const iLearn());
}

// ignore: camel_case_types
class iLearn extends StatelessWidget {
  const iLearn({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Auth user = Auth();
    return MaterialApp(
      theme: ThemeData(
        
        primarySwatch: Colors.teal,
      ),
      home: user.isSignedIn() ? const IntroPage() : const Home(),
    );
  }
}
