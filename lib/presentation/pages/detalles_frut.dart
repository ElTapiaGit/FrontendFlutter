import 'package:flutter/material.dart';
import '../constants/theme.dart';
import '../constants/widgets.dart'; 

class DetallesFruta extends StatelessWidget {
  const DetallesFruta({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white), // Cambia el color del icono de back
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backroundGradient, // Fondo degradado
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📌 Imagen superior
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Image.asset(
                'assets/logo.png', // Asegúrate de cambiar esto con la imagen correcta
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          
            const SizedBox(height: 20),
          
            //Contenedor con detalles
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: double.infinity,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      //Título
                      const Text(
                        "PRIMERA COMIDA",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                          
                      //Lista de ingredientes
                      const Text(
                        "• Bowl de avena con frutos rojos\n"
                        "• 100 gr de avena\n"
                        "• 100 gr de frutos rojos\n"
                        "• Endulzante a gusto\n"
                        "• Agua o leche (opcional)",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          
            const SizedBox(height: 20),
        
            //Boton
            Center(
              child: SizedBox(
                height: 40,
                width: 300,
                child: GradientButton(
                  text: "MARCAR COMO HECHO",
                  onPressed: () {
                    // Acción cuando se presiona el botón
                  },
                  icon: Icons.arrow_forward_ios, // Icono del botón
                  gradient: AppColors.secondaryButtonGradient,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
