// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, avoid_unnecessary_containers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smart_formation/components/myButton.dart';
import 'package:smart_formation/components/myInput.dart';
import 'package:smart_formation/pages/forgetPwd.dart';

class Login extends StatefulWidget {
  final VoidCallback showRegister;
  const Login({super.key, required this.showRegister});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _email = TextEditingController();
  final _pwd = TextEditingController();

  // sign in
  Future signIn(BuildContext context) async {
    try {
      // loading
      showDialog(
          context: context,
          builder: (context) {
            return const Center(child: CircularProgressIndicator());
          });

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text.trim(),
        password: _pwd.text.trim(),
      );

      // delete loading
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Color(0xFF6C63FF),
        content: Text(
          "Email or password isn't correct $e",
          style: TextStyle(fontSize: 18),
        ),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // image
            Container(
                child: Image.asset(
              "images/logo.png",
              width: 500,
              height: 300,
            )),

            SizedBox(
              height: 15,
            ),
            // text
            Text(
              "Login",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            SizedBox(
              height: 15,
            ),
            // email
            MyTextField(
                controler: _email,
                hintText: "Email",
                obs: false,
                label: "Email"),

            SizedBox(
              height: 15,
            ),
            // password
            MyTextField(
                controler: _pwd,
                hintText: "password",
                obs: true,
                label: "Password"),

            SizedBox(
              height: 15,
            ),
            // forget password
            Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ForgetPwd()));
                    },
                    child: const Text(
                      "Forget Password ?",
                      style: TextStyle(
                          color: Color(0xFF6C63FF),
                          fontWeight: FontWeight.bold),
                    ))),

            SizedBox(
              height: 15,
            ),
            // button login
            MyButton(
              onPressed: () => signIn(context),
              text: "Login",
            ),

            SizedBox(
              height: 15,
            ),
            // text to register
            Text.rich(TextSpan(children: [
              TextSpan(
                text: "Don't have acount ? ",
              ),
              TextSpan(
                  text: "Register Now",
                  style: TextStyle(
                      color: Color(0xFF6C63FF), fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()
                    ..onTap = widget.showRegister)
            ])),
          ],
        ),
      ),
    );
  }
}
