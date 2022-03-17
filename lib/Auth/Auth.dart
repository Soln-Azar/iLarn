// ignore: file_names
// ignore: file_names
// ignore_for_file: invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ilearn/Models/Users.dart';
import 'package:ilearn/Views/Home/Home.dart';
import 'package:ilearn/Views/Login/login_screen.dart';

class Auth {
  FirebaseAuth auth = FirebaseAuth.instance;

  /// Creating a user account
  Future<void> createAccount(Users user, BuildContext context) async {
    try {
      auth
          .createUserWithEmailAndPassword(
            email: user.email,
            password: user.password,
          )
          .then(
            (value) => value.user?.email == null
                ? null
                : Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const Home()),
                    ),
                  ),
          )
          .catchError((error) {
        showMessage(error.code, context);
      }).whenComplete(
        (() => () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                // animation: ,
                behavior: SnackBarBehavior.floating,
                content:
                    Text("${user.email} has been registered successfully."),
              ),
            )),
      );
    } on FirebaseAuthException catch (exe) {
      showMessage(exe.code, context);
    }
  }

  /// Logging in singed in user;
  Future<void> userLogin(Users user, BuildContext context) async {
    try {
      await auth
          .signInWithEmailAndPassword(
            email: user.email,
            password: user.password,
          )
          .then(
            (value) => value.user?.email == null
                ? null
                : Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const Home()),
                    ),
                  ),
          )
          .catchError((onError) {
        showMessage(onError.code, context);
      });
    } on FirebaseAuthException catch (e) {
      showMessage(e.code, context);
    }
  }

  /// SignOut user
  Future<void> logoutUser(BuildContext context) async {
    auth.signOut().whenComplete(
          () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: ((context) => const LoginScreen()),
            ),
          ),
        );
    // notifyListeners();
  }

  showProgress(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return BottomSheet(
          backgroundColor: Colors.transparent,
          builder: (context) {
            var size = MediaQuery.of(context).size;
            return Container(
              width: size.width,
              height: size.height,
              decoration: const BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(25))),
              child: const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          },
          onClosing: () {},
        );
      },
    );
  }

  /// Checks if user is logged in or not
  bool isSignedIn() {
    return auth.currentUser?.email == null;
  }

  /// Password reset
  Future<void> resetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  /// Confirm password resetPassword
  Future<void> confirmPassword(
      String confirmationCode, String newPassword) async {
    await auth.confirmPasswordReset(
        code: confirmationCode, newPassword: newPassword);
  }

  /// Store user records
  CollectionReference<Map<String, dynamic>> storeSession(String? record) {
    /// handle online record storage
    return FirebaseFirestore.instance.collection(record!);
  }

  /// show sign in methods
  signInMethods() {}

  showMessage(dynamic message, BuildContext context) {
    String errorMessage = '';
    switch (message) {
      case "invalid-email":
        errorMessage = "Your email address appears to be malformed.";
        break;
      case 'weak-password':
        errorMessage = "The password provided is too weak.";
        break;
      case 'email-already-in-use':
        errorMessage = "The account already exists for that email.";
        break;
      case "wrong-password":
        errorMessage = "Your password is wrong.";
        break;
      case "user-not-found":
        errorMessage = "User with this email doesn't exist.";
        break;
      case "user-disabled":
        errorMessage = "User with this email has been disabled.";
        break;
      case "too-many-requests":
        errorMessage = "Too many requests";
        break;
      case "operation-not-allowed":
        errorMessage = "Signing in with Email and Password is not enabled.";
        break;
      default:
        errorMessage = "An undefined Error happened.";
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(errorMessage),
      ),
    );
  }
}
