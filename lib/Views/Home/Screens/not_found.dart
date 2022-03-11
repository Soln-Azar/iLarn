import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ilearn/Global/constants.dart';

class NoRecord extends StatelessWidget {
  const NoRecord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: size.height / 5,
          ),
          SvgPicture.asset(
            "images/doc.svg",
            width: size.width / 6,
            height: size.height / 6,
          ),
          SizedBox(height: size.height * 0.03),
          const Text(
            "No Record found",
            style: TextStyle(
                fontSize: 20,
                color: kPrimaryColor,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
