import 'package:diariosaude/themes/colors/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:diariosaude/pages/login_page.dart';

void main() {
   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: ThemeColors.primary, // navigation bar color
    statusBarColor: ThemeColors.primary, // status bar color
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diário Saude',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 8, 77, 110),
        cursorColor: Color.fromARGB(255, 8, 77, 110),
        scaffoldBackgroundColor: Color.fromARGB(255, 8, 77, 110),
      ),
      home: LoginPage(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      debugShowCheckedModeBanner: false,
      supportedLocales: [const Locale('pt', 'BR')],
    );
  }
}
