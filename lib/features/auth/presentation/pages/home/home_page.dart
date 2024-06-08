import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_app/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:tdd_app/features/auth/presentation/pages/home/loading_body.dart';
import 'package:tdd_app/features/auth/presentation/widgets/dialogs/add_user/add_user_dialog.dart';

class HomePage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (_) => const HomePage(),
      );

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void readUsers() {
    context.read<AuthBloc>().add(ReadUsersEvent());
  }

  @override
  void initState() {
    super.initState();

    readUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthReadUsersFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.error,
              ),
            ),
          );
        }
        if (state is AuthRegisterSuccessful) {
          readUsers();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: state is AuthReadUsersSuccessful
              ? SafeArea(
                  child: Center(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(8.0),
                      itemBuilder: (context, index) {
                        final user = state.users[index];
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              foregroundImage: NetworkImage(
                                user.avatar,
                              ),
                            ),
                            title: Text(user.name),
                            subtitle: Text(user.createdAt),
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemCount: state.users.length,
                    ),
                  ),
                )
              : const HomePageLoading(),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => const AddUserDialog(),
              );
            },
            icon: const Icon(
              Icons.add,
            ),
            label: const Text('Add User'),
          ),
        );
      },
    );
  }
}
