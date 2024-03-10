// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, unused_field, unnecessary_null_comparison, avoid_print, use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_formation/components/myButton.dart';
import 'package:smart_formation/components/myInput.dart';
import 'package:smart_formation/data/Produit/servicePro.dart';
import 'package:smart_formation/data/model/produitModel.dart';

class ProduitAdd extends StatefulWidget {
  const ProduitAdd({super.key});

  @override
  State<ProduitAdd> createState() => _ProduitAddState();
}

class _ProduitAddState extends State<ProduitAdd> {
  File? selectedImg;

  Uint8List? _image;
  final _titre = TextEditingController();
  final _descri = TextEditingController();

  // sign up
  Future addProd(BuildContext context) async {
    try {
      // loading
      showDialog(
          context: context,
          builder: (context) {
            return Center(child: CircularProgressIndicator());
          });

      // call the methode to create product from service
      ProduitSer.create(
          pro: Produit(titre: _titre.text.trim(), descri: _descri.text.trim()),
          file: _image!);

      // remove the loading
      Navigator.of(context).pop();

      // naviger to list
      Navigator.of(context).pushNamed("homePage");
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Color(0xFF6C63FF),
        content: Text(
          "Something is wrong !",
          style: TextStyle(fontSize: 18),
        ),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  // select image on phone
  Future<void> selectImg(BuildContext context) async {
    try {
      // loading
      showDialog(
          context: context,
          builder: (context) {
            return Center(child: CircularProgressIndicator());
          });

      // select image in gallery
      final returnImg =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      // remove loading
      Navigator.of(context).pop();

      if (returnImg!.path == null) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color(0xFF6C63FF),
          content: Text("not image selected"),
        ));
      } else {
        setState(() {
          selectedImg = File(returnImg.path);
          _image = File(returnImg.path).readAsBytesSync();
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add product",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF6C63FF),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            // produit image
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 80,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : CircleAvatar(
                        radius: 80,
                        backgroundImage: AssetImage("images/product.png"),
                      ),
                Positioned(
                  child: IconButton(
                    onPressed: () => selectImg(context),
                    icon: Icon(Icons.add_a_photo),
                  ),
                  bottom: -10,
                  left: 110,
                )
              ],
            ),

            SizedBox(
              height: 15,
            ),
            // titre
            MyTextField(
              controler: _titre,
              hintText: "Titre",
              obs: false,
              label: "Tite",
            ),

            SizedBox(
              height: 15,
            ),
            // description
            MyTextField(
              controler: _descri,
              hintText: "Description",
              obs: false,
              label: "Description",
              lines: 4,
            ),

            SizedBox(
              height: 25,
            ),

            // button Add product
            MyButton(
              onPressed: () => addProd(context),
              text: "Sign Up",
            ),
          ],
        ),
      ),
    );
  }
}
