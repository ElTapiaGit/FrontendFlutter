// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'progress_model.g.dart';

@JsonSerializable() // Indica que esta clase debe tener métodos de serialización automática
class ProgressRequest {
  //representan los datos del progreso
  final String studentId;
  final double weight;
  final double height;
  final String activityLevels;
  final String objectives;


  // Constructor de la clase Progress.
  ProgressRequest({
    required this.studentId,
    required this.weight,
    required this.height,
    required this.activityLevels,
    required this.objectives,
  });

  // Método que genera un objeto Progress desde JSON
  factory ProgressRequest.fromJson(Map<String, dynamic> json) => _$ProgressRequestFromJson(json);
  // Método que convierte un objeto Progress a JSON
  Map<String, dynamic> toJson() => _$ProgressRequestToJson(this);
}
  