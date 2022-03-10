import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:ilearn/Global/constants.dart';
import 'package:ilearn/Models/rounded_button.dart';
import 'package:ilearn/Models/rounded_input_field.dart';
import 'package:ilearn/Views/Login/components/background.dart';
import 'package:ilearn/Views/forgot/layouts/success.dart';

class LayoutForgotScreen extends StatelessWidget {
  const LayoutForgotScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();

    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Forgot password",
              textHeightBehavior: TextHeightBehavior(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(
                "images/fpass.svg",
                height: size.height * 0.35,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              controller: emailController,
              hintText: "Your Email",
            ),
            RoundedButton(
              text: "RESET PASSWORD",
              press: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: ((context) => const Success()),
                  ),
                );
              },
              color: kPrimaryColor,
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "A link will be sent to your email  to reset \n your password",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }
}
