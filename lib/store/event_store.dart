import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diariosaude/data/event_data.dart';
import 'package:mobx/mobx.dart';

part 'event_store.g.dart';

class EventStore = _EventStoreBase with _$EventStore;

abstract class _EventStoreBase with Store {

  @observable
  String idFilhoEvent = "";

  @observable
  String nomeEvent = "";

  @observable
  DateTime dateEvent;

  @observable
  String horarioEvent = "";

  @observable
  String descricaoEvent = "";

  @observable
  String tipoEvent = "";

  @observable
  ObservableList<EventData> listEvent = ObservableList<EventData>();

  @observable
  ObservableList<EventData> listEventFilter = ObservableList<EventData>();

  @observable
  ObservableList<EventData> listEventFilterFilho = ObservableList<EventData>();

  List<EventData> list = List<EventData>();

  @observable
  bool loading = false;

  @observable
  int numero = 0;

  bool eventChange = true;

  @action
  void setIdFilhoEvent(String value) => idFilhoEvent = value;

  @action
  void setNomeEvent(String value) => nomeEvent = value;

  @action
  void setDateEvent(DateTime value) => dateEvent = value;

  @action
  void setHorarioEvent(String value) => horarioEvent = value;

  @action
  void setDescricaoEvent(String value) => descricaoEvent = value;

  @action
  void seTipoEvent(bool value, String tipo) {
    tipoEvent = value ? tipo : null;
  }

  @action
  void setNumero(int value) => numero = value;


  @computed
  bool get isIdFilhoValid => idFilhoEvent.isNotEmpty;

  @computed
  bool get isNomeValid => nomeEvent.isNotEmpty;

  @computed
  bool get isDateValid => dateEvent != null;

  @computed
  bool get isHorarioValid => horarioEvent.isNotEmpty;

  @computed
  bool get isDescricaoValid => descricaoEvent.isNotEmpty;

  @computed
  bool get istipoValid => tipoEvent.isNotEmpty;

  @action
  Future<bool> addEventData(EventData e, String uId) async{
    loading = true;
    try{
      listEvent.add(e);
      await Firestore.instance
          .collection("users")
          .document(uId)
          // .collection("children")
          // .document(e.cid)
          .collection("eventos")
          .add(e.toMap())
          .then((doc) {
            eventChange = true;
          }).catchError((e){
         print(e);
      });
      loading = false;
      getEventos(uId);
      return true;
    } catch(error){
      loading = false;
      return false;
    }

  }

  @action
  Future<bool> updateEventData(EventData e, String uId) async{
    loading = true;
    try{

      await Firestore.instance
          .collection("users")
          .document(uId)
          //.collection("children")
          //.document(e.cid)
          .collection("eventos")
          .document(e.eid)
          .updateData(e.toMap()).then((e){
            eventChange = true;
      }).catchError((e){
        print(e);
      });

      loading = false;
      nomeEvent = "";
      dateEvent = null;
      horarioEvent = "";
      descricaoEvent = "";
      tipoEvent = "";
      getEventos(uId);
      return true;
    } catch(error){
      loading = false;
      return false;
    }

  }

  @action
  Future<bool> removeEvent(EventData e, String uId) async{
    loading = true;
    try{

      await Firestore.instance
          .collection("users")
          .document(uId)
          // .collection("children")
          // .document(e.cid)
          .collection("eventos")
          .document(e.eid)
          .delete().then((e){
            eventChange = true;
      }).catchError((e){
        print(e);
      });

      loading = false;
      nomeEvent = "";
      dateEvent = null;
      horarioEvent = "";
      descricaoEvent = "";
      tipoEvent = "";
      getEventos(uId);
      return true;
    } catch(error){
      loading = false;
      return false;
    }

  }

  Future<bool> getEventos(String uId) async {
    if(eventChange){
      try{
        QuerySnapshot query = await Firestore.instance
            .collection("users")
            .document(uId)
        // .collection("children")
        // .document(cId)
            .collection("eventos")
            .getDocuments().then((e){
              eventChange = false;
              return e;
        });

        listEvent = query.documents.map((doc) => EventData.fromDocument(doc)).toList().asObservable();
        /*listEventFilter = listEvent;
        DateTime data = DateTime.now();
        listEventFilter = listEventFilter.where((filter) => filter.dateEvent.isAfter(DateTime.now()) ||
            (filter.dateEvent.month == data.month
                && filter.dateEvent.day == data.day
                && filter.dateEvent.year == data.year) ).toList().asObservable();*/
        return true;
      }catch(error){
        return false;
      }
    }else{
      return false;
    }
  }

  Future<bool> getEventosProximos(String uId) async {
    try{
      list = listEvent;
      DateTime data = DateTime.now();
      list = list.where((filter) =>
      filter.dateEvent.isAfter(DateTime.now()) ||
          (filter.dateEvent.month == data.month
              && filter.dateEvent.day == data.day
              && filter.dateEvent.year == data.year)).toList().asObservable();
      list.sort((a, b) => a.dateEvent.isAfter(b.dateEvent) ? 1 : -1);
      listEventFilter = list;
      return true;
    }catch(error){
    return false;
    }
  }

  Future<bool> getEventosTodos(String uId) async {
    try{
      list = listEvent;
      list.sort((a, b) => a.dateEvent.isAfter(b.dateEvent) ? -1 : 1);
      listEventFilter = list;
      return true;
    }catch(error){
      return false;
    }
  }

  Future<bool> getEventosVacina(String uId) async {
    try{
      list = listEvent;
      list = list.where((filter) =>
      filter.typeEvent.compareTo("vacina") == 0).toList().asObservable();
      list.sort((a, b) => a.dateEvent.isAfter(b.dateEvent) ? -1 : 1);
      listEventFilter = list;
      return true;
    }catch(error){
      return false;
    }
  }

  Future<bool> getEventosConsulta(String uId) async {
    try{
      list = listEvent;
      list = list.where((filter) =>
      filter.typeEvent.compareTo("consulta") == 0).toList().asObservable();
      list.sort((a, b) => a.dateEvent.isAfter(b.dateEvent) ? -1 : 1);
      listEventFilter = list;
      return true;
    }catch(error){
      return false;
    }
  }

  Future<bool> getEventosRotina(String uId) async {
      try{
        list = listEvent;
        list = list.where((filter) =>
            /*(filter.dateEvent.isAfter(DateTime.now()) && filter.typeEvent.compareTo("rotina") == 0) ||
            (filter.dateEvent.month == data.month
                && filter.dateEvent.day == data.day
                && filter.dateEvent.year == data.year)
            && filter.typeEvent.compareTo("rotina") == 0).toList().asObservable();*/
        filter.typeEvent.compareTo("rotina") == 0).toList().asObservable();
        list.sort((a, b) => a.dateEvent.isAfter(b.dateEvent) ? -1 : 1);
        listEventFilter = list;
        return true;
      }catch(error){
        return false;
      }
  }

  Future<bool> getEventosFilho(String uId, String cId) async {
    try{
      list = listEvent;
      DateTime data = DateTime.now();
      list = list.where((filter) =>
      (filter.dateEvent.isAfter(DateTime.now()) && filter.cid.compareTo(cId) == 0) ||
            (filter.dateEvent.month == data.month
                && filter.dateEvent.day == data.day
                && filter.dateEvent.year == data.year)
            && filter.cid.compareTo(cId) == 0).toList().asObservable();
      list.sort((a, b) => a.dateEvent.isAfter(b.dateEvent) ? 1 : -1);
      listEventFilterFilho = list;
      return true;
    }catch(error){
      return false;
    }
  }


}
