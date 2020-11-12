import 'package:diariosaude/data/child_data.dart';
import 'package:diariosaude/data/event_data.dart';
import 'package:diariosaude/media/media_query.dart';
import 'package:diariosaude/pages/child_profile_page.dart';
import 'package:diariosaude/pages/event_edit_page.dart';
import 'package:diariosaude/pages/home_page.dart';
import 'package:diariosaude/pages/login_page.dart';
import 'package:diariosaude/themes/colors/theme_colors.dart';
import 'package:diariosaude/widgets/custom_drawer.dart';
import 'package:diariosaude/widgets/task_container.dart';
import 'package:diariosaude/widgets/top_container.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class EventDetailPage extends StatelessWidget {
  EventData eventData;
  EventDetailPage(this.eventData);
  DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  List<ChildData> childData = List();
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

  static CircleAvatar editIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: ThemeColors.colorButtonAdd,
      child: Icon(
        Icons.edit,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    childData = childStore.listChild.where((element) => eventData.cid == element.cid).toList();
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
              height: SizeConfig.of(context).dynamicScaleSize(size: 150.0),
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
                            radius: SizeConfig.of(context).dynamicScaleSize(size: 90.0),
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
                                            builder: (_) => ChildProfilePage(childData[0].cid)));
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: ThemeColors.primaryVariant,
                                    radius: SizeConfig.of(context).dynamicScaleSize(size: 35.0),
                                    backgroundImage: NetworkImage(childData[0].photo),
                                  ),
                                ),
                                tag: childData[0].name),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  childData[0].name,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: SizeConfig.of(context).dynamicScaleSize(size: 22.0),
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
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
                              subheading('Detalhe do Evento'),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EventEditPage(eventData, childData[0].cid)));
                                },
                                child: editIcon(),
                              ),
                            ],
                          ),
                          TaskContainer(
                            title: "Nome",
                            subtitle: eventData.nameEvent,
                            boxColor: Color.fromARGB(255, 185, 232, 234),
                          ),
                          TaskContainer(
                            title: "Data",
                            subtitle: dateFormat.format(eventData.dateEvent),
                            boxColor: Color.fromARGB(255, 185, 232, 234),
                          ),
                          TaskContainer(
                            title: "Horário",
                            subtitle: eventData.horarioEvent.toString(),
                            boxColor: Color.fromARGB(255, 185, 232, 234),
                          ),
                          TaskContainer(
                            title: "Descrição",
                            subtitle: eventData.descriptionEvent,
                            boxColor: Color.fromARGB(255, 185, 232, 234),
                          ),
                          TaskContainer(
                            title: "tipo",
                            subtitle: eventData.typeEvent,
                            boxColor: Color.fromARGB(255, 185, 232, 234),
                          ),
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
}
