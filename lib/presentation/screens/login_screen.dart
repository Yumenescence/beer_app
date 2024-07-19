import 'package:beer_app/data/repositories/auth_repository.dart';
import 'package:beer_app/logic/blocs/auth_bloc.dart';
import 'package:beer_app/logic/states/auth_state.dart';
import 'package:beer_app/logic/states/base_state.dart';
import 'package:beer_app/presentation/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthBloc(authRepository: AuthRepository()),
        child: BlocBuilder<AuthBloc, BaseState>(
          builder: (context, state) {
            if (state is ErrorState) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is EmptyState) {
              return const Center(child: Text('No data available.'));
            } else if (state is AuthAuthenticated) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacementNamed(context, '/main');
              });
            }
            return const LoginForm();
          },
        ),
      ),
    );
  }
}
