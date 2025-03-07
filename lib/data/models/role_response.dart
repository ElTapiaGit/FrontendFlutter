import 'role_model.dart';

class RoleResponse {
  final List<RoleModel> roles;

  RoleResponse({required this.roles});

  factory RoleResponse.fromJson(Map<String, dynamic> json) {
    return RoleResponse(
      roles: (json["roles"] as List).map((role) => RoleModel.fromJson(role)).toList(),
    );
  }
}