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
      backgroundColor: AppColors.backroundGradient.colors.first,
      appBar: AppBar(
        title: Text("Lista de usuarios",
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
            // Campo de búsqueda
            TextField(
              controller: searchController,
              onChanged: _filterUsers,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.2),
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

                        // Botones de acción
                        Row(
                          children: [
                            _actionButton(Icons.update, Colors.blue,
                                    () => _showUpdateModal(context, user)),
                            SizedBox(width: 8),
                            _actionButton(Icons.info, Colors.grey,
                                    () => _showUserInfo(context, user)),
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

  // Método para mostrar el modal de asignación de rol
  void _showUpdateModal(BuildContext context, UserModel user) {
    showDialog(
      context: context,
      builder: (context) {
        return RoleAssignmentDialog(user: user);
      },
    );
  }
  // Método para construir filas de información (agrégalo en tu clase _UserListPageState)
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
            fontFamily: 'TuFuente', // Usa la fuente de tu tema
          ),
          children: [
            TextSpan(
              text: "$label ",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blue, // Usa tu color del tema
              ),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

// Método para mostrar la información del usuario
  void _showUserInfo(BuildContext context, UserModel user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
          child: Text("Detalle del usuario",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[800],
              )),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow("Nombre:", "${user.nombres} ${user.apellidoPa}"),
              _buildInfoRow("Correo:", user.correo ?? "Sin correo"),
              if (user.rol != null)
                _buildInfoRow("Rol:", user.rol!.name),
              // Agrega más campos según tu UserModel:
              // _buildInfoRow("Teléfono:", user.telefono ?? "N/A"),
              // _buildInfoRow("Estado:", user.activo ? "Activo" : "Inactivo"),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cerrar",
                style: TextStyle(color:Colors.blue)),
          ),
        ],
      ),
    );
  }

}



class RoleAssignmentDialog extends StatefulWidget {
  final UserModel user;

  const RoleAssignmentDialog({Key? key, required this.user}) : super(key: key);

  @override
  _RoleAssignmentDialogState createState() => _RoleAssignmentDialogState();
}

class _RoleAssignmentDialogState extends State<RoleAssignmentDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<role.RoleModel> roles = [];
  String? selectedRole;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRoles();
  }

  Future<void> _fetchRoles() async {
    try {
      final roleResponse = await ApiService(Dio()).getRoles();
      setState(() {
        roles = roleResponse.roles;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al cargar roles: $e")),
      );
    }
  }

  void _assignRole() async {
    if (_formKey.currentState!.validate()) {
      try {
        await ApiService(Dio()).assignRoleToUser(
          widget.user.id,
          {"rol": selectedRole}, // Enviamos el ID del rol seleccionado
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Rol asignado exitosamente")),
        );
        Navigator.pop(context, true); // Cierra el modal y devuelve `true` para refrescar la lista
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al asignar el rol: $e")),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text("Asignar un rol", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      content: Stack(
        alignment: Alignment.center,
        children: [
          // Formulario (siempre visible, pero deshabilitado durante la carga)
          Opacity(
            opacity: isLoading ? 0.5 : 1,
            child: IgnorePointer(
              ignoring: isLoading,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      ),
                      value: selectedRole,
                      hint: Text("Seleccionar un rol"),
                      items: roles.map((role) {
                        return DropdownMenuItem(
                          value: role.id.toString(),
                          child: Text(role.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedRole = value;
                        });
                      },
                      validator: (value) => value == null ? "Por favor, selecciona un rol" : null,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _assignRole,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text("Asignar", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Indicador de carga superpuesto (solo visible durante isLoading)
          if (isLoading)
            Positioned(
              child: CircularProgressIndicator(
                strokeWidth: 3, // Grosor más fino
                color: Colors.blue, // Color personalizado
              ),
            ),
        ],
      ),
    );
  }
}
