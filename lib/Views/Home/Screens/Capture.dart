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
    return Scaffold(
      body: const Center(
        child: Text(
          "Scan a document here",
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {},
        child: const Icon(
          Icons.camera,
        ),
      ),
    );
  }
}
