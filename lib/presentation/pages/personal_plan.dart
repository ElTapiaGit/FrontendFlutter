import 'package:flutter/material.dart';
import '../layout/sidebar.dart';
import '../constants/theme.dart';
import '../constants/widgets.dart';
import 'rutina_ejercicio.dart';
import 'plan_aliment.dart';
import 'objetivos.dart';

class PlanPersonalPage extends StatelessWidget {
  const PlanPersonalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backroundGradient, // Fondo degradado
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Alinea todo a la izquierda
            children: [
              Center(
                child: const Text(
                  "PLAN DE ALIMENTACION",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20,),

              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: const Text(
                  "CATEGORÍA",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Tarjetas de categorías
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(top: 10),
                  children: [
                    CategoryCard(
                      title: "RUTINA DE EJERCICIOS",
                      imagePath: "assets/logo.png",
                      onTap:  () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RutinasEjerciciosPage())
                        );
                      },
                    ),
                    CategoryCard(
                      title: "PLAN DE ALIMENTACIÓN",
                      imagePath: "assets/logo.png",
                      onTap:  () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PlanAlimentoPage())
                        );
                      }
                    ),
                    CategoryCard(
                      title: "OBJETIVO",
                      imagePath: "assets/logo.png",
                      onTap: () {
                        // Redirige a la página de objetivos
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ObjetivosPage())
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

