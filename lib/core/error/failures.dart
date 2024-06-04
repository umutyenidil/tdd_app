import 'package:equatable/equatable.dart';
import 'package:tdd_app/core/error/exceptions.dart';

abstract class Failure extends Equatable {
  final String message;
  final int statusCode;

  const Failure({
    required this.message,
    required this.statusCode,
  });

  @override
  List<Object> get props => [
        message,
        statusCode,
      ];
}

class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    required super.statusCode,
  });

  ServerFailure.fromException(ServerException exception)
      : super(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}
