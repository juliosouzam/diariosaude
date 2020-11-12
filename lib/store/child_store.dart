import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diariosaude/data/child_data.dart';
import 'package:diariosaude/store/login_store.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobx/mobx.dart';
part 'child_store.g.dart';

class ChildStore = _ChildStoreBase with _$ChildStore;

abstract class _ChildStoreBase with Store {
  final LoginStore _loginStore = LoginStore();
  List<ChildData> childData = List();

  @observable
  String name;

  @observable
  String parentId;

  @observable
  DateTime dateBirth;

  @observable
  DateTime hourBirth;

  @observable
  String weight;

  @observable
  String height;

  @observable
  File photo;

  @observable
  bool adicionando = false;

  @observable
  ObservableList<ChildData> listChild = ObservableList<ChildData>();

  bool childChange = true;

  @computed
  bool get isFormValid =>
      name != null &&
      dateBirth != null &&
      hourBirth != null &&
      weight != null &&
      height != null &&
      parentId != null &&
      photo != null;


  @action
  Future<bool> addChild() async {
    try{
      adicionando = true;
      ChildData data = ChildData();
      data.name = name;
      data.dateBirth = dateBirth;
      data.hourBirth = hourBirth;
      data.weight = weight;
      data.height = height;
      data.userId = parentId;

      StorageUploadTask task = FirebaseStorage.instance
          .ref()
          .child(DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(photo);

      StorageTaskSnapshot taskSnapshot = await task.onComplete;
      String url = await taskSnapshot.ref.getDownloadURL();
      data.photo = url;

      await Firestore.instance
          .collection("users")
          .document(parentId)
          .collection("children")
          .add(data.toMap()).then((value){
            childChange=true;
      });


      name = "";
      dateBirth = null;
      hourBirth = null;
      weight = "";
      height = "";
      photo = null;
      getChildren(parentId);
      adicionando = false;
      return true;
    }catch(error){
      adicionando = false;
      return false;
    }

  }

  Future getChildren(String uId) async {
    if(childChange){
      QuerySnapshot query = await Firestore.instance
          .collection("users")
          .document(uId)
          .collection("children")
          .getDocuments().then((value) {
            childChange = false;
            return value;
      });
      listChild = query.documents.map((doc) => ChildData.fromDocument(doc)).toList().asObservable();
    }
  }

  ChildData getChild(String cId) {
    childData = listChild.where((doc) => doc.cid.compareTo(cId) == 0).toList();
    return childData[0];
  }


  @action
  Future<bool> updateChild(String urlOld, String cId) async {

    try{
      adicionando = true;
      ChildData data = ChildData();
      data.name = name;
      data.dateBirth = dateBirth;
      data.hourBirth = hourBirth;
      data.weight = weight;
      data.height = height;
      data.userId = parentId;

      FirebaseStorage.instance
          .getReferenceFromUrl(urlOld).then((ref){
        ref.delete();
      }).then((value){
        childChange = true;
      }).catchError((e){
        print(e);
      });

      StorageUploadTask task = FirebaseStorage.instance
          .ref()
          .child(DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(photo);

      StorageTaskSnapshot taskSnapshot = await task.onComplete;
      String url = await taskSnapshot.ref.getDownloadURL();
      data.photo = url;


      await Firestore.instance
          .collection("users")
          .document(parentId)
          .collection("children")
          .document(cId)
          .updateData(data.toMap()).then((value){
            childChange = true;
      });

      name = "";
      dateBirth = null;
      hourBirth = null;
      weight = "";
      height = "";
      photo = null;
      getChildren(parentId);
      adicionando = false;
      return true;
    }catch(error){
      adicionando = false;
      return false;
    }

  }

  @action
  Future<bool> removeChild(String urlOld, String cId) async{
    try{
      adicionando = true;
      FirebaseStorage.instance
          .getReferenceFromUrl(urlOld).then((ref){
        ref.delete();
      }).catchError((e){
        print(e);
      });
      await Firestore.instance
          .collection("users")
          .document(parentId)
          .collection("children")
          .document(cId)
          .delete().then((value){
            childChange = true;
      });
      name = "";
      dateBirth = null;
      hourBirth = null;
      weight = "";
      height = "";
      photo = null;
      getChildren(parentId);
      adicionando = false;
      return true;
    }catch(error){
      adicionando = false;
      return false;
    }

  }
}
