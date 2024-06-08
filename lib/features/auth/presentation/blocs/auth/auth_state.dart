part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

final class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

final class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthRegisterSuccessful extends AuthState {
  const AuthRegisterSuccessful();

  @override
  List<Object?> get props => [];
}

final class AuthRegisterFailed extends AuthState {
  const AuthRegisterFailed();

  @override
  List<Object?> get props => [];
}

final class AuthReadUsersSuccessful extends AuthState {
  final List<User> users;

  const AuthReadUsersSuccessful({required this.users});

  @override
  List<Object?> get props => users.map((item) => item.id).toList();
}

final class AuthReadUsersFailed extends AuthState {
  final String error;

  const AuthReadUsersFailed({
    required this.error,
  });

  @override
  List<Object?> get props => [
        error,
      ];
}
