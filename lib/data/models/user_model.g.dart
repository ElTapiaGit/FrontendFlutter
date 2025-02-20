// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoleModel _$RoleModelFromJson(Map<String, dynamic> json) => RoleModel(
      id: json['id'] as String?,
      name: json['name'] as String,
      permissions: (json['permissions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$RoleModelToJson(RoleModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'permissions': instance.permissions,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      nombres: json['nombres'] as String,
      apellidoPa: json['apellidoPa'] as String,
      apellidoMa: json['apellidoMa'] as String,
      fechaNacimiento: json['fechaNacimiento'] as String,
      genero: json['genero'] as String,
      direccion: json['direccion'] as String,
      correo: json['correo'] as String,
      edad: (json['edad'] as num).toInt(),
      rol: json['rol'] == null
          ? null
          : RoleModel.fromJson(json['rol'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'nombres': instance.nombres,
      'apellidoPa': instance.apellidoPa,
      'apellidoMa': instance.apellidoMa,
      'fechaNacimiento': instance.fechaNacimiento,
      'genero': instance.genero,
      'direccion': instance.direccion,
      'correo': instance.correo,
      'edad': instance.edad,
      'rol': instance.rol,
    };

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      users: (json['users'] as List<dynamic>)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'users': instance.users,
    };
