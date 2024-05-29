import 'package:tdd_app/features/auth/data/models/user_model.dart';

import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<List<UserModel>> readUsers() {
    // TODO: implement readUsers
    throw UnimplementedError();
  }

  @override
  Future<void> register({
    required String name,
    required String avatar,
  }) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
