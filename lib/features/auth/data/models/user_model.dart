import 'dart:convert';

import 'package:tdd_app/features/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.avatar,
    required super.createdAt,
  });

  factory UserModel.empty() {
    return const UserModel(
      id: '0',
      name: '_empty.name',
      avatar: '_empty.avatar',
      createdAt: '_empty.createdAt',
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      avatar: map['avatar'] as String,
      createdAt: map['createdAt'] as String,
    );
  }

  factory UserModel.fromJson(String json) {
    return UserModel.fromMap(
      jsonDecode(json),
    );
  }

  UserModel copyWith({
    String? name,
    String? avatar,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar,
      'createdAt': createdAt,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
