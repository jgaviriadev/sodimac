class ServerException implements Exception {
  final String? message;

  ServerException({
    this.message,
  }) : super();
}

class CacheException implements Exception {
  final String? message;

  CacheException({
    this.message,
  }) : super();
}

class ConnectionException implements Exception {
  final String? message;

  ConnectionException({
    this.message,
  }) : super();
}

class DataBaseException implements Exception {
  final String? message;

  DataBaseException({
    this.message,
  }) : super();
}

class UnknownException implements Exception {
  final String? message;

  UnknownException({this.message});
}

class ValidationException implements Exception {
  final String? message;

  ValidationException({this.message});
}

class CustomTimeoutException implements Exception {
  final String? message;

  CustomTimeoutException({this.message});
}

class NotFoundException implements Exception {
  final String? message;

  NotFoundException({this.message});
}

class ForbiddenException implements Exception {
  final String? message;

  ForbiddenException({this.message});
}

class UnauthorizedException implements Exception {
  final String? message;

  UnauthorizedException({this.message});
}
