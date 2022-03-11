import 'package:flutter/material.dart';
import 'package:ilearn/Global/constants.dart';
import 'package:ilearn/Models/text_field_container.dart';

class RoundedInput extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  const RoundedInput({
    Key? key,
    required this.hintText,
    this.icon = Icons.note,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        validator: ((value) =>
            value!.isNotEmpty ? null : "This field is required"),
        controller: controller,
        textInputAction: TextInputAction.next,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
