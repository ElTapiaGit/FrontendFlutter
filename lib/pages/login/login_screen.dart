import 'package:flutter/material.dart';
import '../../theme.dart';
import '../menu.dart'; 
import 'register_data.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});
  @override
  _ScreenLoginState createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Validación de campos
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Estado de visibilidad de la contraseña
  bool _obscureText = true;
  // Estado del botón de registrarse
  bool _isPressed = false;

  // Función para manejar el login
  void _login() {
    if (_formKey.currentState!.validate()) {
      if (emailController.text == "usuario@gmail.com" && passwordController.text == "12345") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MenuPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Correo o contraseña incorrectos')),
        );
      }
    }
  }

  void _register() {
    Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const RegisterDatosScreen()),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backroundGradient, // Degradado de fondo
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Título
                Text(
                  'Inicio de sesión',
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                
                // Logo de la empresa
                Image.asset(
                  'assets/logo.png', // Asegúrate de poner el logo en la carpeta assets
                  height: 150,
                  width: 150,
                ),
                SizedBox(height: 20),
                
                // Formulario de inicio de sesión
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Campo de correo
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: AppColors.textWhite),
                        decoration: InputDecoration(
                          labelText: 'Correo electrónico',
                          labelStyle: TextStyle(color: AppColors.textWhite),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese su correo electrónico';
                          }
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return 'Por favor ingrese un correo válido';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      
                      // Campo de contraseña
                      TextFormField(
                        controller: passwordController,
                        obscureText: _obscureText,
                        style: TextStyle(color: AppColors.textWhite),
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          labelStyle: TextStyle(color: AppColors.textWhite),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2),
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColors.textWhite,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese su contraseña';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      
                      // Botón de inicio de sesión
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ).copyWith(
                          shadowColor: MaterialStateProperty.all(Colors.transparent),
                        ),
                        onPressed: _login,
                        child: Container(
                          width: 200,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryButtonGradient,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Iniciar sesión',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      
                      // Botón de registrarse
                      GestureDetector(
                        onTapDown: (_) {
                          setState(() {
                            _isPressed = true;
                          });
                        },
                        onTap: _register,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          width: 200,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: _isPressed
                                ? AppColors.secondaryButtonGradient
                                : LinearGradient(colors: [Colors.transparent, Colors.transparent]),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Registrarse',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

