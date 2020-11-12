import 'package:diariosaude/media/media_query.dart';
import 'package:diariosaude/pages/home_page.dart';
import 'package:diariosaude/pages/login_page.dart';
import 'package:diariosaude/themes/colors/theme_colors.dart';
import 'package:flutter/material.dart';


class ButtonEvent extends StatelessWidget {

  final String nome;
  final IconData image;
  final bool cor;
  final int numero;
  ButtonEvent(this.nome, this.image, this.cor, this.numero);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Hero(
          child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              style: BorderStyle.solid,
              width: 2.0,
              color: cor ? Colors.white : Colors.black,
            ),
            color: cor ? Colors.white : Colors.black,
          ),
          child: GestureDetector(
              onTap: (){
                eventStore.setNumero(numero);
                switch(numero) {
                  case 0 :{
                    eventStore.getEventosProximos(loginStore.currentUser.value.uid);
                    break;
                  }
                  case 1 :{
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
              },
              child: Icon(
                  image,
                  size: SizeConfig.of(context).dynamicScaleSize(size: 40),
                  color: cor ? ThemeColors.colorButtonAdd : Colors.white,
              ),
            ),
          ),
          tag: nome,
        ),
        Container(
          child: Text(
            nome,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: SizeConfig.of(context).dynamicScaleSize(size: 16),
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

}
