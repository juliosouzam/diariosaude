import 'package:cloud_firestore/cloud_firestore.dart';

class VacinaData {
  String nomeVacina;
  String descricaoVacina;
  String idade;
  String sexo;

  VacinaData();

  VacinaData.fromDocument(DocumentSnapshot document) {
    nomeVacina = document.data["nomeVacina"];
    descricaoVacina = document.data["descricaoVacina"];
    idade = document.data["idade"];
    sexo = document.data["sexo"];
  }


}