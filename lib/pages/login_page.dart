import 'package:diariosaude/store/login_store.dart';
import 'package:flutter/material.dart';
import 'package:diariosaude/pages/home_page.dart';
import 'package:diariosaude/components/shared/button.dart';
import 'package:diariosaude/components/shared/input_text.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

final LoginStore loginStore = LoginStore();

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ReactionDisposer disposer;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    disposer =  reaction(
            (_) => loginStore.loggedIn,
            (loggedIn){
              if(loggedIn){
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (_) => HomePage()));
              }
            }
    );

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(32),
            child: Column(
              children: <Widget>[
                FlatButton(
                  onPressed: () {},
                  child: Image.asset(
                    'assets/images/logo-primary.png',
                    height: 180.0,
                    width: 180.0,
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 16,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Text(
                            'Entrar',
                            style: TextStyle(
                                fontFamily: 'Arial',
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                          ),
                        ),
                        Observer(builder: (_){
                          return InputText(
                            hint: 'E-mail',
                            prefix: Icon(Icons.account_circle),
                            textInputType: TextInputType.emailAddress,
                            onChanged: loginStore.setEmail,
                            enabled: !loginStore.loading,
                          );
                        }),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Observer(builder: (_){
                          return InputText(
                            hint: 'Senha',
                            prefix: Icon(Icons.lock),
                            obscure: !loginStore.passwordVisible,
                            onChanged: loginStore.setPassword,
                            enabled: !loginStore.loading,
                            suffix: Button(
                              radius: 32,
                              iconData: !loginStore.passwordVisible ? Icons.visibility : Icons.visibility_off,
                              onTap: loginStore.togglePasswordVisibility,
                            ),
                          );
                        },),
                        const SizedBox(
                          height: 1,
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: FlatButton(
                              onPressed: (){
                                if(loginStore.recoverPassPressed) {
                                  loginStore.recoverPassword(
                                      email: loginStore.email,
                                      onSuccess: _onSuccessPass,
                                      onFailure: _onFailurePass);
                                }
                                else{
                                  _onFailure();
                                }
                              },
                              child: Text(
                                "Esqueci minha senha",
                                textAlign: TextAlign.right,
                              ),
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        const SizedBox(
                          height: 1,
                        ),
                        Observer(builder: (_){
                          return SizedBox(
                            height: 44,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: loginStore.loading
                                    ? Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3.0,
                                    valueColor: AlwaysStoppedAnimation(
                                        Colors.white),
                                  ),
                                )
                                    : Text('Login'),
                                color: Theme.of(context).primaryColor,
                                disabledColor:
                                Theme.of(context).primaryColor.withAlpha(100),
                                textColor: Colors.white,
                                onPressed: loginStore.loginPressed

                            ),
                          );
                        }),
                        Align(
                          alignment: Alignment.center,
                          child: FlatButton(
                            onPressed: () {},
                            child: Text(
                              "Não, tem conta? Cadastre-se",
                              textAlign: TextAlign.right,
                            ),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                        Center(
                          child: Text(
                            'ou',
                            style: TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                              RaisedButton(
                                child: Text(
                                  'Google',
                                  style: TextStyle(fontSize: 18),
                                ),
                                textColor: Colors.white,
                                color: Color.fromRGBO(221, 75, 57, 1),
                                onPressed: () {
                                  loginStore.loginWithGoogle();

                                },
                              ),
                            SizedBox(
                              height: 16.0,
                            ),
                            RaisedButton(
                                child: Text(
                                  'Facebook',
                                  style: TextStyle(fontSize: 18),
                                ),
                                textColor: Colors.white,
                                color: Color.fromRGBO(59, 86, 157, 1),
                                onPressed: () {
                                  loginStore.loginWithFacebook();
                                },
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    disposer();
    super.dispose();
  }

  void _onSuccessPass(){
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Recuperação de Senha Enviado para o E-mail!"),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
    ));
  }
  void _onFailurePass(){
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Recuperação de Senha Falhou!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
  void _onFailure(){
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Digite um email Válido!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
