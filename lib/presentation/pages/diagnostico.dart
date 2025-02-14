import 'package:flutter/material.dart';
import '../constants/theme.dart';

class DiagnosticoPage extends StatelessWidget {
  const DiagnosticoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Extiende el fondo hasta el AppBar
      appBar: AppBar(
        title: const Text("DIAGNÓSTICO", style: TextStyle(color: AppColors.textWhite),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 80),
        decoration: const BoxDecoration(
          gradient: AppColors.backroundGradient,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagen de ancho completo
            Expanded(
              flex: 4,
              child: Image.asset(
                'assets/logo.png', // Asegúrate de que la imagen está en assets
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            // IMC
            const Text(
              "IMC - 20",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 5),

            // Estado de IMC
            const Text(
              "Normal",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 30),

            // Sección de altura y peso
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Altura
                  Column(
                    children: const [
                      Text(
                        "180 CM",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "ALTURA",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),

                  // Peso
                  Column(
                    children: const [
                      Text(
                        "80 KG",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "PESO",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
