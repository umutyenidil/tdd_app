import 'package:tdd_app/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<void> register({
    required String name,
    required String avatar,
  });

  Future<List<UserModel>> readUsers();
}
