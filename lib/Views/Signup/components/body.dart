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
import 'package:ilearn/Views/Home.dart';

import 'package:ilearn/Views/Login/login_screen.dart';
import 'package:ilearn/Views/Signup/components/background.dart';

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);
  Auth auth = Auth();
  // TextEditingController emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "SIGNUP",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "images/signup.svg",
                height: size.height * 0.35,
              ),
              RoundedInputField(
                hintText: "Your Email",
                controller: emailController,
              ),
              RoundedPasswordField(
                controller: passwordController,
                hintText: "Your Password",
              ),
              RoundedPasswordField(
                controller: confirmPassController,
                hintText: "Confirm Password",
              ),
              RoundedButton(
                text: "SIGN UP",
                press: () => handleSignDetails(context),
                color: kPrimaryColor,
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const LoginScreen();
                      },
                    ),
                  );
                },
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Terms and Conditions apply"),
              )
            ],
          ),
        ),
      ),
    );
  }

  handleSignDetails(BuildContext context) {
    if (formKey.currentState!.validate() &&
        (passwordController.text == confirmPassController.text)) {
      try {
        auth.createAccount(
          Users(
            email: emailController.text,
            password: passwordController.text,
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => Home()),
          ),
        );
      } on FirebaseAuthException catch (_, e) {
        auth.showMessage(_.code, context);
      }
    }
  }
}
