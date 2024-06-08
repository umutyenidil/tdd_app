import 'package:dartz/dartz.dart';
import 'package:tdd_app/core/error/exceptions.dart';
import 'package:tdd_app/core/error/failures.dart';
import 'package:tdd_app/core/utils/typedefs.dart';
import 'package:tdd_app/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:tdd_app/features/auth/domain/entities/user.dart';
import 'package:tdd_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  const AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  ResultFuture<List<User>> readUsers() async {
    try {
      final result = await _remoteDataSource.readUsers();

      return Right(result);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    }
  }

  @override
  ResultFuture<void> register({
    required String name,
    required String avatar,
  }) async {
    try {
      await _remoteDataSource.register(
        name: name,
        avatar: avatar,
      );

      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    }
  }
}
