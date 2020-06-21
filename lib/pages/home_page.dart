import 'package:diariosaude/pages/add_child_page.dart';
import 'package:diariosaude/pages/login_page.dart';
import 'package:diariosaude/store/child_store.dart';
import 'package:diariosaude/widgets/child_column.dart';
import 'package:diariosaude/widgets/task_container.dart';
import 'package:flutter/material.dart';
import 'package:diariosaude/themes/colors/theme_colors.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:diariosaude/widgets/top_container.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChildStore childStore = ChildStore();

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

  static CircleAvatar addIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: ThemeColors.secondary,
      child: Icon(
        Icons.add_circle,
        size: 20.0,
        color: Colors.white,
      ),
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
      body: SafeArea(
        child: Observer(builder: (_) {
          return Column(
            children: <Widget>[
              TopContainer(
                height: 200,
                width: width,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(),
                          IconButton(
                            onPressed: () {
                              loginStore.signOut();
                              if (!loginStore.loggedIn) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (_) => LoginPage()));
                              }
                            },
                            icon: Icon(Icons.exit_to_app,
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
                              center: CircleAvatar(
                                backgroundColor: ThemeColors.primaryVariant,
                                radius: 35.0,
                                backgroundImage: loginStore
                                            .currentUser.value.photoUrl
                                            .compareTo("semFoto") !=
                                        0
                                    ? Image.network(loginStore
                                            .currentUser.value.photoUrl)
                                        .image
                                    : AssetImage(
                                        'assets/images/avatar.png',
                                      ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    'Bem vindo',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    loginStore.currentUser.value.displayName,
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
                      Padding(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            subheading('Meus filhos'),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddChildPage()),
                                );
                              },
                              child: addIcon(),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                      ),
                      Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: <Widget>[
                            ChildColum(
                              icon: Icons.alarm,
                              iconBackgroundColor: ThemeColors.error,
                              name: 'Angelica Silva',
                              age: '1 ano e 5 meses',
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            ChildColum(
                              icon: Icons.blur_circular,
                              iconBackgroundColor: ThemeColors.primaryVariant,
                              name: 'Antônio Felipe',
                              age: '3 anos e 4 meses',
                            ),
                            SizedBox(height: 15.0),
                            ChildColum(
                              icon: Icons.check_circle_outline,
                              iconBackgroundColor: ThemeColors.primary,
                              name: 'Fernanda Souza',
                              age: '14 anos',
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            subheading('Próximos eventos'),
                            SizedBox(height: 5.0),
                            TaskContainer(
                              title: 'Vacina',
                              subtitle:
                                  'Dia 01 de junho, dia da vacina do Antônio Felipe',
                              boxColor: Color.fromARGB(255, 185, 232, 234),
                            ),
                            TaskContainer(
                              title: 'Pediatra',
                              subtitle:
                                  'Dia 15 de julho, levar a Angelica Silva à pediatra',
                              boxColor: Color.fromARGB(255, 185, 232, 234),
                            ),
                            TaskContainer(
                              title: 'Consulta médica',
                              subtitle:
                                  'Dia 28 de maio, levar Fernanda Souza para a consulta médica',
                              boxColor: Color.fromARGB(255, 185, 232, 234),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
