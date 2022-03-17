import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:ilearn/Auth/Auth.dart';
import 'package:ilearn/Global/constants.dart';
import 'package:ilearn/Models/Users.dart';
import 'package:ilearn/Models/already_have_an_account_acheck.dart';
import 'package:ilearn/Models/rounded_button.dart';
import 'package:ilearn/Models/rounded_input_field.dart';
import 'package:ilearn/Models/rounded_password_field.dart';
import 'package:ilearn/Views/Home/Home.dart';

import 'package:ilearn/Views/Login/components/background.dart';
import 'package:ilearn/Views/Signup/signup_screen.dart';
import 'package:ilearn/Views/forgot/Forgot.dart';

class Body extends StatelessWidget {
  Body({
    Key? key,
  }) : super(key: key);
  var formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "LOGIN",
                textHeightBehavior: TextHeightBehavior(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "images/login.svg",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                controller: emailController,
                hintText: "Your Email",
              ),
              RoundedPasswordField(
                controller: passwordController,
                hintText: 'Your password',
              ),
              RoundedButton(
                text: "LOGIN",
                press: () {
                  Auth auth = Auth();
                  if (formkey.currentState!.validate()) {
                    try {
                      auth.userLogin(
                          Users(
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                          context);

                      // ignore: empty_catches
                    } on FirebaseAuthException catch (_, e) {
                      auth.showMessage(_.code, context);
                    }
                  }
                },
                color: kPrimaryColor,
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const SignUpScreen();
                      },
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const Forgot();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    "Forgot your password ?",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
