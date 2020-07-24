import 'dart:io';

import 'package:diariosaude/pages/home_page.dart';
import 'package:diariosaude/pages/login_page.dart';
import 'package:diariosaude/widgets/image_source_sheet.dart';
import 'package:flutter/material.dart';
import 'package:diariosaude/themes/colors/theme_colors.dart';
import 'package:diariosaude/widgets/top_container.dart';
import 'package:diariosaude/widgets/my_text_field.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AddChildPage extends StatefulWidget {
  final dateFormat = DateFormat('dd-MM-yyyy');
  final timeFormat = DateFormat('HH:mm');

  @override
  _AddChildPageState createState() => _AddChildPageState();
}

class _AddChildPageState extends State<AddChildPage> {
  File _image;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ThemeColors.background,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainer(
              padding: EdgeInsets.all(10),
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon:
                        Icon(Icons.arrow_back, color: Colors.white, size: 25.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Adicionar filho',
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
                                  ? Image.file(_image, width: 150, height: 150)
                                      .image
                                  : AssetImage('assets/images/avatar.png'),
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
                  SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MyTextField(
                        label: 'Nome da criança',
                        onChange: (text) {
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
                              format: widget.dateFormat,
                              cursorColor: Colors.white60,
                              decoration: InputDecoration(
                                hintText: 'Data de nascimento',
                                hintStyle: TextStyle(color: Colors.white60),
                              ),
                              onChanged: (date) {
                                childStore.dateBirth = date;
                              },
                              onShowPicker: (context, currentValue) {
                                return showDatePicker(
                                    context: context,
                                    firstDate: DateTime(2000),
                                    initialDate: currentValue ?? DateTime.now(),
                                    lastDate:
                                        DateTime(DateTime.now().year + 1));
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
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
                    format: widget.timeFormat,
                    cursorColor: Colors.white60,
                    decoration: InputDecoration(
                      hintText: 'Horário de nascimento',
                      hintStyle: TextStyle(color: Colors.black54),
                    ),
                    onChanged: (time) {
                      childStore.hourBirth = time;
                    },
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(
                            currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.convert(time);
                    },
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: MyTextField(
                        label: 'Peso',
                        color: Colors.black54,
                        colorForeignground: Colors.black54,
                        onChange: (text) {
                          childStore.weight = text;
                        },
                      )),
                      SizedBox(width: 40),
                      Expanded(
                        child: MyTextField(
                          label: 'Altura',
                          color: Colors.black54,
                          colorForeignground: Colors.black54,
                          onChange: (text) {
                            childStore.height = text;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Observer(builder: (_) {
                    return GestureDetector(
                      onTap: () async {
                        childStore.parentId = loginStore.currentUser.value.uid;
                        if (!childStore.isFormValid) {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text("Todos os campos são obrigatórios!"),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 2),
                          ));
                          return;
                        }

                        await childStore.addChild();

                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 40,
                        child: childStore.adicionando
                            ? Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 3.0,
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                ),
                              )
                            : Text(
                                'Salvar',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18),
                              ),
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                        width: width - 40,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
