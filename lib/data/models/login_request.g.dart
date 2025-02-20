// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
      correo: json['correo'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'correo': instance.correo,
      'password': instance.password,
    };
