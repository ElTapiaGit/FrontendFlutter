// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(
      nombres: json['nombres'] as String,
      apellidoPa: json['apellidoPa'] as String,
      apellidoMa: json['apellidoMa'] as String,
      fechaNacimiento: json['fechaNacimiento'] as String,
      genero: json['genero'] as String,
      direccion: json['direccion'] as String,
      correo: json['correo'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'nombres': instance.nombres,
      'apellidoPa': instance.apellidoPa,
      'apellidoMa': instance.apellidoMa,
      'fechaNacimiento': instance.fechaNacimiento,
      'genero': instance.genero,
      'direccion': instance.direccion,
      'correo': instance.correo,
      'password': instance.password,
    };
