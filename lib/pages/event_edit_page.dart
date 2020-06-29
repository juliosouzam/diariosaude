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


class EventEditPage extends StatefulWidget {
  final String cId;
  EventData eventData;
  EventEditPage(this.eventData, this.cId);
  final dateFormat = DateFormat('dd-MM-yyyy');
  final timeFormat = DateFormat('HH:mm');

  @override
  _EventEditPageState createState() => _EventEditPageState(eventData, cId);
}

class _EventEditPageState extends State<EventEditPage> {

  final String cid;
  EventData eventData;
  _EventEditPageState(this.eventData, this.cid);

  static CircleAvatar removeIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: ThemeColors.secondary,
      child: Icon(
        Icons.delete,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

  DateFormat dateFormat = DateFormat('dd-MM-yyyy');

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _nomeController = TextEditingController();
  final _dateEventController = TextEditingController();
  final _hourEventController = TextEditingController();
  final _descricaoController = TextEditingController();

  @override
  void initState() {
    _nomeController.text = eventData.nameEvent;
    _dateEventController.text = dateFormat.format(eventData.dateEvent);
    _hourEventController.text = eventData.horarioEvent;
    _descricaoController.text = eventData.descriptionEvent;
    eventStore.setNomeEvent(eventData.nameEvent);
    eventStore.setDateEvent(eventData.dateEvent);
    eventStore.setHorarioEvent(eventData.horarioEvent);
    eventStore.setDescricaoEvent(eventData.descriptionEvent);
    eventStore.seTipoEvent(true, eventData.typeEvent);
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
                    //mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Editar evento',
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w700,
                              color: ThemeColors.background)),
                      GestureDetector(
                        onTap: () {
                          showAlertDialog(context, eventData);
                        },
                        child: removeIcon(),
                      ),
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
                                controller: _nomeController,
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
                                    controller: _dateEventController,
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
                        controller: _hourEventController,
                        onChanged: (value){
                          eventStore.setHorarioEvent(_hourEventController.text);
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
                                currentValue ?? eventStore.horarioEvent),
                          );
                          return DateTimeField.convert(time);
                        },
                      ),
                      SizedBox(height: 15),
                      Observer(builder: (_){
                        return TextFormField(
                          controller: _descricaoController,
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
                          eventData.nameEvent = eventStore.nomeEvent;
                          eventData.dateEvent = eventStore.dateEvent;
                          eventData.horarioEvent = eventStore.horarioEvent;
                          eventData.descriptionEvent = eventStore.descricaoEvent;
                          eventData.typeEvent = eventStore.tipoEvent;

                          bool result = false;
                          result = await eventStore.updateEventData(eventData,
                              loginStore.currentUser.value.uid);
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
                          'Atualizar evento',
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
      content: Text("Evento Atualizado com Sucesso!"),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
    ));
    Navigator.of(context).pop();
  }

  void _onFailure() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao Atualizar Evento!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }

}

showAlertDialog(BuildContext context, EventData event) {
  Widget cancelaButton = FlatButton(
    child: Text("Cancelar"),
    onPressed:  () {
      Navigator.of(context).pop();
    },
  );
  Widget continuaButton = FlatButton(
    child: Text("Continuar"),
    onPressed:  () {
      eventStore.removeEvent(event, loginStore.currentUser.value.uid);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("Deletar Evento?"),
    content: Text("Se deletar perderá todos os dados relacionados a esse Evento, Tem certeza que quer DELETAR?"),
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

