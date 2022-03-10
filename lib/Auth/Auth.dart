// ignore: file_names
// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ilearn/Models/Users.dart';

class Auth {
  FirebaseAuth auth = FirebaseAuth.instance;

  /// handle online record storage
  CollectionReference<Map<String, dynamic>> store =
      FirebaseFirestore.instance.collection("records");

  /// Creating a user account
  Future<UserCredential> createAccount(Users user) async {
    return await auth.createUserWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );
  }

  /// Logging in singed in user;
  Future<UserCredential> userLogin(Users user) async {
    return await auth.signInWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );
  }

  /// SignOut user
  Future<void> logoutUser() async {
    await auth.signOut();
  }

  /// Checks if user is logged in or not
  bool isSignedIn() {
    return auth.currentUser!.isAnonymous;
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
  void storeSession(Map record, BuildContext context) {
    // store.add();
    showMessage("message", context);
  }

  /// handle Errors
  void handleErrors(errorMsg, BuildContext context) {
    String error = '';
    switch (errorMsg) {
      case '':
        break;
      default:
    }
    showMessage(error, context);
  }

  /// show sign in methods
  signInMethods() {}

  void showMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(message),
      ),
    );
  }
}
