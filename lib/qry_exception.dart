class QryException implements Exception {
  final String message;
  final String statusCode;
  final Map<String, dynamic> description;

  QryException({
    required this.message,
    required this.statusCode,
    required this.description,
  });
}
