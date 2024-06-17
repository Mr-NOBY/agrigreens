import 'package:agrigreens/global/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../repository/auth_repository/auth_repo.dart';

void resetPasswordDialog() {
  final resetEmail = TextEditingController();

  Get.defaultDialog(
    title: "Forgot Password",
    titlePadding: EdgeInsets.symmetric(vertical: 20),
    titleStyle: TextStyle(color: Themes.darkcolorScheme.onBackground),
    content: Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Theme(
            data: Themes.mainthemeData,
            child: TextField(
              controller: resetEmail,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
              ),
            ),
          ),
          SizedBox(height: 20),
          Theme(
            data: Themes.mainthemeData,
            child: ElevatedButton(
              onPressed: () {
                if (resetEmail.text.isNotEmpty) {
                  AuthRepo.instance.resetPassword(resetEmail.text.trim());
                } else {
                  Get.snackbar(
                    "Error",
                    "Please enter an email address",
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
              },
              child: Text("Send Reset Link"),
            ),
          ),
        ],
      ),
    ),
  );
}
