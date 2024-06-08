part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class RegisterEvent extends AuthEvent {
  final String name;
  final String avatar;

  const RegisterEvent({
    required this.name,
    required this.avatar,
  });

  @override
  List<Object?> get props => [
    name,
    avatar,
  ];
}

class ReadUsersEvent extends AuthEvent{

}
