import 'package:flutter/material.dart';
import 'package:izi_travel/identification/login_page.dart';
import 'package:izi_travel/identification/signup_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;

  void toogleScreen() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(showSignUpPage: toogleScreen);
    } else {
      return SignUpPage(showLoginPage: toogleScreen);
    }
  }
}