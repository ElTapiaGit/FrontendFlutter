import 'package:flutter/material.dart';
import 'package:iuapp/pages/sedentary.dart';
import 'pages/principal.dart';
import 'pages/login/login_screen.dart';
import 'pages/menu.dart';
import 'pages/historia.dart';
import 'pages/level_activity.dart';
import 'pages/diagnostico.dart';
import 'pages/plan_aliment.dart';
import 'pages/acerca_de.dart';
import 'pages/personal_plan.dart';
import 'pages/rutina_ejercicio.dart';
import 'pages/objetivos.dart';
import 'pages/masa_muscular.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi App Flutter',
      theme: ThemeData(fontFamily: 'Roboto'),
      initialRoute: '/',
      routes: {
        '/': (context) => const PrincipalPage(),
        '/login': (context) => const ScreenLogin(),
        '/menu': (context) => const MenuPage(),
        '/historial': (context) => const HistoriaPage(),
        '/Nivel_Actividad': (context) => const ActivityPage(),
        '/sedentario': (context) => const SedentarioPage(),
        '/Notificaciones': (context) => const AcercaDePage(),
        '/diagnostico': (context) => const DiagnosticoPage(),
        '/plan_alimentacion': (context) => const PlanAlimentoPage(),
        '/plan_personalizado': (context) => const PlanPersonalPage(),
        '/rutina_ejercicio': (context) => const RutinasEjerciciosPage(),
        '/objetivos': (context) => const ObjetivosPage(),
        '/masa_muscular': (context) => const MasaMuscularPage(),
      },
    );
  }
}
