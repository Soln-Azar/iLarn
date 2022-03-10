import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ilearn/Global/Global.dart';
import 'package:ilearn/Global/constants.dart';
import 'package:ilearn/Models/rounded_button.dart';
import 'package:ilearn/Views/Auth/Login.dart';
import 'package:ilearn/Views/Login/login_screen.dart';
import 'package:ilearn/Views/Signup/signup_screen.dart';

class IntroBody extends StatefulWidget {
  IntroBody({Key? key}) : super(key: key);

  @override
  State<IntroBody> createState() => _IntroBodyState();
}

class _IntroBodyState extends State<IntroBody> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Text(
                "Welcome to iLearn",
                style: appText,
              ),
            ),
            SvgPicture.asset(
              "images/welcome.svg",
              width: imageSize.width,
              height: imageSize.height,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RoundedButton(
                text: "LOGIN",
                press: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                        fullscreenDialog: true),
                  );
                },
                color: kPrimaryColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RoundedButton(
                text: "SIGN UP",
                press: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
