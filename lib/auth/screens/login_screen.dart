import 'package:agrigreens/auth/controllers/login_controller.dart';
import 'package:agrigreens/global/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return SafeArea(
      child: Theme(
        data: Themes.darkthemeData,
        child: Scaffold(
          backgroundColor: //Colors.white,
              const Color.fromRGBO(17, 70, 60, 1),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Image(
                  image: AssetImage('assets/images/logo.png'),
                ),
                Form(
                    key: LoginScreen.formKey,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: MediaQuery.of(context).size.width * 0.08),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Theme(
                            data: Themes.darkthemeData,
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: controller.email,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                ),
                                labelText: 'Email',
                                hintText: 'Email',
                                border: UnderlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Theme(
                            data: Themes.darkthemeData,
                            child: TextFormField(
                              controller: controller.password,
                              obscureText: !isPasswordVisible,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock_outline),
                                labelText: 'Password',
                                hintText: 'Password',
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(style: BorderStyle.solid)),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    });
                                  },
                                  icon: Icon(isPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                          ),
                          Theme(
                            data: Themes.darkthemeData,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                  onPressed: () {
                                    controller.showForgotPasswordDialog();
                                  },
                                  // Get.to(const ForgotPasswordScreen()),
                                  child: Text('Forgot Password?',
                                      style: TextStyle(
                                          color: Themes
                                              .darkcolorScheme.secondary))),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Theme(
                            data: Themes.darkthemeData,
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (LoginScreen.formKey.currentState!
                                      .validate()) {
                                    LoginController.instance.loginUser(
                                        controller.email.text
                                            .trim()
                                            .toLowerCase(),
                                        controller.password.text.trim());
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(),
                                  side: const BorderSide(color: Colors.black),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                ),
                                child: const Text('LOGIN'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
