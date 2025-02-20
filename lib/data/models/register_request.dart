import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest {
  final String nombres;
  final String apellidoPa;
  final String apellidoMa;
  final String fechaNacimiento;
  final String genero;
  final String direccion;
  final String correo;
  final String password;

  RegisterRequest({
    required this.nombres,
    required this.apellidoPa,
    required this.apellidoMa,
    required this.fechaNacimiento,
    required this.genero,
    required this.direccion,
    required this.correo,
    required this.password,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) => _$RegisterRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
