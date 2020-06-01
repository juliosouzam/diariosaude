import 'package:flutter/material.dart';
import 'package:diariosaude/themes/colors/theme_colors.dart';
import 'package:diariosaude/widgets/top_container.dart';
import 'package:diariosaude/widgets/my_text_field.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class CreateNewTaskPage extends StatefulWidget {
  final dateFormat = DateFormat('dd-MM-yyyy');
  final timeFormat = DateFormat('HH:mm');

  @override
  _CreateNewTaskPageState createState() => _CreateNewTaskPageState();
}

class _CreateNewTaskPageState extends State<CreateNewTaskPage> {
  String _useChisel;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ThemeColors.background,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainer(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
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
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('Novo evento',
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w700,
                              color: ThemeColors.background)),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MyTextField(
                        label: 'Título',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            child: DateTimeField(
                              format: widget.dateFormat,
                              cursorColor: Colors.white60,
                              decoration: InputDecoration(
                                hintText: 'Data',
                                hintStyle: TextStyle(color: Colors.white60),
                              ),
                              onShowPicker: (context, currentValue) {
                                return showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1990),
                                    initialDate: currentValue ?? DateTime.now(),
                                    lastDate: DateTime(2100));
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
            Expanded(
                child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  DateTimeField(
                    format: widget.timeFormat,
                    cursorColor: Colors.white60,
                    decoration: InputDecoration(
                      hintText: 'Horário',
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
                  SizedBox(height: 20),
                  MyTextField(
                    label: 'Descrição',
                    minLines: 3,
                    maxLines: 3,
                    color: Colors.black54,
                  ),
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Evento',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                          ),
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          alignment: WrapAlignment.start,
                          verticalDirection: VerticalDirection.down,
                          runSpacing: 0,
                          spacing: 10.0,
                          children: <Widget>[
                            InputChip(
                              key: ObjectKey('vacine'),
                              label: Text("Vacina"),
                              selected: _useChisel == 'vacine',
                              onSelected: (value) {
                                setState(() {
                                  _useChisel = (value ? 'vacine' : null);
                                });
                              },
                            ),
                            InputChip(
                              key: ObjectKey('consulta'),
                              selected: !!(_useChisel == 'consulta'),
                              onSelected: (value) {
                                setState(() {
                                  _useChisel = (value ? 'consulta' : null);
                                });
                              },
                              label: Text("Consulta"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
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
                      'Criar evento',
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
