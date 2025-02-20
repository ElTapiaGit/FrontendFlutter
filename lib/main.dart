// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'presentation/pages/sedentary.dart';
import 'presentation/pages/principal.dart';
import 'presentation/login/login_screen.dart';
import 'presentation/pages/menu.dart';
import 'presentation/pages/admin/user_list.dart';
import 'presentation/pages/historia.dart';
import 'presentation/pages/level_activity.dart';
import 'presentation/pages/diagnostico.dart';
import 'presentation/pages/plan_aliment.dart';
import 'presentation/pages/acerca_de.dart';
import 'presentation/pages/personal_plan.dart';
import 'presentation/pages/rutina_ejercicio.dart';
import 'presentation/pages/objetivos.dart';
import 'presentation/pages/masa_muscular.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('es', 'ES')],
      debugShowCheckedModeBanner: false,
      title: 'Mi App Flutter',
      theme: ThemeData(fontFamily: 'Roboto'),
      initialRoute: '/',
      routes: {
        '/': (context) => const PrincipalPage(),
        '/login': (context) => const ScreenLogin(),
        '/menu': (context) => const MenuPage(),
        '/user_manag': (context)=> const UserListPage(),
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
      navigatorObservers: [RouteObserver()], // Aquí registramos el observer
    );
  }
}

class RouteObserver extends NavigatorObserver {
  // Observa las rutas activas
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
  }
}