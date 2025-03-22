import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../constants/theme.dart';
import '../pages/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iuapp/data/models/login_request.dart';
import 'package:iuapp/data/api/api_service.dart';
import 'register_data.dart';
import 'recover_pass.dart';


class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _ScreenLoginState createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _isPressed = false;
  bool _isLoading = false;
  final ApiService apiService = ApiService(Dio());

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        final response = await apiService.login(
          LoginRequest(
            correo: emailController.text,
            password: passwordController.text,
          ),
        );

        // Guardar token y datos del usuario en SharedPreferences
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.token);
        await prefs.setString('user_id', response.user.id);
        await prefs.setString('user_name', response.user.nombres);
        await prefs.setString('role_name', response.user.rol.name);
        await prefs.setStringList('permissions', response.user.rol.permissions);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MenuPage()),
        );
      } catch (e) {
        String errorMessage = 'Error al iniciar sesión';
        if (e is DioException) {
          if (e.response?.data != null && e.response?.data['message'] != null) {
            errorMessage = e.response?.data['message'];
          }
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _recover() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const RecoverPassPage()),
    );
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
          gradient: AppColors.backroundGradient,
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Inicio de sesión',
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Image.asset(
                  'assets/logo.png',
                  height: 150,
                  width: 150,
                ),
                SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Colors.white,
                        style: TextStyle(color: AppColors.textWhite),
                        decoration: InputDecoration(
                          labelText: 'Correo electrónico',
                          labelStyle: TextStyle(color: AppColors.textWhite),
                          filled: true,
                          fillColor: Colors.white.withValues(alpha: 0.2),
                          border: OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.email, color: Colors.white),
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
                      TextFormField(
                        controller: passwordController,
                        obscureText: _obscureText,
                        cursorColor: Colors.white,
                        style: TextStyle(color: AppColors.textWhite),
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          labelStyle: TextStyle(color: AppColors.textWhite),
                          filled: true,
                          fillColor: Colors.white.withValues(alpha: 0.2),
                          border: OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.lock, color: Colors.white),
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
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: _recover,
                          child: Text(
                            '¿Olvidaste tu contraseña?',
                            style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                      _isLoading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ).copyWith(
                          shadowColor: WidgetStateProperty.all(Colors.transparent),
                        ),
                        onPressed: _login,
                        child: Container(
                          width: 300,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryButtonGradient,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                offset: Offset(0, 4),
                                blurRadius: 6,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Iniciar sesión',
                            style: TextStyle(color: Colors.white, fontSize: 20),
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
                          width: 300,
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
                              fontSize: 18.0,
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
