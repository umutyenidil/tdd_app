// todo: readAllUsers icin bir test yaz

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_app/core/error/exceptions.dart';
import 'package:tdd_app/core/error/failures.dart';
import 'package:tdd_app/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:tdd_app/features/auth/data/data_sources/remote/auth_remote_data_source_impl.dart';
import 'package:tdd_app/features/auth/data/repositories/auth_repository_impl.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSourceImpl {}

void main() {
  late AuthRemoteDataSource remoteDataSource;
  late AuthRepositoryImpl repositoryImpl;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();
    repositoryImpl = AuthRepositoryImpl(remoteDataSource: remoteDataSource);
  });

  group('register', () {
    const name = '_empty.name';
    const avatar = '_empty.avatar';

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
          name: name,
          avatar: avatar,
        );

        //  assert
        expect(
          result,
          equals(const Right(null)),
        );

        verify(
          () => remoteDataSource.register(name: name, avatar: avatar),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return a [ServerFailure] when the call to the remote data source is not successful',
      () async {
        const tStatusCode = 500;
        const tMessage = 'unknown';

        //  arrange
        when(
          () => remoteDataSource.register(
            name: any(named: 'name'),
            avatar: any(named: 'avatar'),
          ),
        ).thenThrow(
          const ServerException(
            message: tMessage,
            statusCode: tStatusCode,
          ),
        );

        //  act
        final result = await repositoryImpl.register(
          name: name,
          avatar: avatar,
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
            name: name,
            avatar: avatar,
          ),
        ).called(1);

        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}
