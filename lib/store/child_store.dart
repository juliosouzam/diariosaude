import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  Future<void> addChild() async {
    Map<String, dynamic> data = {
      'name': name,
      'dateBirth': dateBirth,
      'hourBirth': hourBirth,
      'weight': weight,
      'height': height,
    };

    StorageUploadTask task = FirebaseStorage.instance
        .ref()
        .child(DateTime.now().millisecondsSinceEpoch.toString())
        .putFile(photo);

    StorageTaskSnapshot taskSnapshot = await task.onComplete;
    String url = await taskSnapshot.ref.getDownloadURL();
    data['photo'] = url;

    await Firestore.instance
        .collection("users")
        .document(parentId)
        .collection("children")
        .add(data);
  }

  Future getChildren() async {
    QuerySnapshot query = await Firestore.instance
        .collection("users")
        .document(_loginStore.currentUser.value.uid)
        .collection("children")
        .getDocuments();

    print(query.documents);
  }
}
