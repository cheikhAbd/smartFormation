// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_formation/data/Produit/servicePro.dart';
import 'package:smart_formation/data/model/produitModel.dart';
import 'package:smart_formation/pages/produit/produitDetails.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "List of products",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        actions: [
          GestureDetector(
              onTap: () => Navigator.of(context).pushNamed("addProduit"),
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Icon(Icons.add, color: Colors.white),
              )),
          GestureDetector(
              onTap: () => FirebaseAuth.instance.signOut(),
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              )),
        ],
        backgroundColor: Color(0xFF6C63FF),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 10,
          ),
          child: StreamBuilder<List<Produit>>(
            stream: ProduitSer.readPro(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text("Something is wrong !"));
              }
              if (snapshot.hasData) {
                final products = snapshot.data;

                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: products!.length,
                          itemBuilder: (context, i) {
                            final prod = products[i];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Image.network(
                                    "${prod.image}",
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                title: Text(
                                  "${prod.titre}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailsPro(
                                                  img: Image.network(
                                                      "${prod.image}"),
                                                  text: Text("${prod.descri}"),
                                                )));
                                  },
                                  child: Row(
                                    children: [
                                      Text("voir details "),
                                      Icon(
                                        Icons.forward,
                                        color: Color(0xFF6C63FF),
                                      )
                                    ],
                                  ),
                                ),
                                tileColor: Colors.grey[200],
                                trailing: GestureDetector(
                                    onTap: () {
                                      ProduitSer.delete(prod);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        backgroundColor: Color(0xFF6C63FF),
                                        content: Text(
                                            "The item is delete successful !"),
                                      ));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: Icon(
                                        Icons.delete,
                                        color: Color(0xFF6C63FF),
                                      ),
                                    )),
                              ),
                            );
                          }),
                    ),
                  ],
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          )),
    );
  }
}
