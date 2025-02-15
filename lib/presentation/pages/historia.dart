import 'package:flutter/material.dart';
import '../constants/widgets.dart';
import '../layout/layout.dart';
import '../constants/theme.dart';

class HistoriaPage extends StatefulWidget {
  const HistoriaPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HistoriaPageState createState() => _HistoriaPageState();
}

class _HistoriaPageState extends State<HistoriaPage> {
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();
  String nivelActivadad = "Sedentario"; // Valor por defecto
  String objetivo = "perder peso"; //valor por defecto

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backroundGradient,
        ),
        child: Center(
          child: Padding(
            padding:  const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //titulo
                const Text(
                  "HISTORIAL",
                  style: TextStyle(color: AppColors.textWhite, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20,),
        
                //inputs
                _buildTextField("Ingrese su peso (Kg)", pesoController),
                const SizedBox(height: 20,),
                _buildTextField("Ingrese su altura (Cm)", alturaController),
                const SizedBox(height: 20,),
                // Select Nivel de Actividad
                _buildDropdown(
                  "Nivel de actividad",
                  ["Sedentario", "Actividad ligera", "Actividad moderada", "Atleta"],
                  nivelActivadad,
                  (String? newValue) {
                    setState(() {
                      nivelActivadad = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 20,),
                // Select Objetivo
                _buildDropdown(
                  "Objetivo",
                  ["perder peso", "Recomposición Corporal", "Aumentar Musculo"],
                  objetivo,
                  (String? newValue) {
                    setState(() {
                      objetivo = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 30),
        
                //boton
                SizedBox(
                  width: 250,
                  height: 60,
                  child: GradientButton(
                    text: "Continuar", 
                    gradient: AppColors.secondaryButtonGradient, 
                    onPressed: () {
                      //naviagtioon para rediregir o pasar formulario
                    },
                    icon: Icons.arrow_forward, // Icono de ">"
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
    
  // Widget para construir un Dropdown (Select)
  Widget _buildDropdown(String label, List<String> items, String value, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textWhite, fontSize: 16, fontWeight: FontWeight.w500),),
        const SizedBox(height: 5,),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFFEFEFE)),
            borderRadius: BorderRadius.circular(10),
          ),

          child: DropdownButton<String>( 
            value: value,
            isExpanded: true,
            underline: const SizedBox(),// elimina la linea predeterminada
            dropdownColor: Colors.blue,
            items: items.map((String item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item, style: TextStyle(color: AppColors.textWhite),),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
    
  //Widget para construir un input de textos
  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(controller: controller,
      keyboardType: TextInputType.number,
      style: TextStyle(color: AppColors.textWhite),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: AppColors.textWhite),
        fillColor: Colors.transparent,
        // Bordes personalizados
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white, width: 1), // Borde blanco
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white, width: 1), // Borde blanco cuando se enfoca
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1), // Borde rojo en caso de error
        ),
      ),
    );
  }
 }