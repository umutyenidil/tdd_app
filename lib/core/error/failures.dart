import 'package:equatable/equatable.dart';

abstract interface class Failure {
  final String message;

  const Failure({
    required this.message,
  });
}
