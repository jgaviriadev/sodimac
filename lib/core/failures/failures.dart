import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;

  const Failure({this.message});

  String get userMessage;

  bool get isDebugMode => !bool.fromEnvironment('dart.vm.product');
}

class ServerFailure extends Failure {
  const ServerFailure({super.message});

  @override
  String get userMessage => isDebugMode
      ? message ?? "Error del servidor"
      : "Ocurrió un problema. Intenta de nuevo más tarde.";

  @override
  List<Object?> get props => [message];
}

class CacheFailure extends Failure {
  const CacheFailure({super.message});

  @override
  String get userMessage => isDebugMode
      ? message ?? "Error de caché"
      : "No se pudo acceder a datos almacenados localmente.";

  @override
  List<Object?> get props => [message];
}

class ConnectionFailure extends Failure {
  const ConnectionFailure({super.message});

  @override
  String get userMessage => isDebugMode
      ? message ?? "Fallo de conexión"
      : "Verifica tu conexión a internet.";

  @override
  List<Object?> get props => [message];
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure({super.message});

  @override
  String get userMessage => isDebugMode
      ? message ?? "Autenticación fallida"
      : "Tu sesión ha expirado. Inicia sesión de nuevo.";

  @override
  List<Object?> get props => [message];
}

class SynchronizationFailure extends Failure {
  const SynchronizationFailure({super.message});

  @override
  String get userMessage => isDebugMode
      ? message ?? "Error al sincronizar"
      : "No se pudo sincronizar. Intenta más tarde.";

  @override
  List<Object?> get props => [message];
}

class DataBaseFailure extends Failure {
  const DataBaseFailure({super.message});

  @override
  String get userMessage => isDebugMode
      ? message ?? "Error de base de datos"
      : "Problema al acceder a la base de datos.";

  @override
  List<Object?> get props => [message];
}

class PermissionFailure extends Failure {
  const PermissionFailure({super.message});

  @override
  String get userMessage => isDebugMode
      ? message ?? "Permiso denegado"
      : "No tienes permiso para realizar esta acción.";

  @override
  List<Object?> get props => [message];
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({super.message});

  @override
  String get userMessage => isDebugMode
      ? message ?? "Recurso no encontrado"
      : "No se encontró la información solicitada.";

  @override
  List<Object?> get props => [message];
}

class ValidationFailure extends Failure {
  const ValidationFailure({super.message});

  @override
  String get userMessage => isDebugMode
      ? message ?? "Error de validación"
      : "Hay datos inválidos en el formulario.";

  @override
  List<Object?> get props => [message];
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({super.message});

  @override
  String get userMessage => isDebugMode
      ? message ?? "Tiempo de espera agotado"
      : "La operación tardó demasiado. Intenta de nuevo.";

  @override
  List<Object?> get props => [message];
}

class ErrorFailure extends Failure {
  const ErrorFailure({super.message});

  @override
  String get userMessage => isDebugMode
      ? message ?? "Error desconocido"
      : "Ocurrió un error inesperado. Intenta nuevamente o contacta soporte.";

  @override
  List<Object?> get props => [message];
}

