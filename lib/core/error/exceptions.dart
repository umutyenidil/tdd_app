import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final String message;
  final int statusCode;

  const ServerException({
    this.message = 'unknown',
    required this.statusCode,
  });

  @override
  List<Object?> get props => [
        message,
        statusCode,
      ];
}

class CacheException implements Exception {}
