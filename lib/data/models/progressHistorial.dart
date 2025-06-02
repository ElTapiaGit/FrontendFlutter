class ProgressRecord {
  final String id;
  final double weight;
  final double height;
  final double imc;
  final String activityLevels;
  final String objectives;
  final DateTime date;

  ProgressRecord({
    required this.id,
    required this.weight,
    required this.height,
    required this.imc,
    required this.activityLevels,
    required this.objectives,
    required this.date,
  });

  factory ProgressRecord.fromJson(Map<String, dynamic> json) {
    return ProgressRecord(
      id: json['_id'],
      weight: (json['weight'] ?? 0).toDouble(),
      height: (json['height'] ?? 0).toDouble(),
      imc: (json['imc'] ?? 0).toDouble(),
      activityLevels: json['activityLevels'] ?? '',
      objectives: json['objectives'] ?? '',
      date: DateTime.parse(json['date']),
    );
  }
}

class ProgressResponse {
  final List<ProgressRecord> progress;

  ProgressResponse({required this.progress});

  factory ProgressResponse.fromJson(Map<String, dynamic> json) {
    var list = (json['progress'] as List)
        .map((item) => ProgressRecord.fromJson(item))
        .toList();
    return ProgressResponse(progress: list);
  }
}