import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String avatar;
  final String createdAt;

  const User({
    required this.id,
    required this.name,
    required this.avatar,
    required this.createdAt,
  });

  factory User.empty() {
    return const User(
      id: '0',
      name: '_empty.string',
      avatar: '_empty.string',
      createdAt: '_empty.string',
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        avatar,
      ];
}
