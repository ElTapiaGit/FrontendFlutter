// enrol_request.dart

class EnrolRequest {
  final String studentId;

  EnrolRequest({required this.studentId});

  Map<String, dynamic> toJson() {
    return {'studentId': studentId};
  }
}
