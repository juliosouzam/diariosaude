import 'package:diariosaude/media/media_query.dart';
import 'package:diariosaude/pages/add_child_page.dart';
import 'package:diariosaude/pages/event_all_page.dart';
import 'package:diariosaude/pages/home_page.dart';
import 'package:flutter/material.dart';


class CustomDrawer extends StatelessWidget {

  final int numero;
  CustomDrawer(this.numero);

  @override
  Widget build(BuildContext context) {

    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromARGB(100, 255, 110, 10),
                Color.fromARGB(255, 255, 255, 255),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
          )
      ),
    );
    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 20.0, top: 20.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: SizeConfig.of(context).dynamicScaleSize(size: 170, scaleFactorTablet: 2),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: SizeConfig.of(context).dynamicScaleSize(size: 30, scaleFactorTablet: 2),
                      left: SizeConfig.of(context).dynamicScaleSize(size: 70, scaleFactorTablet: 2),
                      child: Image.asset(
                        'assets/images/CECIS.png',
                        height: SizeConfig.of(context).dynamicScaleSize(size: 100, scaleFactorTablet: 2),
                        width: SizeConfig.of(context).dynamicScaleSize(size: 100, scaleFactorTablet: 2),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.home,
                  size: SizeConfig.of(context).dynamicScaleSize(size: 32, scaleFactorTablet: 2),
                  color: numero == 1 ? Color.fromARGB(255, 255, 89, 12) : Colors.black,
                ),
                title: Text("Início", style: TextStyle(
                  fontSize: SizeConfig.of(context).dynamicScaleSize(size: 20, scaleFactorTablet: 2),
                  color: numero == 1 ? Color.fromARGB(255, 255, 89, 12) : Colors.black,
                ),),
                onTap: () {
                  if(numero != 1){
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage()),
                    );
                  }
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.person_add,
                  size: SizeConfig.of(context).dynamicScaleSize(size: 32, scaleFactorTablet: 2),
                  color: numero == 2 ? Color.fromARGB(255, 255, 89, 12) : Colors.black,
                ),
                title: Text("Adicionar Filho", style: TextStyle(
                  fontSize: SizeConfig.of(context).dynamicScaleSize(size: 20, scaleFactorTablet: 2),
                  color: numero == 2 ? Color.fromARGB(255, 255, 89, 12) : Colors.black,
                ),),
                onTap: () {
                  if(numero != 2) {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddChildPage()),
                    );
                  }
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.event,
                  size: SizeConfig.of(context).dynamicScaleSize(size: 32, scaleFactorTablet: 2),
                  color: numero == 3 ? Color.fromARGB(255, 255, 89, 12) : Colors.black,
                ),
                title: Text("Eventos", style: TextStyle(
                  fontSize: SizeConfig.of(context).dynamicScaleSize(size: 20, scaleFactorTablet: 2),
                  color: numero == 3 ? Color.fromARGB(255, 255, 89, 12) : Colors.black,
                ),),
                onTap: () {
                  if(numero != 3){
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                // CreateNewTaskPage()));
                            EventAllPage()));
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }

}
