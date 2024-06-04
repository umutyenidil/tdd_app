import 'dart:convert';

import 'package:tdd_app/core/utils/constants.dart';
import 'package:tdd_app/features/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;

import 'auth_remote_data_source.dart';

const kRegisterEndpoint = '/users';
const kReadUsersEndpoint = '/users';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client _client;

  const AuthRemoteDataSourceImpl({
    required http.Client client,
  }) : _client = client;

  @override
  Future<List<UserModel>> readUsers() {
    // TODO: implement readUsers
    throw UnimplementedError();
  }

  @override
  Future<void> register({
    required String name,
    required String avatar,
  }) async {
    await _client.post(
        Uri.parse('$kBaseUrl$kRegisterEndpoint'),
        body: jsonEncode({
          'name': name,
          'avatar': avatar,
          'createdAt': '_empty.createdAt',
        }),
    );
  }
}
