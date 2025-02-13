import 'package:flutter/material.dart';
import '../layout/sidebar.dart';
import '../constants/theme.dart';
import '../constants/widgets.dart';
import 'frutos.dart';


class PlanAlimentoPage extends StatelessWidget {
  const PlanAlimentoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      extendBodyBehindAppBar: true, // Extiende el fondo hasta el AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 80),
        decoration: const BoxDecoration(
          gradient: AppColors.backroundGradient, // Fondo degradado
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "PRIMERAS COMIDAS",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 0),

              // Tarjetas de categorías
              Expanded(
                child: ListView(
                  children: [
                    CategoryCard(
                      title: "BOWL DE AVENA CON FRUTOS ROJOS",
                      imagePath: "assets/logo.png",
                      onTap: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => const FrutosPage())
                        );
                      },
                    ),
                    CategoryCard(
                      title: "PANQUEQUES CON ARANDANOS",
                      imagePath: "assets/logo.png",
                      onTap: () {},
                    ),
                    CategoryCard(
                      title: "OMELET CON ESPINACAS Y FRESAS",
                      imagePath: "assets/logo.png",
                      onTap: () {
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MasaMuscularPage())
                        );*/
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

