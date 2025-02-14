import 'package:flutter/material.dart';
import '../constants/theme.dart';

class RegisterDatosScreen extends StatefulWidget {
  const RegisterDatosScreen({super.key});

  @override
  _RegisterDatosScreenState createState() => _RegisterDatosScreenState();
}

class _RegisterDatosScreenState extends State<RegisterDatosScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoPaController = TextEditingController();
  final TextEditingController _apellidoMaController = TextEditingController();
  String? _sexo;
  final TextEditingController _fechaNacimientoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _passwordsMatch = true;
  bool _isPasswordVisible = false;

  void _submitForm() {
    if (_formKey.currentState!.validate()){
      //logica para enviar formulario
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Llenado de Formulario",
          style: TextStyle(color: AppColors.textWhite, fontSize: 20),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white), //color del icono de retroceso
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true, // Para que el fondo abarque la barra

      body: Container(
        height: double.infinity,
        padding: EdgeInsets.only(top: 80),
        decoration: const BoxDecoration(
          gradient: AppColors.backroundGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView( //para manejar scroll 
              child: Column(
                children: [
                  _buildTextField(_nombreController, "Nombre", validator: (value) {
                    if (value == null || value.isEmpty) return "Ingrese su Nombre";
                    return null;
                  }),
                  _buildTextField(_apellidoPaController, "Apellido Paterno"),
                  _buildTextField(_apellidoMaController, "Apellido Materno"),
                  SizedBox(height: 20),
        
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _sexo,
                          decoration: _inputDecoration("Genero"),
                          dropdownColor: Colors.blue.shade900, // Fondo del menú desplegable
                          style: const TextStyle(color: Colors.white),
                          iconSize: 20,
                          items: ["Masculino", "Femenino"].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: const TextStyle(color: Colors.white70)), // Texto blanco en el menú
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _sexo = newValue;
                            });
                          },
                          validator: (value) => value == null ? "Seleccione un genero" : null,
                        ),
                      ),

                      SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          controller: _fechaNacimientoController,
                          decoration: _inputDecoration("Fecha de Nacimiento").copyWith(
                            suffixIcon: Icon(Icons.calendar_today, color: Colors.white70),
                          ),
                          style: const TextStyle(color: Colors.white),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                           if (pickedDate != null) {
                              setState(() {
                                _fechaNacimientoController.text = "${pickedDate.toLocal()}".split(' ')[0];
                              });
                            }
                          },
                            validator: (value) => value!.isEmpty ? "Seleccione una fecha" : null,
                        ),
                      ),
                    ],
                  ),
        
                  SizedBox(height: 20),
        
                  _buildTextField(_direccionController, "Dirección"),
        
                  _buildTextField(_telefonoController, "Teléfono", 
                  keyboardType: TextInputType.phone, 
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Ingrese su Teléfono";
                    if (!RegExp(r'^[0-9]{7,15}$').hasMatch(value)) return "Ingrese un teléfono válido (7-15 dígitos)";
                    return null;
                  }),
              
                  _buildTextField(_emailController, "Correo", keyboardType: TextInputType.emailAddress, validator: (value) {
                    if (value!.isEmpty || !value.endsWith("@gmail.com")) {
                      return "Ingrese un correo Gmail válido";
                    }
                    return null;
                  }),

                  _buildPasswordField(_passwordController, "Contraseña", validator: (value) {
                    if (value!.length < 4) return "La contraseña debe tener al menos 4 caracteres";
                    return null;
                  }),
        
                  _buildTextField(_confirmPasswordController, "Confirmar Contraseña", obscureText: true, validator: (value) {
                    setState(() => _passwordsMatch = _passwordController.text == value);
                    return _passwordsMatch ? null : "Las contraseñas no coinciden";
                  }, borderColor: _passwordsMatch ? Colors.green : Colors.red),
              
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      //backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.all(0.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Color.fromARGB(0, 241, 17, 17),
                    ),
                    child: Ink(
        
                      decoration: BoxDecoration(
                        gradient: AppColors.secondaryButtonGradient,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: 200,
                          minHeight: 40,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Enviar", 
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )
                        )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {
    TextInputType keyboardType = TextInputType.text, 
    bool obscureText = false, 
    String? Function(String?)? validator, 
    Color borderColor = Colors.white
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: _inputDecoration(label).copyWith(),
        style: TextStyle(color: Colors.white),
        validator: validator, // Usamos la validación que pasemos como parámetro
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white70),
      filled: true,
      fillColor: Colors.transparent,// color de fondo de los input
      
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white60,
          width: 2,
        )
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white, width: 1), // Borde blanco sólido
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white, width: 2), // Borde blanco al enfocar
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red, width: 2), // Borde rojo en error
      ),
      errorStyle: TextStyle(
      color: Colors.white, //color de los mensajes de error
      fontSize: 14,
    ),
    );
  }

  // Widget para el campo de texto de Contraseña
  Widget _buildPasswordField(TextEditingController controller, String label, {String? Function(String?)? validator,}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: !_isPasswordVisible,  // Aquí controlamos la visibilidad
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.transparent,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white60, width: 2),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white, width: 2),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.white70,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;  // Cambiar el estado de visibilidad
              });
            },
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red, width: 2), // Borde rojo en error
          ),
          errorStyle: TextStyle(
            color: Colors.white, //color de los mensajes de error
            fontSize: 14, 
          ),
        ),
        style: TextStyle(color: Colors.white),
        validator: validator,
      ),
    );
  }
}