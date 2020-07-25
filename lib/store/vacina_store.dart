import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diariosaude/data/vacina_data.dart';
import 'package:mobx/mobx.dart';
part 'vacina_store.g.dart';

class VacinaStore = _VacinaStoreBase with _$VacinaStore;

abstract class _VacinaStoreBase with Store {
  @observable
  ObservableList<VacinaData> listVacinas = ObservableList<VacinaData>();

  @action
  Future<void> loadVacina() async {
    QuerySnapshot query =
        await Firestore.instance.collection("vacina").getDocuments();
    listVacinas = query.documents
        .map((doc) => VacinaData.fromDocument(doc))
        .toList()
        .asObservable();
  }

  DateTime transfomarStringToDate(String data) {
    String dataParse;
    DateTime date;
    dataParse = data.substring(6, 10);
    dataParse = dataParse + "-" + data.substring(3, 5);
    dataParse = dataParse + "-" + data.substring(0, 2);
    dataParse = dataParse + " 12:00";
    date = DateTime.parse(dataParse);
    return date;
  }

  String calculaIdadeString(DateTime data, DateTime nasc) {
    int dia;
    int ano;
    int mes;
    String idade;

    ano = data.year - nasc.year;
    mes = data.month - nasc.month;
    dia = data.day - nasc.day;

    if (dia < 0) {
      mes = mes - 1;
      dia = 30 + dia;
    }
    if (mes < 0) {
      ano = ano - 1;
      mes = 12 + mes;
    }
    if (ano == 0) {
      if (mes == 0) {
        idade = dia.toString() + " Dias";
      } else {
        idade = mes.toString() + " Mês e " + dia.toString() + " Dias";
      }
    } else if (ano == 1) {
      if (mes == 1) {
        idade = ano.toString() +
            " Ano, " +
            mes.toString() +
            " Mês e " +
            dia.toString() +
            " Dias.";
      } else {
        idade = ano.toString() +
            " Ano, " +
            mes.toString() +
            " Meses e " +
            dia.toString() +
            " Dias.";
      }
    } else {
      if (mes == 1) {
        idade = ano.toString() +
            " Anos, " +
            mes.toString() +
            " Mês e " +
            dia.toString() +
            " Dias.";
      } else {
        idade = ano.toString() +
            " Anos, " +
            mes.toString() +
            " Meses e " +
            dia.toString() +
            " Dias.";
      }
    }
    if (ano < 0) {
      idade = "O Dias";
    }
    return idade;
  }

  String calculaIdadeDate(DateTime data, DateTime nasc) {
    int dia;
    int ano;
    int mes;
    String idade;

    ano = data.year - nasc.year;
    mes = data.month - nasc.month;
    dia = data.day - nasc.day;

    if (dia < 0) {
      mes = mes - 1;
      dia = 30 + dia;
    }
    if (mes < 0) {
      ano = ano - 1;
      mes = 12 + mes;
    }
    if (dia <= 9) {
      idade = "0" + dia.toString();
    } else {
      idade = dia.toString();
    }

    if (mes <= 9) {
      idade = idade + "-0" + mes.toString();
    } else {
      idade = idade + "-" + mes.toString();
    }
    if (ano <= 9) {
      idade = idade + "-000" + ano.toString();
    } else {
      idade = idade + "-00" + ano.toString();
    }

    return idade;
  }

  String intervaloVacina(DateTime idade) {
    if (idade.year == 0 && idade.month == 0 && idade.day < 10) {
      return "00-00-0000";
    } else if (idade.year == 0 && idade.month == 1 && idade.day < 30) {
      return "00-02-0000";
    } else if (idade.year == 0 && idade.month == 2 && idade.day < 30) {
      return "00-03-0000";
    } else if (idade.year == 0 && idade.month == 3 && idade.day < 30) {
      return "00-04-0000";
    } else if (idade.year == 0 && idade.month == 4 && idade.day < 30) {
      return "00-05-0000";
    } else if (idade.year == 0 && idade.month == 5 && idade.day < 30) {
      return "00-06-0000";
    } else if (idade.year == 0 && idade.month == 8 && idade.day < 30) {
      return "00-09-0000";
    } else if (idade.year == 0 && idade.month == 11 && idade.day < 30) {
      return "00-00-0001";
    } else if (idade.year == 1 && idade.month == 3 && idade.day < 30) {
      return "00-03-0001";
    } else if (idade.year == 3 && idade.month == 11 && idade.day < 30) {
      return "00-00-0004";
    } else if (idade.year == 9 && idade.month == 11 && idade.day < 30) {
      return "00-00-0010";
    }

    return "00-00-0100";
  }

  String idadeCompletar(DateTime idade) {
    if (idade.year == 0 && idade.month == 0 && idade.day < 10) {
      return "ao nascer";
    } else if (idade.year == 0 && idade.month == 1 && idade.day < 30) {
      return "vai completar 2 meses.";
    } else if (idade.year == 0 && idade.month == 2 && idade.day < 30) {
      return "vai completar 3 meses.";
    } else if (idade.year == 0 && idade.month == 3 && idade.day < 30) {
      return "vai completar 4 meses.";
    } else if (idade.year == 0 && idade.month == 4 && idade.day < 30) {
      return "vai completar 5 meses.";
    } else if (idade.year == 0 && idade.month == 5 && idade.day < 30) {
      return "vai completar 6 meses.";
    } else if (idade.year == 0 && idade.month == 8 && idade.day < 30) {
      return "vai completar 9 meses.";
    } else if (idade.year == 0 && idade.month == 11 && idade.day < 30) {
      return "vai completar 1 ano.";
    } else if (idade.year == 1 && idade.month == 3 && idade.day < 30) {
      return "vai completar 1 ano e 3 meses.";
    } else if (idade.year == 3 && idade.month == 11 && idade.day < 30) {
      return "vai completar 4 ano.";
    } else if (idade.year == 9 && idade.month == 11 && idade.day < 30) {
      return "vai completar 10 ano.";
    }

    return "00-00-0100";
  }
}
