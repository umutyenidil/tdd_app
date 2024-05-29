import 'package:tdd_app/core/usecase/usecase.dart';
import 'package:tdd_app/core/utils/typedefs.dart';
import 'package:tdd_app/features/auth/domain/repositories/auth_repository.dart';

class Register implements Usecase<void, RegisterParams> {
  final AuthRepository _repository;

  Register({
    required AuthRepository repository,
  }) : _repository = repository;

  @override
  ResultFuture<void> call(RegisterParams params) async {
    return await _repository.register(
      name: params.name,
      avatar: params.avatar,
    );
  }
}

class RegisterParams {
  final String name;
  final String avatar;

  const RegisterParams({
    required this.name,
    required this.avatar,
  });

  factory RegisterParams.empty() {
    return const RegisterParams(
      name: '_empty.string',
      avatar: '_empty.string',
    );
  }
}
