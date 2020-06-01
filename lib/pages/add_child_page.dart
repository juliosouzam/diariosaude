import 'dart:io';

import 'package:diariosaude/widgets/image_source_sheet.dart';
import 'package:flutter/material.dart';
import 'package:diariosaude/themes/colors/theme_colors.dart';
import 'package:diariosaude/widgets/top_container.dart';
import 'package:diariosaude/widgets/my_text_field.dart';
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ThemeColors.background,
      body: SafeArea(
        child: Column(
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
                                          print(image.path);

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
                      MyTextField(
                        label: 'Nome da criança',
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
                    format: widget.timeFormat,
                    cursorColor: Colors.white60,
                    decoration: InputDecoration(
                      hintText: 'Horário de nascimento',
                      hintStyle: TextStyle(color: Colors.black54),
                    ),
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
                      )),
                      SizedBox(width: 40),
                      Expanded(
                        child: MyTextField(
                          label: 'Altura',
                          color: Colors.black54,
                          colorForeignground: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
            Container(
              height: 80,
              width: width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: Text(
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
                      color: ThemeColors.success,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
