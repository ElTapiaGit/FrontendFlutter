import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../constants/theme.dart';
import 'package:iuapp/data/api/api_service.dart';
import 'package:iuapp/data/models/role_model.dart' as role;
import 'package:iuapp/data/models/user_model.dart';


class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late ApiService apiService;
  List<UserModel> users = []; // Lista completa de usuarios
  List<UserModel> filteredUsers = []; // Lista filtrada para la búsqueda




  bool isLoading = true;
  String? selectedRole;
  final _formKey = GlobalKey<FormState>();
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
        filteredUsers = users; // Inicialmente, filteredUsers tiene todos los usuarios
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
      if (query.isEmpty) {
        filteredUsers = users;
      } else {
        filteredUsers = users.where((user) {
          final fullName = "${user.nombres} ${user.apellidoPa}".toLowerCase();
          return fullName.contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backroundGradient.colors.first,
      appBar: AppBar(
        title: Text(
          "Lista de usuarios",
          style: TextStyle(color: AppColors.textWhite, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo de búsqueda
            TextField(
              controller: searchController,
              onChanged: _filterUsers, // Filtrar usuarios en tiempo real
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.2),
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

            // Títulos
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Usuarios", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                Text("Acciones", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              ],
            ),
            SizedBox(height: 10),

            // Lista de usuarios con API
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : filteredUsers.isEmpty
                  ? Center(child: Text("No se encontraron usuarios", style: TextStyle(color: Colors.white)))
                  : ListView.builder(
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) {
                  final user = filteredUsers[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Datos del usuario
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.3),
                              child: Icon(Icons.person, color: Colors.white),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "${user.nombres} ${user.apellidoPa}",
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),

                        // Botones de acción
                        Row(
                          children: [
                            _actionButton(Icons.update, Colors.blue, () => _showUpdateModal(context, user)),
                            SizedBox(width: 8),
                            _actionButton(Icons.info, Colors.grey, () {}),
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
    );
  }

  // Método para crear botones de acción
  Widget _actionButton(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.8),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(6),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }

  // Método para mostrar el modal de actualización de rol
  void _showUpdateModal(BuildContext context, UserModel user) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text("Asignar un rol", style: TextStyle(fontWeight: FontWeight.bold))),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Dropdown para seleccionar el rol
               


                SizedBox(height: 20),
                // Botón de enviar
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Llamar a la API
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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

}
