import 'package:flutter/material.dart';
import 'package:ilearn/Global/constants.dart';

class Capture extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final drawerKey;
  const Capture({Key? key, this.drawerKey}) : super(key: key);

  @override
  State<Capture> createState() => _CaptureState();
}

class _CaptureState extends State<Capture> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Capture question",
        ),
      ),
    );
  }
}
