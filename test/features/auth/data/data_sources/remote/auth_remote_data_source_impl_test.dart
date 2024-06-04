import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:tdd_app/core/utils/constants.dart';
import 'package:tdd_app/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:tdd_app/features/auth/data/data_sources/remote/auth_remote_data_source_impl.dart';

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
  });
}
