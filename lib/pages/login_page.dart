import 'package:diariosaude/store/login_store.dart';
import 'package:flutter/material.dart';
import 'package:diariosaude/pages/home_page.dart';
import 'package:diariosaude/components/shared/button.dart';
import 'package:diariosaude/components/shared/input_text.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

final LoginStore loginStore = LoginStore();

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffolKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffolKey,
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
                        InputText(
                          hint: 'E-mail',
                          prefix: Icon(Icons.account_circle),
                          textInputType: TextInputType.emailAddress,
                          onChanged: (text) {},
                          enabled: true,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        InputText(
                          hint: 'Senha',
                          prefix: Icon(Icons.lock),
                          obscure: true,
                          onChanged: (text) {},
                          enabled: true,
                          suffix: Button(
                            radius: 32,
                            iconData: Icons.visibility,
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                            onPressed: () {},
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
                        SizedBox(
                          height: 44,
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: false == true
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
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()));
                              }),
                        ),
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
                            Observer(builder: (_) {
                              return RaisedButton(
                                child: Text(
                                  'Google',
                                  style: TextStyle(fontSize: 18),
                                ),
                                textColor: Colors.white,
                                color: Color.fromRGBO(221, 75, 57, 1),
                                onPressed: () {
                                  loginStore.loginWithGoogle();

                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (_) => HomePage()));
                                },
                              );
                            }),
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
                              onPressed: () {},
                            )
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
}
