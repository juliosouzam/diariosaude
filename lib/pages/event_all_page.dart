import 'package:diariosaude/data/child_data.dart';
import 'package:diariosaude/data/vacina_data.dart';
import 'package:diariosaude/media/media_query.dart';
import 'package:diariosaude/pages/child_profile_page.dart';
import 'package:diariosaude/pages/event_detail_page.dart';
import 'package:diariosaude/pages/event_page.dart';
import 'package:diariosaude/pages/home_page.dart';
import 'package:diariosaude/pages/login_page.dart';
import 'package:diariosaude/themes/colors/theme_colors.dart';
import 'package:diariosaude/widgets/button_event.dart';
import 'package:diariosaude/widgets/custom_drawer.dart';
import 'package:diariosaude/widgets/task_container.dart';
import 'package:diariosaude/widgets/top_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class EventAllPage extends StatefulWidget {

  const EventAllPage({Key key,})
      : super(key: key);

  @override
  _EventAllPageState createState() => _EventAllPageState(childData);
}

class _EventAllPageState extends State<EventAllPage> {
  ChildData childData;
  _EventAllPageState(this.childData);
  ReactionDisposer disposer;
  bool cor = true;

  static CircleAvatar addIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: ThemeColors.colorButtonAdd,
      child: Icon(
        Icons.add_circle,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    disposer = autorun((_) {
      switch(eventStore.numero) {
        case 0: {
          eventStore.getEventos(loginStore.currentUser.value.uid);
          eventStore.getEventosProximos(loginStore.currentUser.value.uid);
          break;
        }
        case 1: {
          eventStore.getEventosTodos(loginStore.currentUser.value.uid);
          break;
        }
        case 2 :{
          eventStore.getEventosVacina(loginStore.currentUser.value.uid);
          break;
        }
        case 3 :{
          eventStore.getEventosConsulta(loginStore.currentUser.value.uid);
          break;
        }
        case 4 :{
          eventStore.getEventosRotina(loginStore.currentUser.value.uid);
          break;
        }
      }
    });

  }

  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
          color: ThemeColors.foreignground,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ThemeColors.background,
      appBar: AppBar(
        title: Text("Diário Saúde"),
        centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              loginStore.signOut();
              if (!loginStore.loggedIn) {
                showAlertDialogSair(context);
              }
            },
            icon: Icon(Icons.exit_to_app,
                color: Colors.white, size: 25.0),
          )
        ],
      ),
      drawer: CustomDrawer(3),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainer(
              height: SizeConfig.of(context).dynamicScaleSize(size: 150),
              width: SizeConfig.of(context).dynamicScaleSize(size: width),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text('Eventos',
                              style: TextStyle(
                                  fontSize: SizeConfig.of(context).dynamicScaleSize(size: 30.0),
                                  fontWeight: FontWeight.w700,
                                  color: ThemeColors.background)
                          ),
                          SizedBox(width: 30),
                          Observer(builder: (_) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                ButtonEvent("Próximos", Icons.today, eventStore.numero != 0 ? !cor : cor, 0),
                                ButtonEvent("Todos", Icons.format_list_bulleted, eventStore.numero != 1 ? !cor : cor, 1),
                                ButtonEvent("Vacina", Icons.colorize, eventStore.numero != 2 ? !cor : cor, 2),
                                ButtonEvent("Consulta", Icons.local_hospital, eventStore.numero != 3 ? !cor : cor, 3),
                                ButtonEvent("Rotina", Icons.library_books, eventStore.numero != 4 ? !cor : cor, 4),
                              ],
                            );
                          }),
                        ],
                      ),
                    )
                  ]),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              subheading('Eventos'),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CreateNewTaskPage()),
                                  );
                                },
                                child: addIcon(),
                              ),
                            ],
                          ),
                          Observer(builder: (_){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: eventStore.listEventFilter.map((event){
                                return GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => EventDetailPage(event)));
                                  },
                                  child: TaskContainer(
                                    tipo: event.typeEvent,
                                    title: event.nameEvent,
                                    subtitle: event.dateEvent.day.toString() + "-" +
                                        event.dateEvent.month.toString() +"-" +
                                        event.dateEvent.year.toString() + "  " +
                                        event.descriptionEvent,
                                    boxColor: Color.fromARGB(255, 185, 232, 234),
                                  ),
                                );
                              }).toList(),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    disposer();
    super.dispose();
  }
}
