import 'package:diariosaude/data/child_data.dart';
import 'package:diariosaude/data/event_data.dart';
import 'package:diariosaude/pages/child_profile_page.dart';
import 'package:diariosaude/pages/event_edit_page.dart';
import 'package:diariosaude/pages/event_page.dart';
import 'package:diariosaude/themes/colors/theme_colors.dart';
import 'package:diariosaude/widgets/task_container.dart';
import 'package:diariosaude/widgets/top_container.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class EventDetailPage extends StatelessWidget {
  EventData eventData;
  ChildData childData;
  EventDetailPage(this.eventData, this.childData);
  DateFormat dateFormat = DateFormat('dd-MM-yyyy');

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
      backgroundColor: ThemeColors.secondary,
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
    return Scaffold(
      backgroundColor: ThemeColors.background,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainer(
              height: 200,
              width: width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.arrow_back,
                              color: Colors.white, size: 25.0),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          CircularPercentIndicator(
                            radius: 90.0,
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
                                            builder: (_) => ChildProfilePage(childData.cid)));
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: ThemeColors.primaryVariant,
                                    radius: 35.0,
                                    backgroundImage: NetworkImage(childData.photo),
                                  ),
                                ),
                                tag: childData.name),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  childData.name,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 22.0,
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
                                              EventEditPage(eventData, childData.cid)));
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
