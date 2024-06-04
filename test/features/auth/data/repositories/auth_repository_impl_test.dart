// todo: readAllUsers icin bir test yaz

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_app/core/error/exceptions.dart';
import 'package:tdd_app/core/error/failures.dart';
import 'package:tdd_app/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:tdd_app/features/auth/data/data_sources/remote/auth_remote_data_source_impl.dart';
import 'package:tdd_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tdd_app/features/auth/domain/entities/user.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSourceImpl {}

void main() {
  late AuthRemoteDataSource remoteDataSource;
  late AuthRepositoryImpl repositoryImpl;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();
    repositoryImpl = AuthRepositoryImpl(remoteDataSource: remoteDataSource);
  });

  const tStatusCode = 500;
  const tMessage = 'unknown';
  const tException = ServerException(
    statusCode: tStatusCode,
    message: tMessage,
  );

  group(
    'register',
    () {
      const tName = '_empty.name';
      const tAvatar = '_empty.avatar';

      test(
        'should call the [AuthRemoteDataSource.register] and complete successfully when the call to the remote source is successful',
        () async {
          //  arrange
          when(
            () => remoteDataSource.register(
              name: any(named: 'name'),
              avatar: any(named: 'avatar'),
            ),
          ).thenAnswer(
            (_) async => Future.value(),
          );

          //  act
          final result = await repositoryImpl.register(
            name: tName,
            avatar: tAvatar,
          );

          //  assert
          expect(
            result,
            equals(const Right(null)),
          );

          verify(
            () => remoteDataSource.register(name: tName, avatar: tAvatar),
          ).called(1);
          verifyNoMoreInteractions(remoteDataSource);
        },
      );

      test(
        'should return a [ServerFailure] when the call to the remote data source is not successful',
        () async {
          //  arrange
          when(
            () => remoteDataSource.register(
              name: any(named: 'name'),
              avatar: any(named: 'avatar'),
            ),
          ).thenThrow(tException);

          //  act
          final result = await repositoryImpl.register(
            name: tName,
            avatar: tAvatar,
          );

          //  assert
          expect(
            result,
            equals(
              const Left(
                ServerFailure(
                  message: tMessage,
                  statusCode: tStatusCode,
                ),
              ),
            ),
          );

          verify(
            () => remoteDataSource.register(
              name: tName,
              avatar: tAvatar,
            ),
          ).called(1);

          verifyNoMoreInteractions(remoteDataSource);
        },
      );
    },
  );

  group(
    'readUsers',
    () {
      test(
        'should call the [AuthRemoteDataSource.readUsers] and return [List<User>] when call to remote data source is successful',
        () async {
          //  arrange
          when(
            () => remoteDataSource.readUsers(),
          ).thenAnswer(
            (_) async => [],
          );

          //  act
          final result = await repositoryImpl.readUsers();

          //  assert
          expect(
            result,
            isA<Right<dynamic, List<User>>>(),
          );

          verify(
            () => remoteDataSource.readUsers(),
          ).called(1);

          verifyNoMoreInteractions(remoteDataSource);
        },
      );

      test(
        'should call the [AuthRemoteDataSource.readUsers] and return [ServerFailure] when call to remote data source is failed',
        () async {
          //  arrange
          when(
            () => remoteDataSource.readUsers(),
          ).thenThrow(tException);

          //  act
          final result = await repositoryImpl.readUsers();

          //  assert
          expect(
            result,
            equals(
              Left(ServerFailure.fromException(tException)),
            ),
          );

          verify(
            () => remoteDataSource.readUsers(),
          ).called(1);

          verifyNoMoreInteractions(remoteDataSource);
        },
      );
    },
  );
}
