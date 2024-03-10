import 'package:cloud_firestore/cloud_firestore.dart';

class Produit {
  final String? id;
  final String? titre;
  final String? descri;
  final String? image;

  Produit({this.titre, this.descri, this.image, this.id});

  factory Produit.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Produit(
      titre: snapshot['titre'],
      descri: snapshot['descri'],
      image: snapshot['imageUrl'],
      id: snapshot['uid'],
    );
  }

  Map<String, dynamic> toJson() =>
      {"titre": titre, "descri": descri, "imageUrl": image, "uid": id};
}
