import 'package:flutter/material.dart';
import '../constants/theme.dart';
import '../constants/widgets.dart';

class RecoverPassPage extends StatefulWidget {
  const RecoverPassPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _RecoverPassPageSatate createState() => _RecoverPassPageSatate();
}

class _RecoverPassPageSatate extends State<RecoverPassPage> {
  final TextEditingController _emailController = TextEditingController();
   final TextEditingController _tokenController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _errorMessage;
  String? _tokenErrorMessage;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "El correo no puede estar vacío";
    }
    //validar correo electrónico
    final RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$"
    );
    if (!emailRegExp.hasMatch(value)) {
      return "Ingrese un correo válido";
    }
    return null; //Si todo está bien
  }

  void _submit() {
    setState(() {
      _errorMessage = _validateEmail(_emailController.text);
    });

    if (_errorMessage == null) {
      //logica para recuperar la contraseña
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Correo enviado con éxito")),
      );
      _showTokenDialog(); // Muestra la ventana
    }
  }

   //ventana flotante del Token
  void _showTokenDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black87, // Fondo oscuro
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Text(
            "Token de recuperación",
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Se envió un token de recuperación a su correo",
                style: TextStyle(color: Colors.white70, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),

              TextField(
                controller: _tokenController,
                keyboardType: TextInputType.number,
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Token",
                  hintStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: _tokenErrorMessage != null ? Colors.red : Colors.transparent),
                  ),
                  errorText: _tokenErrorMessage,
                ),
                onChanged: (value) {
                  setState(() {
                    _tokenErrorMessage = null; // Elimina el error al escribir
                  });
                },
              ),
            ],
          ),
          actions: [
            //Btn verificar
            SizedBox(
              width: 100,
              child: GradientButton(
                text: "Verificar",
                gradient: AppColors.primaryButtonGradient,
                onPressed: () {
                  if (_tokenController.text.isEmpty) {
                    setState(() {
                      _tokenErrorMessage = "Ingrese el token recibido";
                    });
                  } else {
                    //ventana de dialogo
                    Navigator.pop(context); //cierra el diálogo
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Token verificado con éxito")),
                    );
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.backroundGradient),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Recuperar contraseña",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
              
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: _errorMessage != null ? Colors.red : Colors.transparent,
                      ),
                    ),
                    child: TextField(
                      controller: _emailController,
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        icon: Icon(Icons.email, color: _errorMessage != null ? Colors.red : Colors.white),
                        hintText: "Correo",
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _errorMessage = null; //elimina el error cuando el usuario escribe
                        });
                      },
                    ),
                  ),
                  //Mensaje de error
                  if (_errorMessage != null)
                    Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  const SizedBox(height: 10),
              
                  const Text(
                    "Ingrese su correo de inicio de sesión",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
              
                  SizedBox(
                    height: 40,
                    width: 300,
                    child: GradientButton(
                      text: "Enviar",
                      gradient: AppColors.primaryButtonGradient,
                      onPressed: _submit,
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
}
