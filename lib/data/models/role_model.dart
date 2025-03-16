class RoleModel {
  final String id;
  final String name;
  final List<String> permissions;

  RoleModel({required this.id, required this.name, required this.permissions});

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      id: json["_id"],
      name: json["name"],
      permissions: List<String>.from(json["permissions"]),
    );
  }
}

