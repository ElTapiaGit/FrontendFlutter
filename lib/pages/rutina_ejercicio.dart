import 'package:flutter/material.dart';
import '../constants/theme.dart';

class RutinasEjerciciosPage extends StatelessWidget {
  const RutinasEjerciciosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:  const BoxDecoration(
          gradient: AppColors.backroundGradient, //fondo
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Column(
            children: [
              // Imagen superior con título
              Stack(
                children: [
                  Image.asset(
                    'assets/logo.png', // Reemplaza con la imagen adecuada
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 110,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        'Día de Pecho',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              
              // Botones de los días de la semana
              SizedBox(
                height: 50, // Ajusta la altura según el diseño
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildDayButton('Lunes'),
                    _buildDayButton('Martes'),
                    _buildDayButton('Miércoles'),
                    _buildDayButton('Jueves'),
                    _buildDayButton('Viernes'),
                    _buildDayButton('Sábado'),
                    _buildDayButton('Domingo'),
                  ],
                ),
              ),
          
              // Lista de tarjetas de ejercicios
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(8.0),
                  children: [
                    _buildExerciseCard(),
                    _buildExerciseCard(),
                    _buildExerciseCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDayButton(String day) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: AppColors.secondaryButtonGradient,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextButton(
          onPressed: () {},
          child: Row(
            children: [
              Text(
                day,
                style: const TextStyle(
                  color: AppColors.textWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios, 
                size: 20,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExerciseCard() {
    return Card(
      color: Colors.black.withOpacity(0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Sección de texto (Título y subtítulo)
            Expanded(
              flex: 2, // Ocupa 2/3 de la tarjeta
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Ejercicio de Pecho',
                    style: TextStyle(
                      color: Colors.white, 
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Descripción del ejercicio',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Imagen (Ocupa 1/3 de la tarjeta)
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/logo.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
