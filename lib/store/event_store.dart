import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diariosaude/data/event_data.dart';
import 'package:mobx/mobx.dart';

part 'event_store.g.dart';

class EventStore = _EventStoreBase with _$EventStore;

abstract class _EventStoreBase with Store {

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
  bool loading = false;

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
          .collection("children")
          .document(e.cid)
          .collection("eventos")
          .add(e.toMap())
          .then((doc) {
          }).catchError((e){
         print(e);
      });
      loading = false;
      getEventos(uId, e.cid);
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
          .collection("children")
          .document(e.cid)
          .collection("eventos")
          .document(e.eid)
          .updateData(e.toMap()).then((e){

      }).catchError((e){
        print(e);
      });

      loading = false;
      nomeEvent = "";
      dateEvent = null;
      horarioEvent = "";
      descricaoEvent = "";
      tipoEvent = "";
      getEventos(uId, e.cid);
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
          .collection("children")
          .document(e.cid)
          .collection("eventos")
          .document(e.eid)
          .delete().then((e){

      }).catchError((e){
        print(e);
      });

      loading = false;
      nomeEvent = "";
      dateEvent = null;
      horarioEvent = "";
      descricaoEvent = "";
      tipoEvent = "";
      getEventos(uId, e.cid);
      return true;
    } catch(error){
      loading = false;
      return false;
    }

  }

  Future<bool> getEventos(String uId, String cId) async {
    try{
      QuerySnapshot query = await Firestore.instance
          .collection("users")
          .document(uId)
          .collection("children")
          .document(cId)
          .collection("eventos")
          .getDocuments();

      listEvent = query.documents.map((doc) => EventData.fromDocument(doc)).toList().asObservable();
      listEventFilter = listEvent;
      DateTime data = DateTime.now();
      listEventFilter = listEventFilter.where((filter) => filter.dateEvent.isAfter(DateTime.now()) ||
          (filter.dateEvent.month == data.month
              && filter.dateEvent.day == data.day
              && filter.dateEvent.year == data.year) ).toList().asObservable();
      return true;
    }catch(error){
      return false;
    }

  }



}
