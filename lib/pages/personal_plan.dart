import 'package:flutter/material.dart';
import '../layout/sidebar.dart';
import '../constants/theme.dart';
import '../constants/widgets.dart';
import 'rutina_ejercicio.dart';
import 'package:iuapp/pages/plan_aliment.dart';
import 'objetivos.dart';

class PlanPersonalPage extends StatelessWidget {
  const PlanPersonalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      appBar: AppBar(
        title: const Text("PLAN PERSONALIZADO"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backroundGradient, // Fondo degradado
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "CATEGORÍA",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),

              // Tarjetas de categorías
              Expanded(
                child: ListView(
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

/*/Widget de la tarjeta de categoría
class CategoryCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell( // Detecta el toque
      onTap: onTap,
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}*/

