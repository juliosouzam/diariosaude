import 'package:diariosaude/data/event_data.dart';
import 'package:diariosaude/pages/child_detail_page.dart';
import 'package:diariosaude/pages/login_page.dart';
import 'package:diariosaude/store/event_store.dart';
import 'package:flutter/material.dart';
import 'package:diariosaude/themes/colors/theme_colors.dart';
import 'package:diariosaude/widgets/top_container.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:mobx/mobx.dart';


class CreateNewTaskPage extends StatefulWidget {
  final String cId;
  CreateNewTaskPage(this.cId);
  final dateFormat = DateFormat('dd-MM-yyyy');
  final timeFormat = DateFormat('HH:mm');

  @override
  _CreateNewTaskPageState createState() => _CreateNewTaskPageState(cId);
}

class _CreateNewTaskPageState extends State<CreateNewTaskPage> {

  final String cid;
  _CreateNewTaskPageState(this.cid);

  final _horarioController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    eventStore.setNomeEvent("");
    eventStore.setDateEvent(null);
    eventStore.setHorarioEvent("");
    eventStore.setDescricaoEvent("");
    eventStore.seTipoEvent(true, "");
    super.initState();
  }



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
                  SizedBox(height: 15),
                  Form(
                    key: _formKey,
                    child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Observer(builder: (_){
                              return TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Icon(Icons.title),
                                  hintText: 'Título',
                                ),
                                validator: (value){
                                  if(eventStore.isNomeValid){
                                    return null;
                                  }
                                  return "Campo Título é Obrigatório";
                                },
                                onChanged: eventStore.setNomeEvent,
                                enabled: !eventStore.loading,
                              );
                            }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Expanded(
                                  child: DateTimeField(
                                    format: widget.dateFormat,
                                    onChanged: (value){
                                      eventStore.setDateEvent(value);
                                    },
                                    validator: (value){
                                      if(eventStore.isDateValid){
                                        return null;
                                      }
                                      return "Campo Data é Obrigatório!";
                                    },
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
                        )),
                  )
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      DateTimeField(
                        controller: _horarioController,
                        onChanged: (value){
                          eventStore.setHorarioEvent(_horarioController.text);
                        },
                        validator: (value){
                          if(eventStore.isHorarioValid){
                            return null;
                          }
                          return "Campo Horário é Obrigatório!";
                        },
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
                      SizedBox(height: 15),
                      Observer(builder: (_){
                        return TextFormField(
                          maxLines: 3,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.description),
                            hintText: 'Descrição',
                          ),
                          validator: (value){
                            if(eventStore.isDescricaoValid){
                              return null;
                            }
                            return "Campo Descrição é Obrigatório!";
                          },
                          onChanged: eventStore.setDescricaoEvent,
                          enabled: !eventStore.loading,
                        );
                      }),
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
                                Observer(builder: (_){
                                  return InputChip(
                                      key: ObjectKey('vacine'),
                                      label: Text("Vacina"),
                                      selected: eventStore.tipoEvent == "vacina",
                                      onSelected: (value){
                                        eventStore.seTipoEvent(value, "vacina");
                                      }
                                  );
                                }),
                                Observer(builder: (_){
                                  return InputChip(
                                    key: ObjectKey('consulta'),
                                    selected: !!(eventStore.tipoEvent == "consulta"),
                                    onSelected: (value){
                                      eventStore.seTipoEvent(value, "consulta");
                                    },
                                    label: Text("Consulta"),
                                  );
                                }),
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
                  Observer(builder:(_){
                    return GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState.validate()) {
                          EventData eventData = EventData();
                          eventData.nameEvent = eventStore.nomeEvent;
                          eventData.dateEvent = eventStore.dateEvent;
                          eventData.horarioEvent = eventStore.horarioEvent;
                          eventData.descriptionEvent = eventStore.descricaoEvent;
                          eventData.typeEvent = eventStore.tipoEvent;

                          bool result = false;
                          result = await eventStore.addEventData(eventData,
                                      loginStore.currentUser.value.uid, cid);
                          if(result){
                            _onSuccess();
                          }
                          else{
                            _onFailure();
                          }
                        }

                      },
                      child: Container(
                        child: eventStore.loading
                            ? Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 3.0,
                            valueColor: AlwaysStoppedAnimation(
                                Colors.white),
                          ),
                        )
                            :Text(
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
                    );
                  }),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Evento Criado com Sucesso!"),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
    ));
    Navigator.of(context).pop();
  }

  void _onFailure() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao criar Evento!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }

}

