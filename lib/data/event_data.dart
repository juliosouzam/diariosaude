import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class EventData {
  String eid; //id do evento
  String cid; //id do filho
  String nameEvent;
  DateTime dateEvent;
  String horarioEvent;
  String descriptionEvent;
  String typeEvent;
  File photo;
  String photoUrl;
  File document;
  String documentUrl;

  EventData();

  EventData.fromDocument(DocumentSnapshot document) {
    eid = document.documentID;
    cid = document.data["cid"];
    nameEvent = document.data["nameEvent"];
    dateEvent = document.data["dateEvent"].toDate();
    horarioEvent = document.data["horarioEvent"];
    descriptionEvent = document.data["descriptionEvent"];
    typeEvent = document.data["typeEvent"];
  }

  Map<String, dynamic> toMap() {
    return {
      "cid": cid,
      "nameEvent": nameEvent,
      "dateEvent": dateEvent,
      "horarioEvent": horarioEvent,
      "descriptionEvent": descriptionEvent,
      "typeEvent": typeEvent,
      "photo": photoUrl,
      "document": documentUrl,
    };
  }
}
