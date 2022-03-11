import 'package:flutter/material.dart';

class RoundedBtn extends StatelessWidget {
  final String text;
  final void Function() press;
  final Color color, textColor;
  const RoundedBtn({
    Key? key,
    required this.text,
    required this.press,
    required this.color,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: roundButton(),
      ),
    );
  }

  Widget roundButton() {
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
      onPressed: press,
      style: ElevatedButton.styleFrom(
        primary: color,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        textStyle: TextStyle(
          color: textColor,
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
