import 'package:tdd_app/features/auth/domain/entities/user.dart';

abstract interface class AuthRepository {
  Future<(Exception, void)> register({
    required String name,
    required String avatar,
  });

  Future<List<User>> readAll();
}
