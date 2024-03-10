// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyTextField extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controler;
  final String label;
  final String hintText;
  final int? lines;
  bool obs;
  MyTextField(
      {super.key,
      required this.controler,
      required this.hintText,
      required this.obs,
      required this.label,
      this.lines});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        maxLines:
            (widget.hintText.toLowerCase() != "description") ? 1 : widget.lines,
        controller: widget.controler,
        obscureText: widget.obs,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Color.fromARGB(255, 54, 54, 54)),
          labelText: widget.label,
          labelStyle: TextStyle(color: Color.fromARGB(255, 54, 54, 54)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF6C63FF)),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          suffixIcon: (widget.hintText.toLowerCase() != 'password')
              ? null
              : togglePwd(),
        ),
      ),
    );
  }

  // show password
  Widget togglePwd() {
    return IconButton(
      onPressed: () {
        setState(() {
          widget.obs = !widget.obs;
        });
      },
      icon: widget.obs ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
      color: Colors.grey,
    );
  }
}
