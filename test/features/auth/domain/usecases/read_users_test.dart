import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_app/core/usecase/params.dart';
import 'package:tdd_app/features/auth/domain/entities/user.dart';
import 'package:tdd_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:tdd_app/features/auth/domain/usecases/read_users.dart';

import 'auth_repository.mock.dart';

void main() {
  late AuthRepository repository;
  late ReadUsers usecase;

  setUp(() {
    repository = MAuthRepository();
    usecase = ReadUsers(repository: repository);
  });

  final tResult = [
    User.empty(),
  ];

  test(
    'should call the [AuthRepository.readUsers] and returns [List<User>]',
    () async {
      //  arrange
      when(
        () => repository.readUsers(),
      ).thenAnswer(
        (_) async => Right(tResult),
      );
      //  stub

      //  act
      final result = await usecase(NoParams());

      //  assert
      expect(
        result,
        equals(
          Right<dynamic, List<User>>(tResult),
        ),
      );

      verify(
        () => repository.readUsers(),
      ).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
