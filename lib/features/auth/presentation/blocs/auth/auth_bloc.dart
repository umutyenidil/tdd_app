import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_app/core/usecase/params.dart';
import 'package:tdd_app/features/auth/domain/entities/user.dart';
import 'package:tdd_app/features/auth/domain/usecases/read_users.dart';
import 'package:tdd_app/features/auth/domain/usecases/register.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Register _register;
  final ReadUsers _readUsers;

  AuthBloc({
    required Register register,
    required ReadUsers readUsers,
  })  : _register = register,
        _readUsers = readUsers,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<RegisterEvent>(onRegisterEvent);
    on<ReadUsersEvent>(onReadUsersEvent);
  }

  Future<void> onRegisterEvent(RegisterEvent event, Emitter<AuthState> emit) async {
    final result = await _register(RegisterParams(
      name: event.name,
      avatar: event.avatar,
    ));

    result.fold(
      (l) => emit(
        AuthReadUsersFailed(error: l.message),
      ),
      (r) => emit(
        const AuthRegisterSuccessful(),
      ),
    );
  }

  Future<void> onReadUsersEvent(ReadUsersEvent event, Emitter<AuthState> emit) async {
    final result = await _readUsers(NoParams());

    result.fold(
      (l) => emit(
        AuthReadUsersFailed(error: l.message),
      ),
      (r) => emit(
        AuthReadUsersSuccessful(users: r),
      ),
    );
  }
}
