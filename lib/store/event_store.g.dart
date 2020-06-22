// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EventStore on _EventStoreBase, Store {
  Computed<bool> _$isNomeValidComputed;

  @override
  bool get isNomeValid =>
      (_$isNomeValidComputed ??= Computed<bool>(() => super.isNomeValid,
              name: '_EventStoreBase.isNomeValid'))
          .value;
  Computed<bool> _$isDateValidComputed;

  @override
  bool get isDateValid =>
      (_$isDateValidComputed ??= Computed<bool>(() => super.isDateValid,
              name: '_EventStoreBase.isDateValid'))
          .value;
  Computed<bool> _$isHorarioValidComputed;

  @override
  bool get isHorarioValid =>
      (_$isHorarioValidComputed ??= Computed<bool>(() => super.isHorarioValid,
              name: '_EventStoreBase.isHorarioValid'))
          .value;
  Computed<bool> _$isDescricaoValidComputed;

  @override
  bool get isDescricaoValid => (_$isDescricaoValidComputed ??= Computed<bool>(
          () => super.isDescricaoValid,
          name: '_EventStoreBase.isDescricaoValid'))
      .value;
  Computed<bool> _$istipoValidComputed;

  @override
  bool get istipoValid =>
      (_$istipoValidComputed ??= Computed<bool>(() => super.istipoValid,
              name: '_EventStoreBase.istipoValid'))
          .value;

  final _$nomeEventAtom = Atom(name: '_EventStoreBase.nomeEvent');

  @override
  String get nomeEvent {
    _$nomeEventAtom.reportRead();
    return super.nomeEvent;
  }

  @override
  set nomeEvent(String value) {
    _$nomeEventAtom.reportWrite(value, super.nomeEvent, () {
      super.nomeEvent = value;
    });
  }

  final _$dateEventAtom = Atom(name: '_EventStoreBase.dateEvent');

  @override
  DateTime get dateEvent {
    _$dateEventAtom.reportRead();
    return super.dateEvent;
  }

  @override
  set dateEvent(DateTime value) {
    _$dateEventAtom.reportWrite(value, super.dateEvent, () {
      super.dateEvent = value;
    });
  }

  final _$horarioEventAtom = Atom(name: '_EventStoreBase.horarioEvent');

  @override
  String get horarioEvent {
    _$horarioEventAtom.reportRead();
    return super.horarioEvent;
  }

  @override
  set horarioEvent(String value) {
    _$horarioEventAtom.reportWrite(value, super.horarioEvent, () {
      super.horarioEvent = value;
    });
  }

  final _$descricaoEventAtom = Atom(name: '_EventStoreBase.descricaoEvent');

  @override
  String get descricaoEvent {
    _$descricaoEventAtom.reportRead();
    return super.descricaoEvent;
  }

  @override
  set descricaoEvent(String value) {
    _$descricaoEventAtom.reportWrite(value, super.descricaoEvent, () {
      super.descricaoEvent = value;
    });
  }

  final _$tipoEventAtom = Atom(name: '_EventStoreBase.tipoEvent');

  @override
  String get tipoEvent {
    _$tipoEventAtom.reportRead();
    return super.tipoEvent;
  }

  @override
  set tipoEvent(String value) {
    _$tipoEventAtom.reportWrite(value, super.tipoEvent, () {
      super.tipoEvent = value;
    });
  }

  final _$loadingAtom = Atom(name: '_EventStoreBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$addEventDataAsyncAction = AsyncAction('_EventStoreBase.addEventData');

  @override
  Future<bool> addEventData(EventData e, String uId, String cId) {
    return _$addEventDataAsyncAction.run(() => super.addEventData(e, uId, cId));
  }

  final _$_EventStoreBaseActionController =
      ActionController(name: '_EventStoreBase');

  @override
  void setNomeEvent(String value) {
    final _$actionInfo = _$_EventStoreBaseActionController.startAction(
        name: '_EventStoreBase.setNomeEvent');
    try {
      return super.setNomeEvent(value);
    } finally {
      _$_EventStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDateEvent(DateTime value) {
    final _$actionInfo = _$_EventStoreBaseActionController.startAction(
        name: '_EventStoreBase.setDateEvent');
    try {
      return super.setDateEvent(value);
    } finally {
      _$_EventStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHorarioEvent(String value) {
    final _$actionInfo = _$_EventStoreBaseActionController.startAction(
        name: '_EventStoreBase.setHorarioEvent');
    try {
      return super.setHorarioEvent(value);
    } finally {
      _$_EventStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDescricaoEvent(String value) {
    final _$actionInfo = _$_EventStoreBaseActionController.startAction(
        name: '_EventStoreBase.setDescricaoEvent');
    try {
      return super.setDescricaoEvent(value);
    } finally {
      _$_EventStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void seTipoEvent(bool value, String tipo) {
    final _$actionInfo = _$_EventStoreBaseActionController.startAction(
        name: '_EventStoreBase.seTipoEvent');
    try {
      return super.seTipoEvent(value, tipo);
    } finally {
      _$_EventStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
nomeEvent: ${nomeEvent},
dateEvent: ${dateEvent},
horarioEvent: ${horarioEvent},
descricaoEvent: ${descricaoEvent},
tipoEvent: ${tipoEvent},
loading: ${loading},
isNomeValid: ${isNomeValid},
isDateValid: ${isDateValid},
isHorarioValid: ${isHorarioValid},
isDescricaoValid: ${isDescricaoValid},
istipoValid: ${istipoValid}
    ''';
  }
}
