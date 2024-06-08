import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_app/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:tdd_app/features/auth/data/data_sources/remote/auth_remote_data_source_impl.dart';
import 'package:tdd_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tdd_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:tdd_app/features/auth/domain/usecases/read_users.dart';
import 'package:tdd_app/features/auth/domain/usecases/register.dart';
import 'package:tdd_app/features/auth/presentation/blocs/auth/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(client: http.Client()),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: sl<AuthRemoteDataSource>(),
      ),
    )
    ..registerFactory<Register>(
      () => Register(
        repository: sl<AuthRepository>(),
      ),
    )
    ..registerFactory<ReadUsers>(
      () => ReadUsers(
        repository: sl<AuthRepository>(),
      ),
    )
    ..registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        register: sl<Register>(),
        readUsers: sl<ReadUsers>(),
      ),
    );
}
