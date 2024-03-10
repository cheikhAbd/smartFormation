// ignore_for_file: avoid_print, unused_local_variable

import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:smart_formation/data/model/produitModel.dart';

class ProduitSer {
  //Upload image to firebase
  static Future<String> _uploadImg(String childName, Uint8List file) async {
    Reference ref = FirebaseStorage.instance.ref().child(childName).child("id");
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // create produit
  static Future create({required Produit pro, required Uint8List file}) async {
    final proCollection = FirebaseFirestore.instance.collection("produit");
    String image = await _uploadImg("produitImg", file);

    final uid = proCollection.doc().id;

    final doc = proCollection.doc(uid);

    final newPro =
        Produit(id: uid, titre: pro.titre, descri: pro.descri, image: image)
            .toJson();

    try {
      await doc.set(newPro);
    } catch (e) {
      print("has an error !");
    }
  }

  //read produit
  static readPro() {
    final proCollection = FirebaseFirestore.instance.collection("produit");
    return proCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => Produit.fromSnapshot(e)).toList());
  }

  // delet product
  static Future delete(Produit pro) async {
    final proCollection = FirebaseFirestore.instance.collection("produit");

    try {
      final docRef = proCollection.doc(pro.id).delete();
    } catch (e) {
      print(e);
    }
  }
}
