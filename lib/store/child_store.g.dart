// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChildStore on _ChildStoreBase, Store {
  Computed<bool> _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_ChildStoreBase.isFormValid'))
          .value;

  final _$nameAtom = Atom(name: '_ChildStoreBase.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$parentIdAtom = Atom(name: '_ChildStoreBase.parentId');

  @override
  String get parentId {
    _$parentIdAtom.reportRead();
    return super.parentId;
  }

  @override
  set parentId(String value) {
    _$parentIdAtom.reportWrite(value, super.parentId, () {
      super.parentId = value;
    });
  }

  final _$dateBirthAtom = Atom(name: '_ChildStoreBase.dateBirth');

  @override
  DateTime get dateBirth {
    _$dateBirthAtom.reportRead();
    return super.dateBirth;
  }

  @override
  set dateBirth(DateTime value) {
    _$dateBirthAtom.reportWrite(value, super.dateBirth, () {
      super.dateBirth = value;
    });
  }

  final _$hourBirthAtom = Atom(name: '_ChildStoreBase.hourBirth');

  @override
  DateTime get hourBirth {
    _$hourBirthAtom.reportRead();
    return super.hourBirth;
  }

  @override
  set hourBirth(DateTime value) {
    _$hourBirthAtom.reportWrite(value, super.hourBirth, () {
      super.hourBirth = value;
    });
  }

  final _$weightAtom = Atom(name: '_ChildStoreBase.weight');

  @override
  String get weight {
    _$weightAtom.reportRead();
    return super.weight;
  }

  @override
  set weight(String value) {
    _$weightAtom.reportWrite(value, super.weight, () {
      super.weight = value;
    });
  }

  final _$heightAtom = Atom(name: '_ChildStoreBase.height');

  @override
  String get height {
    _$heightAtom.reportRead();
    return super.height;
  }

  @override
  set height(String value) {
    _$heightAtom.reportWrite(value, super.height, () {
      super.height = value;
    });
  }

  final _$photoAtom = Atom(name: '_ChildStoreBase.photo');

  @override
  File get photo {
    _$photoAtom.reportRead();
    return super.photo;
  }

  @override
  set photo(File value) {
    _$photoAtom.reportWrite(value, super.photo, () {
      super.photo = value;
    });
  }

  final _$adicionandoAtom = Atom(name: '_ChildStoreBase.adicionando');

  @override
  bool get adicionando {
    _$adicionandoAtom.reportRead();
    return super.adicionando;
  }

  @override
  set adicionando(bool value) {
    _$adicionandoAtom.reportWrite(value, super.adicionando, () {
      super.adicionando = value;
    });
  }

  final _$listChildAtom = Atom(name: '_ChildStoreBase.listChild');

  @override
  ObservableList<ChildData> get listChild {
    _$listChildAtom.reportRead();
    return super.listChild;
  }

  @override
  set listChild(ObservableList<ChildData> value) {
    _$listChildAtom.reportWrite(value, super.listChild, () {
      super.listChild = value;
    });
  }

  final _$addChildAsyncAction = AsyncAction('_ChildStoreBase.addChild');

  @override
  Future<bool> addChild() {
    return _$addChildAsyncAction.run(() => super.addChild());
  }

  final _$updateChildAsyncAction = AsyncAction('_ChildStoreBase.updateChild');

  @override
  Future<bool> updateChild(String urlOld, String cId) {
    return _$updateChildAsyncAction.run(() => super.updateChild(urlOld, cId));
  }

  final _$removeChildAsyncAction = AsyncAction('_ChildStoreBase.removeChild');

  @override
  Future<bool> removeChild(String urlOld, String cId) {
    return _$removeChildAsyncAction.run(() => super.removeChild(urlOld, cId));
  }

  @override
  String toString() {
    return '''
name: ${name},
parentId: ${parentId},
dateBirth: ${dateBirth},
hourBirth: ${hourBirth},
weight: ${weight},
height: ${height},
photo: ${photo},
adicionando: ${adicionando},
listChild: ${listChild},
isFormValid: ${isFormValid}
    ''';
  }
}
