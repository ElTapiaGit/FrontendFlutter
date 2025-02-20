import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class Role {
  final List<String> permissions;
  final String name;

  Role({required this.permissions, required this.name});

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);
  Map<String, dynamic> toJson() => _$RoleToJson(this);
}

@JsonSerializable()
class User {
  final String id;
  final String nombres;
  final String apellidoPa;
  final String apellidoMa;
  final String correo;
  final int edad;
  final Role rol;

  User({
    required this.id,
    required this.nombres,
    required this.apellidoPa,
    required this.apellidoMa,
    required this.correo,
    required this.edad,
    required this.rol,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class LoginResponse {
  final String token;
  final User user;

  LoginResponse({required this.token, required this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
