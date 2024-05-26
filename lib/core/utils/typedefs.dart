import 'package:dartz/dartz.dart';
import 'package:tdd_app/core/error/failures.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
