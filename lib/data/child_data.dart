import 'package:cloud_firestore/cloud_firestore.dart';

class ChildData {
  String cid;
  String userId;
  String name;
  String photo;
  DateTime dateBirth;
  DateTime hourBirth;
  String weight;
  String height;

  ChildData();

  ChildData.fromDocument(DocumentSnapshot document) {
    cid = document.documentID;
    name = document.data["name"];
    photo = document.data["photo"];
    userId = document.data["userId"];
    dateBirth = document.data["dateBirth"].toDate();
    hourBirth = document.data["hourBirth"].toDate();
    weight = document.data["weight"];
    height = document.data["height"];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "photo": photo,
      "userId": userId,
      "dateBirth": dateBirth,
      "hourBirth": hourBirth,
      "weight": weight,
      "height": height,
    };
  }
}