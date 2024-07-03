import 'package:appbarbearia/cadastro/login/cadastro.dart';
import 'package:appbarbearia/cadastro/login/forgetPassword.dart';
import 'package:appbarbearia/cadastro/login/login.dart';
import 'package:appbarbearia/homepage.dart';
import 'package:appbarbearia/screens/beard.dart';
import 'package:appbarbearia/screens/hair.dart';
import 'package:appbarbearia/screens/menu/perfil.dart';
import 'package:appbarbearia/screens/menu/prices.dart';
import 'package:appbarbearia/screens/menu/schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class app_widget extends StatefulWidget {
  const app_widget({super.key});

  @override
  State<app_widget> createState() => _app_widgetState();
}

class _app_widgetState extends State<app_widget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt')
      ],
      theme: ThemeData.dark(),
      initialRoute: 'login',
      routes: {
        'login': (context) => const Login(),
        'cadastro': (context) => const Cadastro(),
        'forgetPassword': (context) => const Forgetpassword(),

        'homepage': (context) => const Homepage(
          idUser: 0,
        ),

        'prices': (context) => const Prices(
          idUser: 0,
        ),
        'schedule': (context) => const Schedule(
          idUser: 0
        ),
        'perfil': (context) => const Perfil(
          idUser: 0
        ),

        'hair': (context) => const Hair(
          idUser: 0
        ),
        'beard': (context) => const Beard(
          idUser: 0
        ),
      },
    );
  }
}