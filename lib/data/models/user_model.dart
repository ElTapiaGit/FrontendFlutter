import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class RoleModel {
  final String? id;
  final String name;
  final List<String> permissions;

  RoleModel({
    this.id,
    required this.name,
    required this.permissions,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) =>
      _$RoleModelFromJson(json);
  Map<String, dynamic> toJson() => _$RoleModelToJson(this);
}

@JsonSerializable()

class UserModel {
  final String id;
  final String nombres;
  final String apellidoPa;
  final String apellidoMa;
  final String fechaNacimiento;
  final String genero;
  final String direccion;
  final String correo;
  final int edad;
  final RoleModel? rol;

  UserModel({
    required this.id,
    required this.nombres,
    required this.apellidoPa,
    required this.apellidoMa,
    required this.fechaNacimiento,
    required this.genero,
    required this.direccion,
    required this.correo,
    required this.edad,
    this.rol,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class UserResponse {
  final List<UserModel> users;

  UserResponse({required this.users});

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
