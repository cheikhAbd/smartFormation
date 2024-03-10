// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, unused_field, unnecessary_null_comparison, avoid_print, avoid_unnecessary_containers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smart_formation/components/myButton.dart';
import 'package:smart_formation/components/myInput.dart';

class SignUp extends StatefulWidget {
  final VoidCallback showLogin;

  const SignUp({super.key, required this.showLogin});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _email = TextEditingController();
  final _pwd = TextEditingController();
  final _pwdConf = TextEditingController();

  // sign up
  Future signUp(BuildContext context) async {
    try {
      if (_pwd.text.trim() == _pwdConf.text.trim()) {
        // loading
        showDialog(
            context: context,
            builder: (context) {
              return Center(child: CircularProgressIndicator());
            });

        // create users
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _email.text.trim(), password: _pwd.text.trim());

        // delete loading
        Navigator.of(context).pop();

        // navigate to login
        Navigator.of(context).pushNamed("login");
      } else {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Rentrez le meme password !'),
        ));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Mot de passe faible, rendez-le plus fort'),
        ));
      } else if (e.code == 'email-already-in-use') {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Email déjà utilisé, veuillez utiliser l'auteur emil"),
        ));
      } else {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color(0xFF6C63FF),
          content: Text("Email or password isn't correct"),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 35,
            ),
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

            Text(
              "Sign Up",
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

            // confirm password
            MyTextField(
                controler: _pwdConf,
                hintText: "password",
                obs: true,
                label: "Confirm Password"),

            SizedBox(
              height: 25,
            ),

            // button Sign Up
            MyButton(
              onPressed: () => signUp(context),
              text: "Sign Up",
            ),

            SizedBox(
              height: 25,
            ),
            // text to register
            Text.rich(TextSpan(children: [
              TextSpan(
                text: "already have acount ? ",
              ),
              TextSpan(
                  text: "Login Now",
                  style: TextStyle(
                      color: Color(0xFF6C63FF), fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()..onTap = widget.showLogin)
            ])),
          ],
        ),
      ),
    );
  }
}
