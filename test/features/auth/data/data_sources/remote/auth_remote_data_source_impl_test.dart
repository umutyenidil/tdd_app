import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:tdd_app/core/error/exceptions.dart';
import 'package:tdd_app/core/utils/constants.dart';
import 'package:tdd_app/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:tdd_app/features/auth/data/data_sources/remote/auth_remote_data_source_impl.dart';
import 'package:tdd_app/features/auth/data/models/user_model.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = AuthRemoteDataSourceImpl(client: client);
    registerFallbackValue(Uri());
  });

  group('register', () {
    const String tName = '_empty.name';
    const String tAvatar = '_empty.avatar';
    const String tCreatedAt = '_empty.createdAt';
    test(
      'should complete successfully when the status code is 200 or 201',
      () async {
        //  arrange
        when(
          () => client.post(any(), body: any(named: 'body')),
        ).thenAnswer(
          (_) async => http.Response('User created successfully', 201),
        );

        //  act
        final methodCall = remoteDataSource.register;

        //  assert
        expect(
          methodCall(
            name: tName,
            avatar: tAvatar,
          ),
          completes,
        );
        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kRegisterEndpoint'),
            body: jsonEncode({
              'name': tName,
              'avatar': tAvatar,
              'createdAt': tCreatedAt,
            }),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );

    test(
      'should throw [ServerException] when the status code is not 200 or 201',
      () async {
        //  arrange
        when(
          () => client.post(any(), body: any(named: 'body')),
        ).thenAnswer(
          (_) async => http.Response('Invalid email address', 400),
        );

        //  act
        final methodCall = remoteDataSource.register;

        //  assert
        expect(
          () => methodCall(
            name: tName,
            avatar: tAvatar,
          ),
          throwsA(const ServerException(message: 'Invalid email address', statusCode: 400)),
        );
      },
    );
  });

  group(
    'readUsers',
    () {
      final tUsers = [UserModel.empty()];
      test(
        'should return [List<User>] when the status code is 200',
        () async {
          //  arrange
          when(
            () => client.get(any()),
          ).thenAnswer(
            (_) async => http.Response(
              jsonEncode([tUsers.first.toMap()]),
              200,
            ),
          );

          //  act
          final result = await remoteDataSource.readUsers();

          //  assert
          expect(
            result,
            equals(tUsers),
          );
          verify(
            () => client.get(
              Uri.parse('$kBaseUrl$kRegisterEndpoint'),
            ),
          ).called(1);
          verifyNoMoreInteractions(client);
        },
      );
      test(
        'should return [List<User>] when the status code is not 200',
        () async {
          const tMessage = 'hataa';
          const tStatus = 500;

          //  arrange
          when(
            () => client.get(any()),
          ).thenAnswer(
            (_) async => http.Response(tMessage, tStatus),
          );

          //  act
          final methodCall = remoteDataSource.readUsers;

          //  assert
          expect(
            methodCall,
            throwsA(
              const ServerException(statusCode: tStatus, message: tMessage),
            ),
          );

          verify(
            () => client.get(
              Uri.parse('$kBaseUrl$kReadUsersEndpoint'),
            ),
          ).called(1);

          verifyNoMoreInteractions(client);
        },
      );
    },
  );
}
