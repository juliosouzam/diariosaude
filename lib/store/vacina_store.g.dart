// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vacina_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VacinaStore on _VacinaStoreBase, Store {
  final _$listVacinasAtom = Atom(name: '_VacinaStoreBase.listVacinas');

  @override
  ObservableList<VacinaData> get listVacinas {
    _$listVacinasAtom.reportRead();
    return super.listVacinas;
  }

  @override
  set listVacinas(ObservableList<VacinaData> value) {
    _$listVacinasAtom.reportWrite(value, super.listVacinas, () {
      super.listVacinas = value;
    });
  }

  final _$loadVacinaAsyncAction = AsyncAction('_VacinaStoreBase.loadVacina');

  @override
  Future<void> loadVacina() {
    return _$loadVacinaAsyncAction.run(() => super.loadVacina());
  }

  @override
  String toString() {
    return '''
listVacinas: ${listVacinas}
    ''';
  }
}
