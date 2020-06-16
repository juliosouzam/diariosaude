import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookLogin facebookLogin = new FacebookLogin();

  Observable<FirebaseUser> currentUser;

  @observable
  String uid = '';

  @observable
  String name = '';

  @observable
  String photo = '';

  @observable
  bool loading = false;

  @observable
  bool loggedIn = false;

  @observable
  String email = "";

  @observable
  String password = "";

  @observable
  bool passwordVisible = false;

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;

  @action
  void togglePasswordVisibility() => passwordVisible = !passwordVisible;

  @computed
  bool get isEmailValid =>
      RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
          .hasMatch(email);

  @computed
  bool get isPasswordValid => password.length >= 6;

  @computed
  Function get loginPressed => (isEmailValid && isPasswordValid && !loading) ? () {
    loginWithEmailAndPassword(
        email: email,
        password: password);
  } : null;

  @computed
  bool get recoverPassPressed => (isEmailValid && !loading);

  @action
  Future<bool> loginWithGoogle() async {
    loading = true;
    try {
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      final AuthResult authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;

      currentUser = Observable(user);

      loading = false;
      loggedIn = true;
      return Future.value(true);
    } catch (error) {
      loading = false;
      loggedIn = false;
      return Future.value(false);
    }
  }

  @action
  Future<bool> loginWithFacebook() async {
    loading = true;
    try{
      final FacebookLoginResult result = await facebookLogin.logIn(['email']);

      if (result.status == FacebookLoginStatus.loggedIn) {
        final AuthCredential credential = FacebookAuthProvider.getCredential(
            accessToken: result.accessToken.token);
        final AuthResult authResult = await FirebaseAuth.instance.signInWithCredential(credential);
        final FirebaseUser user = authResult.user;

        currentUser = Observable(user);
      }
      loading = false;
      loggedIn = true;
      return Future.value(true);
    }
    catch(error){
      loading = false;
      loggedIn = false;
      return Future.value(false);
    }
  }

  @action
  Future<bool> loginWithEmailAndPassword({
    @required String email, @required String password }) async {

    loading = true;
    try{
      final AuthResult authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final FirebaseUser user = authResult.user;

      currentUser = Observable(user);

      loading = false;
      loggedIn = true;
      return Future.value(true);
    }catch(error){
      loading = false;
      loggedIn = false;
      return Future.value(false);
    }
  }

  @action
  Future<void> recoverPassword({
    @required String email,
    @required VoidCallback onSuccess, @required VoidCallback onFailure }) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      onSuccess();
    } catch (error) {
      onFailure();
    }

  }

}

