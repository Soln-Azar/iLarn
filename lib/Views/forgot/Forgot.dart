import 'package:flutter/material.dart';
import 'package:ilearn/Views/forgot/layouts/layout.dart';

class Forgot extends StatefulWidget {
  const Forgot({Key? key}) : super(key: key);

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: LayoutForgotScreen());
  }
}
