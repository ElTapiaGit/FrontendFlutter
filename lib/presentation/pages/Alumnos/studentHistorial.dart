import 'package:flutter/material.dart';
import 'package:iuapp/data/models/EnrollmentResponse.dart';
import 'package:iuapp/data/models/progressHistorial.dart';
import '../../constants/theme.dart';

class StudentHistoryPage extends StatelessWidget {
  final Student student;

  const StudentHistoryPage({super.key, required this.student});

  @override
  Widget build(BuildContext context) {

    // Ejemplo de lista de registros de progreso
    List<ProgressModel> progressHistory = [
      ProgressModel(date: "2025-03-28", height: 175, weight: 70, activityLevels: "Cardio", objectives: "Perdida de peso", imc: 22.9),
      ProgressModel(date: "2025-02-28", height: 175, weight: 72, activityLevels: "Fuerza", objectives: "Mantenimiento", imc: 23.5),
      // Agrega más registros aquí
      ProgressModel(date: "2025-01-28", height: 180, weight: 90, activityLevels: "Sedentario", objectives: "Perder peso", imc: 28.5),
      ProgressModel(date: "2025-01-29", height: 160, weight: 70, activityLevels: "Sedentario", objectives: "Perder peso", imc: 21.5),
    ];




    return Scaffold(
      backgroundColor: AppColors.backroundGradient.colors.first,
      appBar: AppBar(
        title: Text("Historia de ${student.nombres} ${student.apellidoPa}",
            style: TextStyle(color: AppColors.textWhite, fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Carrusel Horizontal
            Expanded(
              child: PageView.builder(
                itemCount: progressHistory.length, // # dinámico de tarjetas
                controller: PageController(viewportFraction: 0.8),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ProgressCard(progress: progressHistory[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProgressCard extends StatelessWidget {
  final ProgressModel progress;

  const ProgressCard({Key? key, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withValues(alpha:0.8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Fecha: ${progress.date}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Altura: ${progress.height} cm", style: TextStyle(fontSize: 14)),
            SizedBox(height: 8),
            Text("Peso: ${progress.weight} kg", style: TextStyle(fontSize: 14)),
            SizedBox(height: 8),
            Text("Actividad: ${progress.activityLevels}", style: TextStyle(fontSize: 14)),
            SizedBox(height: 8),
            Text("Objetivo: ${progress.objectives}", style: TextStyle(fontSize: 14)),
            SizedBox(height: 8),
            Text("IMC: ${progress.imc}", style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}