import 'package:flutter/material.dart';

class RecordSession extends StatefulWidget {
  const RecordSession({Key? key}) : super(key: key);

  @override
  State<RecordSession> createState() => _RecordSessionState();
}

class _RecordSessionState extends State<RecordSession> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Record a session"),
    );
  }
}
