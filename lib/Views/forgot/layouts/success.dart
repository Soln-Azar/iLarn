import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ilearn/Global/constants.dart';
import 'package:ilearn/Models/rounded_button.dart';
import 'package:ilearn/Views/Login/login_screen.dart';
import 'package:ilearn/Views/forgot/layouts/back.dart';

class Success extends StatelessWidget {
  const Success({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Back(
          child: Center(
        child: Column(
          children: [
            SizedBox(height: size.height / 5),
            SvgPicture.asset(
              "images/success.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              "You can check your email..",
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: kPrimaryColor,
                    fontSize: 18,
                  ),
            ),
            SizedBox(height: size.height * 0.03),
            RoundedButton(
              text: "BACK TO LOGIN",
              press: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              color: kPrimaryColor,
            ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      )),
    );
  }
}
