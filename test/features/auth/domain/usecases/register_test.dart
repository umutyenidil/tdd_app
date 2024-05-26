import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_app/features/auth/domain/repositories/auth.dart';
import 'package:tdd_app/features/auth/domain/usecases/register.dart';

class MAuthRepository extends Mock implements AuthRepository {}

void main() {
  late Register usecase;
  late RegisterParams params;
  late AuthRepository repository;

  setUp(
    () {
      repository = MAuthRepository();
      usecase = Register(repository: repository);
    },
  );

  params = RegisterParams.empty();
  test(
    'should call the [AuthRepository.register]',
    () async {
      //  arrange

      //  stub
      when(
        () => repository.register(
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
      ).thenAnswer(
        (_) async => const Right(null),
      );

      //  act
      final result = await usecase(params);

      //  assert
      expect(
        result,
        equals(
          const Right<dynamic, void>(null),
        ),
      );

      verify(
        () => repository.register(
          name: params.name,
          avatar: params.avatar,
        ),
      ).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
