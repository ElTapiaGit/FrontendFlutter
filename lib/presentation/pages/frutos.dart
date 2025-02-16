import 'package:flutter/material.dart';
import '../constants/theme.dart'; // Archivo de tema
import '../constants/widgets.dart'; // Archivo de widgets
import 'detalles_frut.dart';

class FrutosPage extends StatelessWidget {
  const FrutosPage({super.key});

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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Imagen principal
              SizedBox(height: 10,),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/logo.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              
              // Botón "Primera Comida"
              SizedBox(
                height: 40,
                width: 200,
                child: CircularButton(
                  text: "Primera Comida",
                  gradient: AppColors.tercerButtonGradient,
                  onPressed: () {
                    // Acción del botón
                  },
                ),
              ),
              const SizedBox(height: 10),
              
              // Tabla de especificaciones
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Especificaciones", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        Chip(
                          label: Text("Dieta"),
                          backgroundColor: Colors.white24,
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    _buildInfoRow("Calorías", "110 Kcal"),
                    _buildInfoRow("Proteína", "12,01 gr"),
                    _buildInfoRow("Hidratos", "8,17 %"),
                    _buildInfoRow("Shirataki", "-"),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Botón "MAS DETALLES"
              SizedBox(
                height: 40,
                width: 400,
                child: GradientButton(
                  text: "MAS DETALLES",
                  gradient: AppColors.primaryButtonGradient,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DetallesFruta())
                    );
                  },
                  icon: Icons.arrow_forward_ios_outlined,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white)),
          Text(value, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
