import 'dart:convert';

import 'package:tdd_app/core/error/exceptions.dart';
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
  Future<List<UserModel>> readUsers() async {
    try {
      final response = await _client.get(
        Uri.parse('$kBaseUrl$kRegisterEndpoint'),
      );

      if (response.statusCode != 200) {
        throw ServerException(
          statusCode: response.statusCode,
          message: response.body,
        );
      }

      return (List<Map<String, dynamic>>.from(jsonDecode(response.body)) as List)
          .map((data) => UserModel.fromMap(data))
          .toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: 505,
      );
    }
  }

  @override
  Future<void> register({
    required String name,
    required String avatar,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$kBaseUrl$kRegisterEndpoint'),
        body: jsonEncode({
          'name': name,
          'avatar': avatar,
          'createdAt': '_empty.createdAt',
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: 505,
      );
    }
  }
}
