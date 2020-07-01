import 'dart:io';

import 'package:diariosaude/data/child_data.dart';
import 'package:diariosaude/pages/home_page.dart';
import 'package:diariosaude/pages/login_page.dart';
import 'package:diariosaude/store/child_store.dart';
import 'package:diariosaude/widgets/image_source_sheet.dart';
import 'package:flutter/material.dart';
import 'package:diariosaude/themes/colors/theme_colors.dart';
import 'package:diariosaude/widgets/top_container.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

ChildData childData;

class ChildProfilePage extends StatefulWidget {
  final String cId;

  ChildProfilePage(this.cId);

  @override
  _ChildProfilePage createState() => _ChildProfilePage(cId);
}

class _ChildProfilePage extends State<ChildProfilePage> {
  final String cId;
  _ChildProfilePage(this.cId);
  DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  DateFormat timeFormat = DateFormat('HH:mm');

  File _image;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _nomeController = TextEditingController();
  final _dateNasciController = TextEditingController();
  final _hourNasciController = TextEditingController();
  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();


  @override
  void initState() {
    super.initState();
    childData = childStore.getChild(cId);
      _nomeController.text = childData.name;
      _dateNasciController.text = dateFormat.format(childData.dateBirth);
      _hourNasciController.text = timeFormat.format(childData.hourBirth);
      _pesoController.text =childData.weight;
      _alturaController.text = childData.height;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    childStore.name = childData.name;
    childStore.dateBirth = childData.dateBirth;
    childStore.hourBirth = childData.hourBirth;
    childStore.weight = childData.weight;
    childStore.height = childData.height;

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ThemeColors.background,
      body: SafeArea(
        child:  Column(
          children: <Widget>[
            TopContainer(
              padding: EdgeInsets.all(20),
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back,
                        color: Colors.white, size: 25.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Editar Perfil',
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w700,
                              color: ThemeColors.background)),
                      Column(
                        children: <Widget>[
                          CircularPercentIndicator(
                            radius: 90.0,
                            lineWidth: 5.0,
                            animation: true,
                            percent: 0.75,
                            reverse: true,
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: ThemeColors.secondary,
                            backgroundColor: ThemeColors.primary,
                            center: CircleAvatar(
                              backgroundColor: ThemeColors.primaryVariant,
                              radius: 35.0,
                              backgroundImage: _image != null
                                  ? Image.file(_image,
                                  width: 150, height: 150)
                                  .image
                                  : NetworkImage(childData.photo)
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) => ImageSourceSheet(
                                    onImageSelected: (image) {
                                      setState(() {
                                        _image = image;
                                      });
                                      childStore.photo = image;

                                      Navigator.of(context).pop();
                                    },
                                  ));
                            },
                            child: Text('Alterar imagem'),
                            textColor: Colors.white60,
                          )
                        ],
                      )
                    ],
                  ),
                  Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            controller: _nomeController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              icon: Icon(Icons.account_circle),
                              hintText: 'Nome',
                            ),
                            keyboardType: TextInputType.text,
                            onChanged: (text){
                              childStore.name = text;
                            },
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Expanded(
                                child: DateTimeField(
                                  controller: _dateNasciController,
                                  format: dateFormat,
                                  cursorColor: Colors.white60,
                                  decoration: InputDecoration(
                                    hintText: 'Data de nascimento',
                                    suffixIcon: Icon(Icons.date_range),
                                    hintStyle: TextStyle(color: Colors.white60),
                                  ),
                                  onChanged: (date) {
                                    childStore.dateBirth = date;
                                  },
                                  onShowPicker: (context, currentValue) {
                                    return showDatePicker(
                                        context: context,
                                        firstDate: DateTime(2000),
                                        initialDate:
                                        currentValue ?? childStore.dateBirth,
                                        lastDate:
                                        DateTime(DateTime.now().year + 1));
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ))
                ],
              ),
            ),
            SizedBox(height: 5),
            Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      DateTimeField(
                        controller: _hourNasciController,
                        format: timeFormat,
                        cursorColor: Colors.white60,
                        decoration: InputDecoration(
                          hintText: 'Horário de nascimento',
                          suffixIcon: Icon(Icons.access_alarm),
                          hintStyle: TextStyle(color: Colors.black54),
                        ),
                        onChanged: (time) {
                          childStore.hourBirth = time;
                        },
                        onShowPicker: (context, currentValue) async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                                currentValue ?? childStore.hourBirth),
                          );
                          return DateTimeField.convert(time);
                        },
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                              child: TextFormField(
                                controller: _pesoController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Peso',
                                ),
                                keyboardType: TextInputType.text,
                                onChanged: (text){
                                  childStore.weight = text;
                                },
                              ),
                          ),
                          SizedBox(width: 40),
                          Expanded(
                            child: TextFormField(
                              controller: _alturaController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Altura',
                              ),
                              keyboardType: TextInputType.text,
                              onChanged: (text){
                                childStore.height = text;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Salvar',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                    color: Theme.of(context).primaryColor,
                    disabledColor: Theme.of(context).primaryColor.withAlpha(100),
                    textColor: Colors.white,
                    onPressed: () {
                      childStore.parentId = loginStore.currentUser.value.uid;
                      if (!childStore.isFormValid) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text("Todos os campos são obrigatórios!"),
                          backgroundColor: Colors.redAccent,
                          duration: Duration(seconds: 2),
                        ));
                        return;
                      }

                      childStore.updateChild(childData.photo, childData.cid);

                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      //pushReplacement(
                      //    MaterialPageRoute(
                      //        builder: (_) => HomePage()));
                    }),
                SizedBox(
                  width: 20,
                ),
                RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Deletar',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                    color: Theme.of(context).primaryColor,
                    disabledColor: Theme.of(context).primaryColor.withAlpha(100),
                    textColor: Colors.white,
                    onPressed: () {
                      showAlertDialog(context);

                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
showAlertDialog(BuildContext context) {
  Widget cancelaButton = FlatButton(
    child: Text("Cancelar"),
    onPressed:  () {
      Navigator.of(context).pop();
    },
  );
  Widget continuaButton = FlatButton(
    child: Text("Continuar"),
    onPressed:  () {
      childStore.parentId = loginStore.currentUser.value.uid;
      childStore.removeChild(childData.photo, childData.cid);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("Deletar filho?"),
    content: Text("Se deletar perderá todos os dados relacionados ao filho, Tem certeza que quer DELETAR?"),
    actions: [
      cancelaButton,
      continuaButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
