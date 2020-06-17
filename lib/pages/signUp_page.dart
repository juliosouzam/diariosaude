import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:diariosaude/store/login_store.dart';
import 'package:flutter/material.dart';
import 'package:diariosaude/components/shared/button.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';



class SignUpPage extends StatefulWidget {

  final LoginStore loginStore;

  const SignUpPage({Key key, this.loginStore}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState(loginStore);
}


class _SignUpPageState extends State<SignUpPage> {

  @override
  void initState() {
    loginStore.setEmail("");
    loginStore.setName("");
    loginStore.setPassword("");
    loginStore.setPasswordConfirm("");
    loginStore.setDateNasc("");
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final LoginStore loginStore;

  _SignUpPageState(this.loginStore){
    loadData();
  }
  final format = DateFormat("dd-MM-yyyy");
  final _dateNasciController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
                    child: Form(
                      key: _formKey,
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
                            return TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                icon: Icon(Icons.person),
                                hintText: 'Nome',
                                //errorText: loginStore.isNameValid ? null : "Campo Nome é obrigatório!",
                              ),
                              validator: (value){
                                if(loginStore.isNameValid) {
                                  return null;
                                }
                                return "Campo Nome é obrigatório!";
                              },
                              keyboardType: TextInputType.text,
                              onChanged: loginStore.setName,
                              enabled: !loginStore.loading,
                            );
                          }),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Observer(builder: (_) {
                            return TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                icon: Icon(Icons.account_circle),
                                hintText: 'E-mail',
                                //errorText: loginStore.isEmailValid ? null : "Digite um E-mail Válido!"
                              ),
                              validator: (value){
                                if(loginStore.isEmailValid){
                                  return null;
                                }
                                return "Digite um E-mail Válido!";
                              },
                              keyboardType: TextInputType.emailAddress,
                              onChanged: loginStore.setEmail,
                              enabled: !loginStore.loading,
                            );
                          }),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Observer(
                            builder: (_) {
                              return TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Icon(Icons.lock),
                                  hintText: 'Senha',
                                  //errorText: loginStore.isPasswordValid ? null : "A senha deve ter no minimo 6 caracteres",
                                  suffixIcon: Button(
                                    radius: 32,
                                    iconData: !loginStore.passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    onTap: loginStore.togglePasswordVisibility,
                                  ),
                                ),
                                validator: (value){
                                  if(loginStore.isPasswordValid){
                                    return null;
                                  }
                                  return "A senha deve ter no minimo 6 caracteres";
                                },
                                obscureText: !loginStore.passwordVisible,
                                onChanged: loginStore.setPassword,
                                enabled: !loginStore.loading,
                              );
                            },
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Observer(
                            builder: (_) {
                              return TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Icon(Icons.lock),
                                  hintText: 'Confimar Senha',
                                  //errorText: loginStore.isPasswordConfirmValid ? null : "Confimação de Senha deve ser igual a Senha!",
                                  suffixIcon: Button(
                                    radius: 32,
                                    iconData: !loginStore.passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    onTap: loginStore.togglePasswordVisibility,
                                  ),
                                ),
                                validator: (value){
                                  if(loginStore.isPasswordConfirmValid){
                                    return null;
                                  }
                                  return "Confimação de Senha deve ser igual a Senha!";
                                },
                                obscureText: !loginStore.passwordVisible,
                                onChanged: loginStore.setPasswordConfirm,
                                enabled: !loginStore.loading,
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

                          DateTimeField(
                              controller: _dateNasciController,
                              format: format,
                              onChanged: (value){
                                loginStore.setDateNasc(_dateNasciController.text);
                              },
                              decoration: InputDecoration(
                                  hintText: "Data de Nascimento",
                                  suffixIcon: Icon(Icons.date_range),
                                  //errorText: loginStore.isDateNascValid ? null : "Campo Data de Nascimento Obrigatório!"
                              ),
                              validator: (value){
                                if(loginStore.isDateNascValid){
                                  return null;
                                }
                                return "Campo Data de Nascimento Obrigatório!";
                              },
                              style: TextStyle(fontSize: 14.0, color: Colors.grey),
                              onShowPicker: (context, currentValue) {
                                return showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1920),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime.now(),
                                );
                              },
                            ),
                          const SizedBox(
                            height: 10.0,
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
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      Map<String, dynamic> userData = {
                                        "displayName": loginStore.name,
                                        "email": loginStore.email,
                                        "date_nasc": loginStore.dateNasc,
                                        "type_blood": typeBlood,
                                        "photoUrl": "http://www.mds.gov.br/webarquivos/arquivo/mds_pra_vc/botoes/Carta_de_Servi%C3%A7o__200x200_CIDADAO.png",
                                      };
                                      loginStore.signUp(
                                          userData: userData,
                                          password: loginStore.password);
                                    }
                                  }
                              ),
                            );
                          }),
                        ],
                      ),
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
    _dateNasciController.dispose();
    super.dispose();
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
