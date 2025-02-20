// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Role _$RoleFromJson(Map<String, dynamic> json) => Role(
      permissions: (json['permissions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{
      'permissions': instance.permissions,
      'name': instance.name,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      nombres: json['nombres'] as String,
      apellidoPa: json['apellidoPa'] as String,
      apellidoMa: json['apellidoMa'] as String,
      correo: json['correo'] as String,
      edad: (json['edad'] as num).toInt(),
      rol: Role.fromJson(json['rol'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'nombres': instance.nombres,
      'apellidoPa': instance.apellidoPa,
      'apellidoMa': instance.apellidoMa,
      'correo': instance.correo,
      'edad': instance.edad,
      'rol': instance.rol,
    };

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      token: json['token'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
    };
