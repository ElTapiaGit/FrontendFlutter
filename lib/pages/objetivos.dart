import 'package:flutter/material.dart';
import '../layout/sidebar.dart';
import '../theme.dart';
import '../widgets.dart';
import 'masa_muscular.dart';

class ObjetivosPage extends StatelessWidget {
  const ObjetivosPage({super.key});

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              const Text(
                "SELECCIONE SU OBJETIVO",
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
                      title: "DEFINICION",
                      imagePath: "assets/logo.png",
                      onTap: () {},
                    ),
                    CategoryCard(
                      title: "MANTENIMIENTO",
                      imagePath: "assets/logo.png",
                      onTap: () {},
                    ),
                    CategoryCard(
                      title: "AUMENTO DE MASA MUSCULAR",
                      imagePath: "assets/logo.png",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MasaMuscularPage())
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

