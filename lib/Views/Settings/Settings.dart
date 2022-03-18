import 'package:flutter/material.dart';
import 'package:ilearn/Views/Settings/Screens/SetBody.dart';

class Settngs extends StatefulWidget {
  const Settngs({Key? key}) : super(key: key);

  @override
  State<Settngs> createState() => _SettngsState();
}

class _SettngsState extends State<Settngs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App Settings"),
      ),
      body: SetBody(),
    );
  }
}
