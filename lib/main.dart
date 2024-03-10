// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smart_formation/Auth/home_main.dart';
import 'package:smart_formation/firebase_options.dart';
import 'package:smart_formation/pages/forgetPwd.dart';
import 'package:smart_formation/pages/homePage.dart';
import 'package:smart_formation/pages/loginScreen.dart';
import 'package:smart_formation/pages/produit/produitAdd.dart';
import 'package:smart_formation/pages/produit/produitDetails.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      routes: {
        "login": (context) => Login(showRegister: () {}),
        "addProduit": (context) => ProduitAdd(),
        "forgetPwd": (context) => ForgetPwd(),
        "detailsPro": (context) => DetailsPro(),
        "homePage": (context) => HomePage(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeMain(),
    );
  }
}
