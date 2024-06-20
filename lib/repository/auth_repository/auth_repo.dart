import 'package:agrigreens/auth/screens/login_screen.dart';
import 'package:agrigreens/global/client.dart';
import 'package:agrigreens/variable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthRepo extends GetxController {
  static AuthRepo get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late Rx<User?> firebaseUser;

  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 6));
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, setInitialScreen);

    if (_auth.currentUser != null) {
      isLoggedIn = true;
    }
  }

  setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const LoginScreen())
        // : Get.offAll(() => MyHomePage(title: 'AgriGreens'));
        : Get.offAll(() => Variable());
  }

  Future<void> logInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar(
        "Login Successful",
        "You have successfully logged in.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 4),
        borderRadius: 10,
        margin: EdgeInsets.all(10),
        icon: Icon(Icons.check_circle, color: Colors.white),
        shouldIconPulse: true,
        borderColor: Colors.black,
        borderWidth: 1,
      );
      isLoggedIn = true;
      subscribe();
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found for that email.';
          break;
        case 'wrong-password':
          message = 'Wrong password provided.';
          break;
        case 'invalid-email':
          message = 'Invalid Email.';
          break;
        case 'user-disabled':
          message = 'User Disabled, Contact Support!';
          break;
        default:
          message = 'An unknown error occurred!';
      }
      Get.snackbar(
        "Login Error",
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 4),
        borderRadius: 10,
        margin: EdgeInsets.all(10),
        icon: Icon(Icons.error, color: Colors.white),
        shouldIconPulse: true,
        borderColor: Colors.black,
        borderWidth: 1,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 4),
        borderRadius: 10,
        margin: EdgeInsets.all(10),
        icon: Icon(Icons.error, color: Colors.white),
        shouldIconPulse: true,
        borderColor: Colors.black,
        borderWidth: 1,
      );
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      Get.snackbar(
        "Logout Successful",
        "You have successfully logged out.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 4),
        borderRadius: 10,
        margin: EdgeInsets.all(10),
        icon: Icon(Icons.check_circle, color: Colors.white),
        shouldIconPulse: true,
        borderColor: Colors.black,
        borderWidth: 1,
      );
      isLoggedIn = false;
      unsubscribe();
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 4),
        borderRadius: 10,
        margin: EdgeInsets.all(10),
        icon: Icon(Icons.error, color: Colors.white),
        shouldIconPulse: true,
        borderColor: Colors.black,
        borderWidth: 1,
      );
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.back(); // Close the dialog
      Get.snackbar(
        "Password Reset",
        "Password reset link sent to $email",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 4),
        borderRadius: 10,
        margin: EdgeInsets.all(10),
        icon: Icon(Icons.check_circle, color: Colors.white),
        shouldIconPulse: true,
        borderColor: Colors.black,
        borderWidth: 1,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Please, Check the email you entered.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 4),
        borderRadius: 10,
        margin: EdgeInsets.all(10),
        icon: Icon(Icons.error, color: Colors.white),
        shouldIconPulse: true,
        borderColor: Colors.black,
        borderWidth: 1,
      );
    }
  }
}
