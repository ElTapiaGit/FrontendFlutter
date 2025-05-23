import 'package:flutter/material.dart';
import '../../constants/theme.dart';
import 'package:dio/dio.dart';
import 'package:iuapp/data/api/api_service.dart';
import 'package:iuapp/data/models/EnrollmentResponse.dart';
import 'package:iuapp/data/models/meal_plan.dart';
import 'studentHistorial.dart';

class AssignDietPage extends StatefulWidget {
  const AssignDietPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AssignDietPageState createState() => _AssignDietPageState();
}

class _AssignDietPageState extends State<AssignDietPage> {
  final TextEditingController searchController = TextEditingController();
  late ApiService apiService; // Se inicializa en initState()
  List<Student> students = [];
  List<Student> filteredStudents = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    apiService = ApiService(Dio()); // Se inicializa aquí
    fetchEnrollments();
  }

  // Método para obtener los alumnos matriculados desde la API
  Future<void> fetchEnrollments() async {
    try {
      final response = await apiService.getEnrollments();
      setState(() {
        students = response.enrollments
            .map((enrollment) => enrollment.student!)
            .whereType<Student>() // Filtra nulos y asegura el tipo correcto
            .toList();
        filteredStudents = students;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al cargar matriculados: $e")),
      );
    }
  }

  // Método para filtrar alumnos en la búsqueda
  void _filterStudents(String query) {
    setState(() {
      filteredStudents = query.isEmpty
          ? students
          : students.where((student) {
            final fullName ="${student.nombres} ${student.apellidoPa}".toLowerCase();
            return fullName.contains(query.toLowerCase());
          }).toList();
    });
  }

  //aquí se enviará la solicitud a la API
  void _verHistoria(Student student) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentHistoryPage(student: student),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Asignar Dieta a Alumnos",
            style: TextStyle(color: AppColors.textWhite, fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: AppColors.backroundGradient.colors[0],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backroundGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: _filterStudents,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.2),
                hintText: "Buscar Estudiante",
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Usuarios", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                Text("Acciones", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: filteredStudents.isEmpty
                  ? Center(child: Text("No se encontraron alumnos matriculados", style: TextStyle(color: Colors.white)))
                  : ListView.builder(
                      itemCount: filteredStudents.length,
                      itemBuilder: (context, index) {
                        final student = filteredStudents[index];  // Obtener el estudiante actual
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white.withValues(alpha: 0.3),
                                    child: Icon(Icons.person, color: Colors.white),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "${student.nombres} ${student.apellidoPa}",
                                    style: TextStyle(fontSize: 16, color: Colors.white),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  _actionButton(Icons.restaurant_menu, Colors.green, () => _mostrarModalAsignarDieta(student)),
                                  SizedBox(width: 8),
                                  _actionButton(Icons.receipt_long, Colors.orange, () => _verHistoria(student)), 
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    )
    );
  }

  Widget _actionButton(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(6),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }

  void _mostrarModalAsignarDieta(Student student) {
    final _formKey = GlobalKey<FormState>();

    // Controladores para los campos individuales
    final TextEditingController startDateController = TextEditingController();
    final TextEditingController breakfastController = TextEditingController();
    final TextEditingController breakfastReminderTimeController = TextEditingController();
    final TextEditingController snackMorningController = TextEditingController();
    final TextEditingController lunchController = TextEditingController();
    final TextEditingController lunchReminderTimeController = TextEditingController();
    final TextEditingController snackAfternoonController = TextEditingController();
    final TextEditingController dinnerController = TextEditingController();
    final TextEditingController dinnerReminderTimeController = TextEditingController();
    final TextEditingController hydrationLitersController = TextEditingController();
    final TextEditingController hydrationReminderTimeController = TextEditingController();
    final TextEditingController recommendationsController = TextEditingController();
    final TextEditingController supplementRecommendationsController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text("Asignar Dieta", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(startDateController, "Fecha de Inicio (YY-MM-DD)", isDate: true),
                _buildTextField(breakfastController, "Desayuno (separa con coma)"),
                _buildTimeField(breakfastReminderTimeController, "Recordatorio Desayuno (HH:MM)"),
                _buildTextField(snackMorningController, "Snack Mañana (separa con coma)"),
                _buildTextField(lunchController, "Almuerzo (separa con coma)"),
                _buildTimeField(lunchReminderTimeController, "Recordatorio Almuerzo (HH:MM)"),
                _buildTextField(snackAfternoonController, "Snack Tarde (separa con coma)"),
                _buildTextField(dinnerController, "Cena (separa con coma)"),
                _buildTimeField(dinnerReminderTimeController, "Recordatorio Cena (HH:MM)"),
                _buildTextField(hydrationLitersController, "Litros Recomendados", isDecimal: true),
                _buildTimeField(hydrationReminderTimeController, "Recordatorio Hidratación (HH:MM)"),
                _buildTextField(recommendationsController, "Recomendaciones"),
                _buildTextField(supplementRecommendationsController, "Recomendaciones Suplementos"),
                
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final mealPlan = MealPlan(
                        studentId: student.id,
                        startDate: startDateController.text,
                        breakfast: breakfastController.text.split(',').map((e) => e.trim()).toList(),
                        breakfastReminderTime: breakfastReminderTimeController.text,
                        snackMorning: snackMorningController.text.split(',').map((e) => e.trim()).toList(),
                        lunch: lunchController.text.split(',').map((e) => e.trim()).toList(),
                        lunchReminderTime: lunchReminderTimeController.text,
                        snackAfternoon: snackAfternoonController.text.split(',').map((e) => e.trim()).toList(),
                        dinner: dinnerController.text.split(',').map((e) => e.trim()).toList(),
                        dinnerReminderTime: dinnerReminderTimeController.text,
                        hydration: Hydration(
                          recommendedLiters: double.tryParse(hydrationLitersController.text) ?? 0,
                          reminderTime: hydrationReminderTimeController.text,
                        ),
                        recommendations: recommendationsController.text,
                        supplementRecommendations: supplementRecommendationsController.text,
                      );

                      final dio = Dio();
                      final apiService = ApiService(dio);

                      try {
                        await apiService.createMealPlan(mealPlan);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Dieta asignada exitosamente')),
                        );
                      } catch (e) {
                        print('Error asignando dieta: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error al asignar dieta')),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text("Asignar", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool isDate = false, bool isDecimal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextFormField(
        controller: controller,
        keyboardType: isDecimal ? TextInputType.numberWithOptions(decimal: true) : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          suffixIcon: isDate ? Icon(Icons.calendar_today, color: Colors.black) : null,
        ),
        style: TextStyle(color: Colors.black),
        readOnly: isDate, // Solo es "readOnly" si es un campo de fecha
        onTap: isDate
          ? () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                locale: const Locale('es', 'ES'),
              );
              if (pickedDate != null) {
                setState(() {
                  controller.text = "${pickedDate.toLocal()}".split(' ')[0]; // Formato YYYY-MM-DD
                });
              }
            }
          : null,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Campo requerido';
          }

          // Validación de hora en formato HH:MM (24 horas)
          if (isDate && !RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value)) {
            return 'Formato de fecha incorrecto (YY-MM-DD)';
          }

          if (isDecimal && !RegExp(r'^\d+(\.\d+)?$').hasMatch(value)) {
            return 'Ingresa un número válido (ej. 1.5)';
          }

          return null;
        },
      ),
    );
  }
  // Función para el selector de hora
  Widget _buildTimeField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          suffixIcon: Icon(Icons.access_time, color: Colors.black),
        ),
        style: TextStyle(color: Colors.black),
        readOnly: true,
        onTap: () async {
          TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                child: child!,
              );
            },
          );

          if (pickedTime != null) {
            final String formatted = pickedTime.hour.toString().padLeft(2, '0') +
              ':' +
              pickedTime.minute.toString().padLeft(2, '0');
            setState(() {
              controller.text = formatted;
            });
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Campo requerido';
          }
          // Validación básica de formato HH:MM (24 horas)
          if (!RegExp(r'^\d{2}:\d{2}$').hasMatch(value)) {
            return 'Formato de hora incorrecto (HH:MM)';
          }
          return null;
        },
      ),
    );
  }

}