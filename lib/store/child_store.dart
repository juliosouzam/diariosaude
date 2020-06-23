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
  ObservableList<ChildData> listChild = ObservableList<ChildData>();

  @observable
  bool addFilho = false;

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

      listChild.add(data);

      await Firestore.instance
          .collection("users")
          .document(parentId)
          .collection("children")
          .add(data.toMap());


      name = "";
      dateBirth = null;
      hourBirth = null;
      weight = "";
      height = "";
      photo = null;
      return true;
    }catch(error){
      return false;
    }

  }

  Future getChildren(String uId) async {
    QuerySnapshot query = await Firestore.instance
        .collection("users")
        .document(uId)
        .collection("children")
        .getDocuments();

    listChild = query.documents.map((doc) => ChildData.fromDocument(doc)).toList().asObservable();

  }
}
