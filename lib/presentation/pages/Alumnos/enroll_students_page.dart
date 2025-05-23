import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../constants/theme.dart';
import 'package:iuapp/data/api/api_service.dart';
import 'package:iuapp/data/models/user_model.dart';
import 'package:iuapp/data/models/enrol_request.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late ApiService apiService;
  List<UserModel> users = [];
  List<UserModel> filteredUsers = [];
  bool isLoading = true;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    apiService = ApiService(Dio());
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      final response = await apiService.getUsers(1, 20);
      setState(() {
        users = response.users;
        filteredUsers = users;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al cargar usuarios: $e")),
      );
    }
  }

  void _filterUsers(String query) {
    setState(() {
      filteredUsers = query.isEmpty
          ? users
          : users.where((user) {
        final fullName = "${user.nombres} ${user.apellidoPa}".toLowerCase();
        return fullName.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de usuarios",
            style: TextStyle(color: const Color.fromARGB(255, 255, 254, 254), fontSize: 20, fontWeight: FontWeight.bold)),
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
              onChanged: _filterUsers,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(0, 0, 0, 0).withValues(alpha: 0.2),
                hintText: "Buscar",
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
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : filteredUsers.isEmpty
                  ? Center(child: Text("No se encontraron usuarios", style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255))))
                  : ListView.builder(
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) {
                  final user = filteredUsers[index];
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
                              "${user.nombres} ${user.apellidoPa}",
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            _actionButton(Icons.person, const Color.fromARGB(255, 41, 254, 48), () => _matricularUser(user)),
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
        child: Icon(icon, color: const Color.fromARGB(255, 255, 255, 255), size: 18),
      ),
    );
  }
  void _matricularUser(UserModel user) async {
    try {
      if (user.id.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("ID de usuario no válido")),
        );
        return;
      }

      // Verifica el ID antes de enviarlo
      print("ID del usuario: ${user.id}");

      // Crear una instancia de EnrolRequest con el ID del usuario
      EnrolRequest enrolRequest = EnrolRequest(studentId: user.id);

      print("JSON enviado: ${enrolRequest.toJson()}");

      // Llamar al servicio para matricular al usuario
      await apiService.enrollStudent(enrolRequest);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Alumno matriculado con éxito")),
      );
    } catch (e) {
      String errorMessage = "Error desconocido: $e";

      if (e is DioException) {
        print("Error en la API: ${e.response?.data}");

        if (e.response != null && e.response!.data != null) {
          final message = e.response!.data['message'] ?? "Error en la solicitud";

          if (message == "Estudiante no encontrado") {
            errorMessage = "El estudiante no fue encontrado";
          } else {
            errorMessage = "Error al matricular al alumno: $message";
          }
        } else {
          errorMessage = "No se recibió respuesta del servidor.";
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }


}
