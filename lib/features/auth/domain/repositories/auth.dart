import 'package:tdd_app/core/utils/typedefs.dart';
import 'package:tdd_app/features/auth/domain/entities/user.dart';

abstract interface class AuthRepository {
  ResultFuture<void> register({
    required String name,
    required String avatar,
  });

  ResultFuture<List<User>> readUsers();
}
