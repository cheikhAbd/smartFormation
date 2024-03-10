// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_formation/components/myInput.dart';

class ForgetPwd extends StatefulWidget {
  const ForgetPwd({super.key});

  @override
  State<ForgetPwd> createState() => _ForgetPwdState();
}

class _ForgetPwdState extends State<ForgetPwd> {
  final _email = TextEditingController();

  Future forgetPwd(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _email.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text("verfier votre email pour reset le mot de passe !"),
            );
          });
    } on FirebaseAuthException {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text("Email est n'existe pas !"),
            );
          });
    }
  }

  @override
  void dispose() {
    _email;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Forget password",
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color(0xFF6C63FF),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Entrez votre email :"),
            MyTextField(
                controler: _email,
                hintText: "Email",
                obs: false,
                label: "email"),
            MaterialButton(
              onPressed: () => forgetPwd(context),
              color: Color(0xFF6C63FF),
              child: const Text("Rest Password"),
            )
          ],
        ),
      ),
    );
  }
}
