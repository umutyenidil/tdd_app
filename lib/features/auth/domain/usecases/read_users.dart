import 'package:tdd_app/core/usecase/params.dart';
import 'package:tdd_app/core/usecase/usecase.dart';
import 'package:tdd_app/core/utils/typedefs.dart';
import 'package:tdd_app/features/auth/domain/entities/user.dart';

import '../repositories/auth_repository.dart';

class ReadUsers implements Usecase<List<User>, NoParams> {
  final AuthRepository _repository;

  ReadUsers({
    required AuthRepository repository,
  }) : _repository = repository;

  @override
  ResultFuture<List<User>> call(NoParams params) async {
    return await _repository.readUsers();
  }
}
