import 'package:diariosaude/data/child_data.dart';
import 'package:diariosaude/data/vacina_data.dart';
import 'package:diariosaude/media/media_query.dart';
import 'package:diariosaude/pages/child_profile_page.dart';
import 'package:diariosaude/pages/event_detail_page.dart';
import 'package:diariosaude/pages/event_page.dart';
import 'package:diariosaude/pages/home_page.dart';
import 'package:diariosaude/pages/login_page.dart';
import 'package:diariosaude/themes/colors/theme_colors.dart';
import 'package:diariosaude/widgets/custom_drawer.dart';
import 'package:diariosaude/widgets/task_container.dart';
import 'package:diariosaude/widgets/top_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ChildDetailPage extends StatefulWidget {
  final String name;
  final String age;
  final String image;
  final String cId; // child id
  final ChildData childData;

  const ChildDetailPage({Key key, this.name, this.age, this.image, this.cId, this.childData})
      : super(key: key);

  @override
  _ChildDetailPageState createState() => _ChildDetailPageState(childData);
}

class _ChildDetailPageState extends State<ChildDetailPage> {
  ChildData childData;
  _ChildDetailPageState(this.childData);
  ReactionDisposer disposer;
  DateTime idade;
  String intervalo;
  List<VacinaData> vacinas;
  List<String> nomeVacinas;

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
  void initState() {
    super.initState();

    idade = vacinaStore.transfomarStringToDate(vacinaStore.calculaIdadeDate(DateTime.now(), childData.dateBirth));
    intervalo = vacinaStore.intervaloVacina(idade);
    vacinas = vacinaStore.listVacinas.where((filter) => filter.idade.compareTo(intervalo) == 0).toList();
    nomeVacinas = vacinas.map((f) => f.nomeVacina).toList();
    String idadeACompletar = vacinaStore.idadeCompletar(idade);
    String singular = "Parabéns. Filho(a) ${childData.name + " " + idadeACompletar} Segundo o ministério da saúde, é recomendado que seja aplicado essa vacina: " + nomeVacinas.toString();
    String plural = "Parabéns. Filho(a) ${childData.name + " " + idadeACompletar} Segundo o ministério da saúde, é recomendado que sejam aplicadas essas vacinas: " + nomeVacinas.toString();
    if (vacinas.isNotEmpty) {
      SchedulerBinding.instance.addPostFrameCallback((_) =>
          showDialog(
              context: context,
              builder: (context) =>
                  AlertDialog(
                    title: Text(vacinas.length > 1 ? "Vacinas" : "Vacina",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24), ),
                    content: Text(vacinas.length > 1 ? plural : singular,
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
                    actions: <Widget>[
                      FlatButton(
                      child: Text("Ok"),
                        onPressed:  () {
                          Navigator.of(context).pop();
                        },),
                    ],
                 )));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    disposer = autorun((_) {
      eventStore.getEventos(loginStore.currentUser.value.uid);
      eventStore.getEventosFilho(loginStore.currentUser.value.uid, childData.cid);
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

  static CircleAvatar calendarIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: ThemeColors.secondary,
      child: Icon(
        Icons.calendar_today,
        size: 20.0,
        color: Colors.white,
      ),
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
      drawer: CustomDrawer(0),
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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          CircularPercentIndicator(
                            radius: SizeConfig.of(context).dynamicScaleSize(size: 90),
                            lineWidth: 5.0,
                            animation: true,
                            percent: 0.75,
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: ThemeColors.secondary,
                            backgroundColor: ThemeColors.primary,
                            center: Hero(
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => ChildProfilePage(widget.cId)));
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: ThemeColors.primaryVariant,
                                    radius: SizeConfig.of(context).dynamicScaleSize(size: 35),
                                    backgroundImage: NetworkImage(widget.image),
                                  ),
                                ),
                                tag: widget.name),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  widget.name,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: SizeConfig.of(context).dynamicScaleSize(size: 22),
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  widget.age,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: SizeConfig.of(context).dynamicScaleSize(size: 16),
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          )
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
                              children: eventStore.listEventFilterFilho.map((event){
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
