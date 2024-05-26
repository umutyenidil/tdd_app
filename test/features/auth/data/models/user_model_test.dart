import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_app/features/auth/data/models/user_model.dart';
import 'package:tdd_app/features/auth/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tModel = UserModel.empty();

  test('should be a subclass of [User] entity', () {
    //  assert
    expect(
      tModel,
      isA<User>(),
    );
  });

  final tJson = fixture('user.json');
  final tMap = jsonDecode(tJson);

  group('fromMap', () {
    test(
      'should return a [UserModel] with the right data',
      () {
        //  act
        final result = UserModel.fromMap(tMap);
        //  assert
        expect(
          result,
          equals(tModel),
        );
      },
    );
  });

  group('fromJson', () {
    test(
      'should return a [UserModel] with the right data',
      () {
        //  act
        final result = UserModel.fromJson(tJson);
        //  assert
        expect(
          result,
          equals(tModel),
        );
      },
    );
  });

  group('toMap', () {
    test(
      'should return a [Map<String, dynamic>] with the right data',
      () {
        //  act
        final result = tModel.toMap();
        //  assert
        expect(
          result,
          equals(tMap),
        );
      },
    );
  });

  group('toJson', () {
    test(
      'should return a [JSON] string with the right data',
      () {
        //  act
        final result = tModel.toJson();
        final tJson =
            jsonEncode({"id": "0", "name": "_empty.name", "avatar": "_empty.avatar", "createdAt": "_empty.createdAt"});
        //  assert
        expect(
          result,
          equals(tJson),
        );
      },
    );
  });

  group('copyWith', () {
    test('should copy the [UserModel] with the given args', () {
      //  act
      final result = tModel.copyWith(
        name: 'Umut',
      );
      //  assert
      expect(
        result.name,
        equals('Umut'),
      );
    });
  });
}
