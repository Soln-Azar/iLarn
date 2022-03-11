import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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

import 'package:ilearn/Views/Login/login_screen.dart';
import 'package:ilearn/Views/Signup/components/background.dart';

// ignore: must_be_immutable
class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);
  @override
  State<Body> createState() {
    return BodyState();
  }
}

class BodyState extends State<Body> {
  Auth auth = Auth();
  bool errorMsg = false;
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  handleSignDetails(BuildContext context) {
    if (formKey.currentState!.validate() &&
        (passwordController.text == confirmPassController.text)) {
      if (kDebugMode) {
        print("${passwordController.text} - ${emailController.text}");
      }
      try {
        auth
            .createAccount(
              Users(
                email: emailController.text,
                password: passwordController.text,
              ),
            )
            .whenComplete(
              () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  // animation: ,
                  behavior: SnackBarBehavior.floating,
                  content: Text(
                      "${emailController.text} has been registered successfully."),
                ),
              ),
            )
            .then(
              (value) => value.user?.email == null
                  ? setState(() => errorMsg = true)
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const Home()),
                      ),
                    ),
            );
      } on FirebaseAuthException catch (_) {
        auth.showMessage(_.code, context);
      }
    }
  }

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
                "SIGN UP",
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  errorMsg == true ? "Error while creating account" : "",
                  style: const TextStyle(
                    color: Colors.red,
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
