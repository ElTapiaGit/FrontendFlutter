import 'package:flutter/material.dart';
import '../../constants/theme.dart';
import 'package:dio/dio.dart';
import 'package:iuapp/data/api/api_service.dart';
import 'package:iuapp/data/models/EnrollmentResponse.dart';
import 'package:iuapp/data/models/progress_model.dart';
import 'studentHistorial.dart';

class AssignRoutinePage extends StatefulWidget {
  const AssignRoutinePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AssignRoutinePageState createState() => _AssignRoutinePageState();
}

class _AssignRoutinePageState extends State<AssignRoutinePage> {
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
        title: Text("Lista de Alumnos Matriculados",
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
                                  _actionButton(Icons.fitness_center, Colors.blue, () => _mostrarModalRutina(student)),
                                  SizedBox(width: 8),
                                  _actionButton(Icons.history, Colors.orange, () => _mostrarModalPeso(student)),
                                  SizedBox(width: 8),
                                  _actionButton(Icons.history_edu, Colors.blue, () => _verHistoria(student)), 
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

  void _mostrarModalRutina(Student student) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text("Seleccione Una Rutina", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
                hint: Text("Seleccione una opción"),
                items: ["Rutina de Fuerza", "Rutina de Resistencia", "Rutina de Volumen"].map((String routine) {
                  return DropdownMenuItem<String>(
                    value: routine,
                    child: Text(routine),
                  );
                }).toList(),
                onChanged: (String? value) {},
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text("Asignar", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
    );
  }

  void _mostrarModalPeso(Student student) {
    TextEditingController pesoController = TextEditingController();
    TextEditingController alturaController = TextEditingController();
    String nivelActividad = "Sedentario"; 
    String objetivo = "Perder peso"; 
    final formKey = GlobalKey<FormState>(); // Clave para el formulario

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            "Historial",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Form(
                key: formKey, // Asigna el FormKey
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Input Peso
                    TextFormField(
                      controller: pesoController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Ingrese su peso (Kg)",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Ingrese su peso";
                        }
                        final peso = double.tryParse(value);
                        if (peso == null || peso <= 0) {
                          return "Ingrese un peso válido";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),

                    // Input Altura
                    TextFormField(
                      controller: alturaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Ingrese su altura (m)",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Ingrese su altura";
                        }
                        final altura = double.tryParse(value);
                        if (altura == null || altura <= 0) {
                          return "Ingrese una altura válida";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),

                    // Select Nivel de Actividad
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Nivel de actividad", style: TextStyle(fontWeight: FontWeight.w500)),
                        SizedBox(height: 5),
                        DropdownButtonFormField<String>(
                          value: nivelActividad,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          ),
                          items: ["Sedentario", "Actividad ligera", "Actividad moderada", "Atleta"]
                              .map((String item) => DropdownMenuItem(value: item, child: Text(item)))
                              .toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              nivelActividad = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),

                    // Select Objetivo
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Objetivo", style: TextStyle(fontWeight: FontWeight.w500)),
                        SizedBox(height: 5),
                        DropdownButtonFormField<String>(
                          value: objetivo,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          ),
                          items: ["Perder peso", "Recomposición Corporal", "Aumentar Musculo"]
                              .map((String item) => DropdownMenuItem(value: item, child: Text(item)))
                              .toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              objetivo = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Botón Asignar
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            final progress = ProgressRequest(
                              studentId: student.id,
                              weight: double.parse(pesoController.text),
                              height: double.parse(alturaController.text),
                              activityLevels: nivelActividad,
                              objectives: objetivo,
                            );

                            await apiService.createProgress(progress);
                            
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Progreso registrado con éxito")),
                            );

                            Navigator.pop(context);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Error al registrar el progreso: $e")),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text("Asignar", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}