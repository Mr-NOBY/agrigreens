import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../repository/auth_repository/auth_repo.dart';
import '../dialogs/reset_password_dialog.dart';

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
