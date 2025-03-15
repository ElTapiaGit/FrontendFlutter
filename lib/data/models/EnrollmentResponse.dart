
class EnrollmentResponse {
  final List<Enrollment> enrollments;

  EnrollmentResponse({required this.enrollments});

  factory EnrollmentResponse.fromJson(Map<String, dynamic> json) {
    return EnrollmentResponse(
      enrollments: (json['enrollments'] as List)
          .map((e) => Enrollment.fromJson(e))
          .toList(),
    );
  }
}

class Enrollment {
  final String id;
  final String instructor;
  final Student? student;
  final String enrolledAt;

  Enrollment({
    required this.id,
    required this.instructor,
    this.student,
    required this.enrolledAt,
  });

  factory Enrollment.fromJson(Map<String, dynamic> json) {
    return Enrollment(
      id: json['_id'],
      instructor: json['instructor'],
      student: json['student'] != null ? Student.fromJson(json['student']) : null,
      enrolledAt: json['enrolledAt'],
    );
  }
}

class Student {
  final String id;
  final String nombres;
  final String apellidoPa;
  final String apellidoMa;
  final String correo;

  Student({
    required this.id,
    required this.nombres,
    required this.apellidoPa,
    required this.apellidoMa,
    required this.correo,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['_id'],
      nombres: json['nombres'],
      apellidoPa: json['apellidoPa'],
      apellidoMa: json['apellidoMa'],
      correo: json['correo'],
    );
  }
}
