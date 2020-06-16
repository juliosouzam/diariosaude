// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on _LoginStoreBase, Store {
  Computed<bool> _$isNameValidComputed;

  @override
  bool get isNameValid =>
      (_$isNameValidComputed ??= Computed<bool>(() => super.isNameValid,
              name: '_LoginStoreBase.isNameValid'))
          .value;
  Computed<bool> _$isEmailValidComputed;

  @override
  bool get isEmailValid =>
      (_$isEmailValidComputed ??= Computed<bool>(() => super.isEmailValid,
              name: '_LoginStoreBase.isEmailValid'))
          .value;
  Computed<bool> _$isPasswordValidComputed;

  @override
  bool get isPasswordValid =>
      (_$isPasswordValidComputed ??= Computed<bool>(() => super.isPasswordValid,
              name: '_LoginStoreBase.isPasswordValid'))
          .value;
  Computed<bool> _$isPasswordConfirmValidComputed;

  @override
  bool get isPasswordConfirmValid => (_$isPasswordConfirmValidComputed ??=
          Computed<bool>(() => super.isPasswordConfirmValid,
              name: '_LoginStoreBase.isPasswordConfirmValid'))
      .value;
  Computed<Function> _$loginPressedComputed;

  @override
  Function get loginPressed =>
      (_$loginPressedComputed ??= Computed<Function>(() => super.loginPressed,
              name: '_LoginStoreBase.loginPressed'))
          .value;
  Computed<bool> _$signUpPressedComputed;

  @override
  bool get signUpPressed =>
      (_$signUpPressedComputed ??= Computed<bool>(() => super.signUpPressed,
              name: '_LoginStoreBase.signUpPressed'))
          .value;
  Computed<bool> _$recoverPassPressedComputed;

  @override
  bool get recoverPassPressed => (_$recoverPassPressedComputed ??=
          Computed<bool>(() => super.recoverPassPressed,
              name: '_LoginStoreBase.recoverPassPressed'))
      .value;

  final _$uidAtom = Atom(name: '_LoginStoreBase.uid');

  @override
  String get uid {
    _$uidAtom.reportRead();
    return super.uid;
  }

  @override
  set uid(String value) {
    _$uidAtom.reportWrite(value, super.uid, () {
      super.uid = value;
    });
  }

  final _$nameAtom = Atom(name: '_LoginStoreBase.name');

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

  final _$photoAtom = Atom(name: '_LoginStoreBase.photo');

  @override
  String get photo {
    _$photoAtom.reportRead();
    return super.photo;
  }

  @override
  set photo(String value) {
    _$photoAtom.reportWrite(value, super.photo, () {
      super.photo = value;
    });
  }

  final _$loadingAtom = Atom(name: '_LoginStoreBase.loading');

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

  final _$loggedInAtom = Atom(name: '_LoginStoreBase.loggedIn');

  @override
  bool get loggedIn {
    _$loggedInAtom.reportRead();
    return super.loggedIn;
  }

  @override
  set loggedIn(bool value) {
    _$loggedInAtom.reportWrite(value, super.loggedIn, () {
      super.loggedIn = value;
    });
  }

  final _$emailAtom = Atom(name: '_LoginStoreBase.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$passwordAtom = Atom(name: '_LoginStoreBase.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$passwordVisibleAtom = Atom(name: '_LoginStoreBase.passwordVisible');

  @override
  bool get passwordVisible {
    _$passwordVisibleAtom.reportRead();
    return super.passwordVisible;
  }

  @override
  set passwordVisible(bool value) {
    _$passwordVisibleAtom.reportWrite(value, super.passwordVisible, () {
      super.passwordVisible = value;
    });
  }

  final _$passwordConfirmAtom = Atom(name: '_LoginStoreBase.passwordConfirm');

  @override
  String get passwordConfirm {
    _$passwordConfirmAtom.reportRead();
    return super.passwordConfirm;
  }

  @override
  set passwordConfirm(String value) {
    _$passwordConfirmAtom.reportWrite(value, super.passwordConfirm, () {
      super.passwordConfirm = value;
    });
  }

  final _$loginWithGoogleAsyncAction =
      AsyncAction('_LoginStoreBase.loginWithGoogle');

  @override
  Future<bool> loginWithGoogle() {
    return _$loginWithGoogleAsyncAction.run(() => super.loginWithGoogle());
  }

  final _$loginWithFacebookAsyncAction =
      AsyncAction('_LoginStoreBase.loginWithFacebook');

  @override
  Future<bool> loginWithFacebook() {
    return _$loginWithFacebookAsyncAction.run(() => super.loginWithFacebook());
  }

  final _$loginWithEmailAndPasswordAsyncAction =
      AsyncAction('_LoginStoreBase.loginWithEmailAndPassword');

  @override
  Future<bool> loginWithEmailAndPassword(
      {@required String email, @required String password}) {
    return _$loginWithEmailAndPasswordAsyncAction.run(() =>
        super.loginWithEmailAndPassword(email: email, password: password));
  }

  final _$recoverPasswordAsyncAction =
      AsyncAction('_LoginStoreBase.recoverPassword');

  @override
  Future<void> recoverPassword(
      {@required String email,
      @required VoidCallback onSuccess,
      @required VoidCallback onFailure}) {
    return _$recoverPasswordAsyncAction.run(() => super.recoverPassword(
        email: email, onSuccess: onSuccess, onFailure: onFailure));
  }

  final _$signUpAsyncAction = AsyncAction('_LoginStoreBase.signUp');

  @override
  Future<bool> signUp(
      {@required Map<String, dynamic> userData, @required String password}) {
    return _$signUpAsyncAction
        .run(() => super.signUp(userData: userData, password: password));
  }

  final _$_LoginStoreBaseActionController =
      ActionController(name: '_LoginStoreBase');

  @override
  void setName(String value) {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase.setName');
    try {
      return super.setName(value);
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmail(String value) {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void togglePasswordVisibility() {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase.togglePasswordVisibility');
    try {
      return super.togglePasswordVisibility();
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPasswordConfirm(String value) {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase.setPasswordConfirm');
    try {
      return super.setPasswordConfirm(value);
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
uid: ${uid},
name: ${name},
photo: ${photo},
loading: ${loading},
loggedIn: ${loggedIn},
email: ${email},
password: ${password},
passwordVisible: ${passwordVisible},
passwordConfirm: ${passwordConfirm},
isNameValid: ${isNameValid},
isEmailValid: ${isEmailValid},
isPasswordValid: ${isPasswordValid},
isPasswordConfirmValid: ${isPasswordConfirmValid},
loginPressed: ${loginPressed},
signUpPressed: ${signUpPressed},
recoverPassPressed: ${recoverPassPressed}
    ''';
  }
}
