import 'package:flutter/material.dart';
import '../layout/sidebar.dart';
import '../constants/theme.dart';
import '../constants/widgets.dart';


class SedentarioPage extends StatelessWidget {
  const SedentarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      appBar: AppBar(
        title: const Text("NIVEL DE ACTIVIDAD"),
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Image.asset('assets/logo.png', width: 200, height: 300),
              const SizedBox(height: 20),
              const Text(
                "SEDENTARIO",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "(No realiza ninguna actividad fisica.)",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 10),
              const Text(
                "(Usted seleccionó la opción de sedentario, gracias a esa información procederemos a planificar su dieta y rutina de ejercicios)",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              const Spacer(),//manda al final de la pantalla
              SizedBox(
                width: 200,
                child: GradientButton(
                  text: "Continuar",
                  gradient: AppColors.primaryButtonGradient,
                  onPressed: () {
                    // Aquí puedes definir la siguiente acción
                  },
                ),

              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}