import 'package:firebase_auth/firebase_auth.dart';
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
  bool loggedIn = false;

  @action
  Future<bool> loginWithGoogle() async {
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

      loggedIn = true;
      return Future.value(true);
    } catch (error) {
      loggedIn = false;
      return Future.value(false);
    }
  }

  @action
  Future<bool> loginWithFacebook() async {
    try{
      final FacebookLoginResult result = await facebookLogin.logIn(['email']);

      if (result.status == FacebookLoginStatus.loggedIn) {
        final AuthCredential credential = FacebookAuthProvider.getCredential(
            accessToken: result.accessToken.token);
        final AuthResult authResult = await FirebaseAuth.instance.signInWithCredential(credential);
        final FirebaseUser user = authResult.user;

        currentUser = Observable(user);
      }
      loggedIn = true;
      return Future.value(true);
    }
    catch(error){
      loggedIn = false;
      return Future.value(false);
    }
  }

}
