import 'package:flutter/material.dart';
import 'package:smart_formation/pages/loginScreen.dart';
import 'package:smart_formation/pages/signUp.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLogin = true;

  void toggleScreens() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return Login(showRegister: toggleScreens);
    } else {
      return SignUp(
        showLogin: toggleScreens,
      );
    }
  }
}
