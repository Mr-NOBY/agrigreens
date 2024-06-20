import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:agrigreens/repository/auth_repository/auth_repo.dart';
import 'package:agrigreens/auth/dialogs/reset_password_dialog.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  void loginUser(String email, String password) {
    AuthRepo.instance.logInWithEmailAndPassword(email, password);
  }

  void showForgotPasswordDialog() {
    resetPasswordDialog();
  }
}
