import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:iuapp/data/api/api_service.dart'; 
import 'package:iuapp/data/models/EnrollmentResponse.dart';
import 'package:iuapp/data/models/progressHistorial.dart';
import '../../constants/theme.dart';

class StudentHistoryPage extends StatefulWidget {
  final Student student;

  const StudentHistoryPage({super.key, required this.student});

  @override
  State<StudentHistoryPage> createState() => _StudentHistoryPageState();
}

class _StudentHistoryPageState extends State<StudentHistoryPage> {
  List<ProgressRecord> progressHistory = [];
  bool isLoading = true;

  Future<List<ProgressRecord>> fetchProgressHistory() async {
    try {
      final api = ApiService(Dio()); // Asegúrate de configurar el token si es necesario
      final response = await api.getProgressHistory(widget.student.id);

      return response.progress;
    } catch (e) {
      throw Exception("Error al obtener historial: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backroundGradient.colors.first,
      appBar: AppBar(
        title: Text("Historia de ${widget.student.nombres} ${widget.student.apellidoPa}",
            style: TextStyle(color: AppColors.textWhite, fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<ProgressRecord>>(
        future: fetchProgressHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No hay historial de progreso."));
          }

          final progressHistory = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: PageView.builder(
              itemCount: progressHistory.length,
              controller: PageController(viewportFraction: 0.8),
              itemBuilder: (context, index) {
                final record = progressHistory[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ProgressCard(progress: record),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ProgressCard extends StatelessWidget {
  final ProgressRecord progress;

  const ProgressCard({Key? key, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withAlpha(200),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Fecha: ${progress.date.toLocal().toIso8601String().substring(0, 10)}",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("Altura: ${progress.height} m", style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 8),
            Text("Peso: ${progress.weight} kg", style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 8),
            Text("Actividad: ${progress.activityLevels}", style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 8),
            Text("Objetivo: ${progress.objectives}", style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 8),
            Text("IMC: ${progress.imc.toStringAsFixed(2)}", style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
