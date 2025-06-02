import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:iuapp/data/models/EnrollmentResponse.dart';
import '../../../data/api/api_service.dart';
import '../../../data/models/mealPlanHistory.dart';
import '../../constants/theme.dart';

class HistoryDietPage extends StatefulWidget {
  final Student student;

  const HistoryDietPage({super.key, required this.student});

  @override
  _HistoryDietPageState createState() => _HistoryDietPageState();
}

class _HistoryDietPageState extends State<HistoryDietPage> {
  late ApiService apiService;
  List<MealPlan> mealPlans = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    apiService = ApiService(Dio());
    fetchMealPlan();
  }

  Future<void> fetchMealPlan() async {
    try {
      final response = await apiService.getMealPlans(widget.student.id.toString());
      setState(() {
        mealPlans = response.mealPlans;
        isLoading = false;
      });
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        setState(() {
          mealPlans = []; // No hay historial, pero no es un error crítico
          isLoading = false;
        });
      } else {
        setState(() {
          error = "Error al cargar historial: ${e.message}";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = "Error inesperado: $e";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial de Dietas - ${widget.student.nombres} ${widget.student.apellidoPa}'),
      ),
body: isLoading
    ? const Center(child: CircularProgressIndicator())
    : error != null
        ? Center(child: Text(error!))
        : mealPlans.isEmpty
            ? const Center(child: Text('No hay historial disponible.'))
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: mealPlans.length,
                itemBuilder: (context, index) {
                  final mealPlan = mealPlans[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Fecha de Inicio: ${mealPlan.startDate}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 12),
                          Text('🍳 Desayuno: ${mealPlan.breakfast.join(", ")}'),
                          Text('⏰ Hora: ${mealPlan.breakfastReminderTime}'),
                          const SizedBox(height: 8),
                          Text('🥜 Snack Mañana: ${mealPlan.snackMorning?.join(", ") ?? "No especificado"}'),
                          const SizedBox(height: 8),
                          Text('🍽️ Almuerzo: ${mealPlan.lunch.join(", ")}'),
                          Text('⏰ Hora: ${mealPlan.lunchReminderTime}'),
                          const SizedBox(height: 8),
                          Text('🍎 Snack Tarde: ${mealPlan.snackAfternoon?.join(", ") ?? "No especificado"}'),
                          const SizedBox(height: 8),
                          Text('🍲 Cena: ${mealPlan.dinner.join(", ")}'),
                          Text('⏰ Hora: ${mealPlan.dinnerReminderTime}'),
                          const SizedBox(height: 16),
                          Text('💧 Hidratación:', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('- Litros recomendados: ${mealPlan.hydration.recommendedLiters} L'),
                          Text('- Recordatorio: ${mealPlan.hydration.reminderTime}'),
                          const SizedBox(height: 16),
                          Text('📌 Recomendaciones:', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(mealPlan.recommendations ?? "no especificado"),
                          const SizedBox(height: 8),
                          Text('💊 Suplementos: ${mealPlan.supplementRecommendations ?? "No especificado"}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }
}