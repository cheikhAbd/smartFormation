// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';

class DetailsPro extends StatelessWidget {
  final Image? img;
  final Text? text;
  const DetailsPro({super.key, this.img, this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6C63FF),
        title: Text(
          "Details of product",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
        child: Expanded(
          child: Column(
            children: [
              Container(width: 300, height: 300, child: img),
              Container(
                margin: EdgeInsets.only(top: 25),
                child: text,
              )
            ],
          ),
        ),
      ),
    );
  }
}
