import 'package:diariosaude/store/login_store.dart';
import 'package:diariosaude/widgets/image_source_sheet.dart';
import 'package:flutter/material.dart';
import 'package:diariosaude/pages/home_page.dart';
import 'package:diariosaude/components/shared/button.dart';
import 'package:diariosaude/components/shared/input_text.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';



class SignUpPage extends StatefulWidget {

  final LoginStore loginStore;

  const SignUpPage({Key key, this.loginStore}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState(loginStore);
}

class _SignUpPageState extends State<SignUpPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final LoginStore loginStore;

  _SignUpPageState(this.loginStore){
    loadData();
  }


  String typeBlood;

  List<DropdownMenuItem<String>> listDrop = [];

  void loadData() {
    listDrop.add(new DropdownMenuItem(
      child: new Text("Tipo A+"),
      value: 'tipoA+',
    ));
    listDrop.add(new DropdownMenuItem(
      child: new Text("Tipo A-"),
      value: 'tipoA-',
    ));
    listDrop.add(new DropdownMenuItem(
      child: new Text("Tipo B+"),
      value: 'tipoB+',
    ));
    listDrop.add(new DropdownMenuItem(
      child: new Text("Tipo B-"),
      value: 'tipoB-',
    ));
    listDrop.add(new DropdownMenuItem(
      child: new Text("Tipo AB+"),
      value: 'tipoAB+',
    ));
    listDrop.add(new DropdownMenuItem(
      child: new Text("Tipo AB-"),
      value: 'tipoAB-',
    ));
    listDrop.add(new DropdownMenuItem(
      child: new Text("Tipo O+"),
      value: 'tipoO+',
    ));
    listDrop.add(new DropdownMenuItem(
      child: new Text("Tipo O-"),
      value: 'tipo0-',
    ));
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
                            'Cadastro',
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
                        Observer(builder: (_) {
                          return InputText(
                            hint: 'Nome',
                            prefix: Icon(Icons.person),
                            textInputType: TextInputType.text,
                            onChanged: loginStore.setName,
                            enabled: !loginStore.loading,
                          );
                        }),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Observer(builder: (_) {
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
                        Observer(
                          builder: (_) {
                            return InputText(
                              hint: 'Senha',
                              prefix: Icon(Icons.lock),
                              obscure: !loginStore.passwordVisible,
                              onChanged: loginStore.setPassword,
                              enabled: !loginStore.loading,
                              suffix: Button(
                                radius: 32,
                                iconData: !loginStore.passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                onTap: loginStore.togglePasswordVisibility,
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Observer(
                          builder: (_) {
                            return InputText(
                              hint: 'Confimar Senha',
                              prefix: Icon(Icons.lock),
                              obscure: !loginStore.passwordVisible,
                              onChanged: loginStore.setPasswordConfirm,
                              enabled: !loginStore.loading,
                              suffix: Button(
                                radius: 32,
                                iconData: !loginStore.passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                onTap: loginStore.togglePasswordVisibility,
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: typeBlood,
                            items: listDrop,
                            hint: Text(
                              "Tipo Sanguíneo",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            elevation: 0,
                            onChanged: (value) {
                              setState(() {
                                typeBlood = value;
                              });
                            },
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        ImageSourceSheet(),
                        const SizedBox(
                          height: 1,
                        ),
                        Observer(builder: (_) {
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
                                    : Text('Cadastrar'),
                                color: Theme.of(context).primaryColor,
                                disabledColor: Theme.of(context)
                                    .primaryColor
                                    .withAlpha(100),
                                textColor: Colors.white,
                                onPressed: loginStore.signUpPressed
                                    ? () {
                                        Map<String, dynamic> userData = {
                                          "displayName": loginStore.name,
                                          "email": loginStore.email,
                                          "date_nasc": "12/02/2020",
                                          "type_blood": typeBlood,
                                          "photoUrl":
                                              "http://www.mds.gov.br/webarquivos/arquivo/mds_pra_vc/botoes/Carta_de_Servi%C3%A7o__200x200_CIDADAO.png",
                                        };
                                        loginStore.signUp(
                                            userData: userData,
                                            password: loginStore.password);
                                      }
                                    : null),
                          );
                        }),
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

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Recuperação de Senha Enviado para o E-mail!"),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
    ));
  }

  void _onFailure() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Recuperação de Senha Falhou!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
